# Enterprise deployment pipeline
#!/bin/bash
# deploy-pecl-extensions.sh - Enterprise deployment script

set -euo pipefail

ENVIRONMENT="${1:-production}"
CONFIG_DIR="/opt/php-config/$ENVIRONMENT"
BACKUP_DIR="/opt/backups/php-extensions"
DEPLOYMENT_LOG="/var/log/pecl-deployment.log"

deploy_to_environment() {
    local env="$1"
    
    echo "$(date): Starting PECL deployment to $env" >> "$DEPLOYMENT_LOG"
    
    # Create backup
    create_deployment_backup "$env"
    
    # Load environment-specific configuration
    source "$CONFIG_DIR/extensions.conf"
    
    # Deploy extensions
    for extension_spec in "${EXTENSIONS[@]}"; do
        IFS=':' read -r extension version <<< "$extension_spec"
        deploy_extension "$extension" "$version"
    done
    
    # Validate deployment
    validate_deployment
    
    # Update load balancer (if applicable)
    update_load_balancer "$env"
    
    echo "$(date): PECL deployment to $env completed" >> "$DEPLOYMENT_LOG"
}

create_deployment_backup() {
    local env="$1"
    local backup_path="$BACKUP_DIR/$env-$(date +%Y%m%d-%H%M%S)"
    
    mkdir -p "$backup_path"
    
    # Backup extensions
    cp -r /usr/lib/php/*/  "$backup_path/extensions/" 2>/dev/null || true
    
    # Backup configurations
    cp -r /etc/php/*/mods-available/ "$backup_path/configs/" 2>/dev/null || true
    
    echo "Backup created: $backup_path"
}

deploy_extension() {
    local extension="$1"
    local version="$2"
    
    echo "Deploying $extension version $version..."
    
    # Rolling deployment for zero downtime
    for server in $(get_server_list); do
        echo "Deploying to $server..."
        
        # Deploy to server
        ssh "$server" "
            # Stop traffic to this server
            curl -X POST http://localhost/maintenance-mode/enable
            
            # Install extension
            printf '\n' | pecl install $extension-$version
            
            # Configure extension
            phpenmod $extension
            
            # Restart services
            systemctl restart php8.1-fpm
            
            # Health check
            if php -m | grep -q '^$extension$'; then
                # Re-enable traffic
                curl -X POST http://localhost/maintenance-mode/disable
                echo 'Deployment successful on $server'
            else
                echo 'Deployment failed on $server'
                exit 1
            fi
        "
        
        # Wait between servers
        sleep 30
    done
}

validate_deployment() {
    echo "Validating deployment..."
    
    local validation_failed=false
    
    # Test each required extension
    for extension_spec in "${EXTENSIONS[@]}"; do
        IFS=':' read -r extension version <<< "$extension_spec"
        
        if ! php -m | grep -q "^$extension$"; then
            echo "VALIDATION FAILED: $extension not loaded"
            validation_failed=true
        fi
        
        # Version check
        local installed_version=$(php --re "$extension" | grep "Version" | head -1 | awk '{print $3}')
        if [[ "$installed_version" != "$version" ]]; then
            echo "VALIDATION WARNING: $extension version mismatch (expected: $version, got: $installed_version)"
        fi
    done
    
    if [[ "$validation_failed" == "true" ]]; then
        echo "Deployment validation failed!"
        exit 1
    else
        echo "Deployment validation passed!"
    fi
}

# Execute deployment
deploy_to_environment "$ENVIRONMENT"