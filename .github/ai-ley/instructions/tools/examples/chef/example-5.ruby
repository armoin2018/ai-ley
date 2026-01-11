# libraries/enterprise_helpers.rb - Enterprise helper functions
module EnterpriseHelpers
  module Common
    # Get environment-specific configuration
    def enterprise_config(service_name, default = {})
      base_config = node['enterprise']['services'][service_name] || {}
      env_config = node['enterprise']['environments'][node.environment] || {}
      service_env_config = env_config[service_name] || {}

      default.merge(base_config).merge(service_env_config)
    end

    # Generate secure random password
    def generate_secure_password(length = 32)
      require 'securerandom'
      SecureRandom.base64(length)[0, length]
    end

    # Get secrets from HashiCorp Vault
    def vault_secret(path, key = nil)
      require 'vault'

      Vault.configure do |config|
        config.address = node['vault']['address']
        config.token = node['vault']['token']
        config.ssl_verify = node['vault']['ssl_verify']
      end

      secret = Vault.logical.read(path)
      return nil if secret.nil?

      if key
        secret.data[key.to_sym]
      else
        secret.data
      end
    rescue => e
      Chef::Log.error("Failed to fetch secret from Vault: #{e.message}")
      nil
    end

    # Encrypt sensitive data using Chef Vault
    def chef_vault_item(vault, item)
      require 'chef-vault'
      ChefVault::Item.load(vault, item)
    rescue ChefVault::Exceptions::KeysNotFound => e
      Chef::Log.error("Chef Vault keys not found: #{e.message}")
      {}
    rescue => e
      Chef::Log.error("Failed to load Chef Vault item: #{e.message}")
      {}
    end

    # Validate IP address format
    def valid_ip?(ip)
      return false unless ip.is_a?(String)

      octets = ip.split('.')
      return false unless octets.length == 4

      octets.all? { |octet| octet.to_i.between?(0, 255) }
    end

    # Check if service is listening on port
    def port_listening?(port, protocol = 'tcp')
      case protocol.downcase
      when 'tcp'
        system("netstat -tln | grep -q ':#{port} '")
      when 'udp'
        system("netstat -uln | grep -q ':#{port} '")
      else
        false
      end
    end

    # Get system memory in MB
    def system_memory_mb
      if node['memory'] && node['memory']['total']
        node['memory']['total'].gsub(/kB$/, '').to_i / 1024
      else
        2048  # Default fallback
      end
    end

    # Calculate optimal worker processes
    def optimal_worker_count(multiplier = 1)
      cpu_count = node['cpu'] ? node['cpu']['total'].to_i : 2
      [cpu_count * multiplier, 1].max
    end

    # Format bytes to human readable
    def human_bytes(bytes)
      units = %w[B KB MB GB TB PB]
      size = bytes.to_f
      unit_index = 0

      while size >= 1024 && unit_index < units.length - 1
        size /= 1024
        unit_index += 1
      end

      "#{size.round(2)} #{units[unit_index]}"
    end

    # Check if running in production
    def production_environment?
      node.environment == 'production'
    end

    # Get datacenter from node attributes
    def datacenter
      node['datacenter'] || node['ec2']['placement_availability_zone'][0..-2] || 'unknown'
    end

    # Generate SSL certificate paths
    def ssl_paths(service_name)
      base_path = "/etc/ssl/#{service_name}"
      {
        cert: "#{base_path}/#{service_name}.crt",
        key: "#{base_path}/#{service_name}.key",
        ca: "#{base_path}/ca.crt",
        dhparam: "#{base_path}/dhparam.pem"
      }
    end
  end

  module Security
    # Generate strong SSL/TLS configuration
    def strong_ssl_config
      {
        protocols: 'TLSv1.2 TLSv1.3',
        ciphers: [
          'ECDHE-ECDSA-AES128-GCM-SHA256',
          'ECDHE-RSA-AES128-GCM-SHA256',
          'ECDHE-ECDSA-AES256-GCM-SHA384',
          'ECDHE-RSA-AES256-GCM-SHA384',
          'ECDHE-ECDSA-CHACHA20-POLY1305',
          'ECDHE-RSA-CHACHA20-POLY1305',
          'DHE-RSA-AES128-GCM-SHA256',
          'DHE-RSA-AES256-GCM-SHA384'
        ].join(':'),
        prefer_server_ciphers: 'off',
        session_cache: 'shared:SSL:10m',
        session_timeout: '10m',
        session_tickets: 'off'
      }
    end

    # Generate security headers
    def security_headers
      {
        'X-Frame-Options' => 'DENY',
        'X-Content-Type-Options' => 'nosniff',
        'X-XSS-Protection' => '1; mode=block',
        'Strict-Transport-Security' => 'max-age=31536000; includeSubDomains; preload',
        'Referrer-Policy' => 'strict-origin-when-cross-origin',
        'Content-Security-Policy' => "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'",
        'Feature-Policy' => "geolocation 'none'; microphone 'none'; camera 'none'"
      }
    end

    # Check if system meets CIS benchmarks
    def cis_compliant?(control)
      case control
      when '1.1.1.1'  # Ensure mounting of cramfs filesystems is disabled
        !system('modprobe -n -v cramfs | grep -v "install /bin/true"')
      when '1.4.1'    # Ensure permissions on bootloader config are configured
        File.stat('/boot/grub2/grub.cfg').mode & 0o077 == 0
      when '5.2.5'    # Ensure SSH X11 forwarding is disabled
        File.read('/etc/ssh/sshd_config').include?('X11Forwarding no')
      else
        true  # Default to compliant for unknown controls
      end
    rescue
      false
    end
  end

  module Monitoring
    # Generate Prometheus metrics
    def prometheus_metrics(service_name, metrics = {})
      content = []

      metrics.each do |metric_name, metric_data|
        content << "# HELP #{service_name}_#{metric_name} #{metric_data[:help]}"
        content << "# TYPE #{service_name}_#{metric_name} #{metric_data[:type]}"

        if metric_data[:labels]
          label_str = metric_data[:labels].map { |k, v| "#{k}=\"#{v}\"" }.join(',')
          content << "#{service_name}_#{metric_name}{#{label_str}} #{metric_data[:value]}"
        else
          content << "#{service_name}_#{metric_name} #{metric_data[:value]}"
        end
      end

      content.join("\n") + "\n"
    end

    # Check service health
    def service_healthy?(service_name, port = nil)
      service_running = system("systemctl is-active #{service_name} > /dev/null 2>&1")

      if port
        port_open = port_listening?(port)
        service_running && port_open
      else
        service_running
      end
    end

    # Get system load average
    def system_load
      if File.exist?('/proc/loadavg')
        File.read('/proc/loadavg').split(' ')[0..2].map(&:to_f)
      else
        [0.0, 0.0, 0.0]
      end
    end
  end
end

# Include helper modules in Chef::Recipe and Chef::Resource
Chef::Recipe.include(EnterpriseHelpers::Common)
Chef::Recipe.include(EnterpriseHelpers::Security)
Chef::Recipe.include(EnterpriseHelpers::Monitoring)

Chef::Resource.include(EnterpriseHelpers::Common)
Chef::Resource.include(EnterpriseHelpers::Security)
Chef::Resource.include(EnterpriseHelpers::Monitoring)