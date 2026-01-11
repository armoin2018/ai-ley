#!/bin/bash
# scripts/setup-logging-stack.sh - Enterprise ELK stack deployment

set -euo pipefail

ELASTIC_VERSION="8.8.0"
ENVIRONMENT="${1:-development}"
LOG_RETENTION_DAYS="${2:-30}"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a /var/log/elk-setup.log
}

log "Starting ELK stack deployment for $ENVIRONMENT environment..."

# Install Java (required for Elasticsearch)
log "Installing Java runtime..."
apt-get update -q
apt-get install -y openjdk-11-jdk

# Add Elastic repository
log "Adding Elastic repository..."
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-8.x.list
apt-get update -q

# Install Elasticsearch
log "Installing Elasticsearch $ELASTIC_VERSION..."
apt-get install -y elasticsearch=$ELASTIC_VERSION

# Configure Elasticsearch for Vagrant environment
log "Configuring Elasticsearch..."
cat > /etc/elasticsearch/elasticsearch.yml << EOF
# Vagrant Enterprise Elasticsearch Configuration
cluster.name: vagrant-${ENVIRONMENT}-logs
node.name: \${HOSTNAME}
path.data: /var/lib/elasticsearch
path.logs: /var/log/elasticsearch

# Network configuration
network.host: 0.0.0.0
http.port: 9200
discovery.type: single-node

# Security configuration
xpack.security.enabled: false
xpack.security.http.ssl.enabled: false
xpack.security.transport.ssl.enabled: false

# Performance tuning
bootstrap.memory_lock: true

# Index lifecycle management
action.destructive_requires_name: true
indices.lifecycle.history_index_enabled: true
EOF

# Set heap size based on available memory
MEMORY_GB=$(free -g | awk '/^Mem:/{print int($2/2)}')
if [ $MEMORY_GB -gt 4 ]; then
    HEAP_SIZE="4g"
elif [ $MEMORY_GB -gt 2 ]; then
    HEAP_SIZE="${MEMORY_GB}g"
else
    HEAP_SIZE="1g"
fi

sed -i "s/#-Xms1g/-Xms$HEAP_SIZE/" /etc/elasticsearch/jvm.options
sed -i "s/#-Xmx1g/-Xmx$HEAP_SIZE/" /etc/elasticsearch/jvm.options

systemctl daemon-reload
systemctl enable elasticsearch
systemctl start elasticsearch

# Wait for Elasticsearch to be ready
log "Waiting for Elasticsearch to be ready..."
until curl -s -f http://localhost:9200/_cluster/health; do
    sleep 5
done

# Install Logstash
log "Installing Logstash..."
apt-get install -y logstash=$ELASTIC_VERSION

# Configure Logstash pipeline
log "Configuring Logstash pipeline..."
mkdir -p /etc/logstash/conf.d

cat > /etc/logstash/conf.d/vagrant-pipeline.conf << EOF
input {
  beats {
    port => 5044
  }

  file {
    path => "/vagrant/logs/*.log"
    start_position => "beginning"
    tags => ["vagrant", "application"]
  }

  syslog {
    port => 514
    tags => ["syslog", "system"]
  }
}

filter {
  # Add environment metadata
  mutate {
    add_field => {
      "environment" => "$ENVIRONMENT"
      "infrastructure" => "vagrant"
    }
  }

  # Parse different log types
  if "application" in [tags] {
    if [message] =~ /^\{.*\}$/ {
      json {
        source => "message"
      }
    } else {
      grok {
        match => {
          "message" => "%{TIMESTAMP_ISO8601:timestamp} %{LOGLEVEL:log_level} %{GREEDYDATA:log_message}"
        }
      }
    }

    if [timestamp] {
      date {
        match => [ "timestamp", "ISO8601" ]
      }
    }
  }

  if "syslog" in [tags] {
    grok {
      match => {
        "message" => "%{SYSLOGTIMESTAMP:timestamp} %{IPORHOST:host} %{DATA:program}(?:\\[%{POSINT:pid}\\])?: %{GREEDYDATA:log_message}"
      }
    }
  }

  # Parse web access logs
  if [fields][log_type] == "access" {
    grok {
      match => { "message" => "%{COMBINEDAPACHELOG}" }
    }

    if [timestamp] {
      date {
        match => [ "timestamp", "dd/MMM/yyyy:HH:mm:ss Z" ]
      }
    }
  }

  # GeoIP enrichment for web logs
  if [clientip] {
    geoip {
      source => "clientip"
    }
  }
}

output {
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "vagrant-%{environment}-%{+YYYY.MM.dd}"

    # Apply index template
    template_name => "vagrant-logs"
    template => "/etc/logstash/templates/vagrant-template.json"
    template_overwrite => true
  }

  # Debug output in development
  if "${ENVIRONMENT}" == "development" {
    stdout {
      codec => rubydebug
    }
  }
}
EOF

# Create index template
mkdir -p /etc/logstash/templates
cat > /etc/logstash/templates/vagrant-template.json << EOF
{
  "index_patterns": ["vagrant-*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0,
    "index.lifecycle.name": "vagrant-logs-policy",
    "index.lifecycle.rollover_alias": "vagrant-logs",
    "index.refresh_interval": "10s"
  },
  "mappings": {
    "properties": {
      "@timestamp": {
        "type": "date"
      },
      "message": {
        "type": "text",
        "analyzer": "standard"
      },
      "environment": {
        "type": "keyword"
      },
      "infrastructure": {
        "type": "keyword"
      },
      "host": {
        "properties": {
          "name": {
            "type": "keyword"
          }
        }
      },
      "log_level": {
        "type": "keyword"
      },
      "application": {
        "type": "keyword"
      },
      "clientip": {
        "type": "ip"
      },
      "geoip": {
        "properties": {
          "location": {
            "type": "geo_point"
          }
        }
      }
    }
  }
}
EOF

systemctl enable logstash
systemctl start logstash

# Install Kibana
log "Installing Kibana..."
apt-get install -y kibana=$ELASTIC_VERSION

# Configure Kibana
cat > /etc/kibana/kibana.yml << EOF
# Vagrant Enterprise Kibana Configuration
server.port: 5601
server.host: "0.0.0.0"
server.name: "vagrant-kibana-${ENVIRONMENT}"
elasticsearch.hosts: ["http://localhost:9200"]

# Logging
logging.appenders.file.type: file
logging.appenders.file.fileName: /var/log/kibana/kibana.log
logging.appenders.file.layout.type: json
logging.root.appenders: [default, file]
logging.root.level: info

# Security
server.publicBaseUrl: "http://kibana.vagrant.local:5601"
EOF

systemctl enable kibana
systemctl start kibana

# Install and configure Filebeat
log "Installing Filebeat for log shipping..."
apt-get install -y filebeat=$ELASTIC_VERSION

cat > /etc/filebeat/filebeat.yml << EOF
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - /var/log/*.log
    - /var/log/syslog
    - /var/log/auth.log
    - /vagrant/logs/*.log
    - /opt/*/logs/*.log
  fields:
    log_type: system
    environment: $ENVIRONMENT
    infrastructure: vagrant
  fields_under_root: true
  multiline.pattern: '^\\d{4}-\\d{2}-\\d{2}'
  multiline.negate: true
  multiline.match: after

- type: log
  enabled: true
  paths:
    - /var/log/apache2/access.log
    - /var/log/nginx/access.log
  fields:
    log_type: access
    environment: $ENVIRONMENT
  fields_under_root: true

- type: log
  enabled: true
  paths:
    - /var/log/apache2/error.log
    - /var/log/nginx/error.log
  fields:
    log_type: error
    environment: $ENVIRONMENT
  fields_under_root: true

output.logstash:
  hosts: ["localhost:5044"]

processors:
- add_host_metadata:
    when.not.contains.tags: forwarded
- add_docker_metadata: ~

logging.level: info
logging.to_files: true
logging.files:
  path: /var/log/filebeat
  name: filebeat
  keepfiles: 7
  permissions: 0640

# ILM policy
setup.ilm.enabled: true
setup.ilm.rollover_alias: "vagrant-logs"
setup.ilm.pattern: "{now/d}-000001"
setup.ilm.policy: "vagrant-logs-policy"
EOF

systemctl enable filebeat
systemctl start filebeat

log "ELK stack deployment completed successfully!"
log "Services accessible at:"
log "  - Elasticsearch: http://localhost:9200"
log "  - Kibana: http://localhost:5601"
log "  - Logstash: localhost:5044 (Beats input)"