#!/bin/bash

# Main Deployment Script
# Usage: ./deploy.sh [environment] [options]
# Example: ./deploy.sh production --backup --version 1.2.3

set -euo pipefail

# Script Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
readonly PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Source common libraries
source "$SCRIPT_DIR/lib/common.sh"
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/validation.sh"
source "$SCRIPT_DIR/lib/backup.sh"

# Global Variables
ENVIRONMENT=""
CONFIG_FILE=""
VERSION=""
BACKUP_BEFORE_DEPLOY=false
DRY_RUN=false
FORCE_DEPLOY=false
ROLLBACK_ON_FAILURE=true
VERBOSE=false

# Default Configuration
readonly DEFAULT_ENVIRONMENT="development"
readonly DEFAULT_CONFIG_DIR="$SCRIPT_DIR/config"
readonly LOG_DIR="$SCRIPT_DIR/logs"
readonly BACKUP_DIR="$SCRIPT_DIR/backups"

# Initialize logging
init_logging "$LOG_DIR/deployment.log"

# Function: Display usage information
usage() {
    cat << EOF
Usage: $SCRIPT_NAME [environment] [options]

ENVIRONMENTS:
    development, dev    Deploy to development environment
    staging, stage      Deploy to staging environment
    production, prod    Deploy to production environment

OPTIONS:
    --config FILE       Use custom configuration file
    --version VERSION   Deploy specific version (default: latest)
    --backup           Create backup before deployment
    --no-rollback      Disable automatic rollback on failure
    --dry-run          Show what would be deployed without executing
    --force            Force deployment even if validation fails
    --verbose, -v      Enable verbose output
    --help, -h         Show this help message

EXAMPLES:
    $SCRIPT_NAME development
    $SCRIPT_NAME production --backup --version 1.2.3
    $SCRIPT_NAME staging --config custom.conf --verbose
    $SCRIPT_NAME production --dry-run

EOF
}

# Function: Parse command line arguments
parse_arguments() {
    # Parse environment (first argument)
    if [[ $# -gt 0 && ! $1 =~ ^-- ]]; then
        case "$1" in
            development|dev)     ENVIRONMENT="development" ;;
            staging|stage)       ENVIRONMENT="staging" ;;
            production|prod)     ENVIRONMENT="production" ;;
            *)                   log_error "Unknown environment: $1" && usage && exit 1 ;;
        esac
        shift
    else
        ENVIRONMENT="$DEFAULT_ENVIRONMENT"
    fi

    # Parse options
    while [[ $# -gt 0 ]]; do
        case $1 in
            --config)
                [[ $# -lt 2 ]] && log_error "--config requires a file path" && exit 1
                CONFIG_FILE="$2"
                shift 2
                ;;
            --version)
                [[ $# -lt 2 ]] && log_error "--version requires a version string" && exit 1
                VERSION="$2"
                shift 2
                ;;
            --backup)
                BACKUP_BEFORE_DEPLOY=true
                shift
                ;;
            --no-rollback)
                ROLLBACK_ON_FAILURE=false
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --force)
                FORCE_DEPLOY=true
                shift
                ;;
            --verbose|-v)
                VERBOSE=true
                shift
                ;;
            --help|-h)
                usage
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
}

# Function: Load configuration
load_configuration() {
    # Determine config file
    if [[ -z "$CONFIG_FILE" ]]; then
        CONFIG_FILE="$DEFAULT_CONFIG_DIR/$ENVIRONMENT.conf"
    fi

    # Validate config file exists
    if [[ ! -f "$CONFIG_FILE" ]]; then
        log_error "Configuration file not found: $CONFIG_FILE"
        exit 1
    fi

    # Source configuration
    log_info "Loading configuration from: $CONFIG_FILE"
    source "$CONFIG_FILE"

    # Set default version if not specified
    if [[ -z "$VERSION" ]]; then
        VERSION="${DEFAULT_VERSION:-latest}"
    fi

    log_info "Environment: $ENVIRONMENT"
    log_info "Version: $VERSION"
    log_info "Application: ${APP_NAME:-myapp}"
}

# Function: Pre-deployment validation
validate_deployment() {
    log_info "Running pre-deployment validation..."

    # Check system requirements
    validate_system_requirements

    # Check application prerequisites
    validate_application_prerequisites

    # Check network connectivity
    validate_network_connectivity

    # Check disk space
    validate_disk_space

    # Check service dependencies
    validate_service_dependencies

    if [[ "$FORCE_DEPLOY" != "true" ]]; then
        # Run custom validation hooks
        run_hook "pre-deploy"
    fi

    log_success "Pre-deployment validation completed"
}

# Function: Create backup
create_deployment_backup() {
    if [[ "$BACKUP_BEFORE_DEPLOY" == "true" ]]; then
        log_info "Creating backup before deployment..."
        
        local backup_name="$(date +%Y%m%d_%H%M%S)_${ENVIRONMENT}_pre_deploy"
        
        if create_backup "$backup_name"; then
            log_success "Backup created: $backup_name"
            echo "$backup_name" > "$SCRIPT_DIR/.last_backup"
        else
            log_error "Failed to create backup"
            if [[ "$FORCE_DEPLOY" != "true" ]]; then
                exit 1
            fi
        fi
    fi
}

# Function: Deploy application
deploy_application() {
    log_info "Starting application deployment..."

    if [[ "$DRY_RUN" == "true" ]]; then
        log_info "DRY RUN MODE - No actual changes will be made"
    fi

    # Stop services
    log_info "Stopping services..."
    if [[ "$DRY_RUN" != "true" ]]; then
        "$SCRIPT_DIR/services/web-server.sh" stop || log_warn "Failed to stop web server"
        "$SCRIPT_DIR/services/cache.sh" stop || log_warn "Failed to stop cache service"
    else
        log_info "[DRY RUN] Would stop web server and cache services"
    fi

    # Deploy application code
    log_info "Deploying application code..."
    if [[ "$DRY_RUN" != "true" ]]; then
        deploy_application_code
    else
        log_info "[DRY RUN] Would deploy application code version: $VERSION"
    fi

    # Update configuration
    log_info "Updating configuration..."
    if [[ "$DRY_RUN" != "true" ]]; then
        update_configuration
    else
        log_info "[DRY RUN] Would update configuration for environment: $ENVIRONMENT"
    fi

    # Run database migrations
    log_info "Running database migrations..."
    if [[ "$DRY_RUN" != "true" ]]; then
        run_database_migrations
    else
        log_info "[DRY RUN] Would run database migrations"
    fi

    # Start services
    log_info "Starting services..."
    if [[ "$DRY_RUN" != "true" ]]; then
        "$SCRIPT_DIR/services/database.sh" start
        "$SCRIPT_DIR/services/cache.sh" start
        "$SCRIPT_DIR/services/web-server.sh" start
    else
        log_info "[DRY RUN] Would start database, cache, and web server services"
    fi

    log_success "Application deployment completed"
}

# Function: Post-deployment validation
validate_post_deployment() {
    log_info "Running post-deployment validation..."

    # Wait for services to stabilize
    sleep 10

    # Run health checks
    if ! "$SCRIPT_DIR/utils/health-check.sh" --environment "$ENVIRONMENT"; then
        log_error "Post-deployment health checks failed"
        return 1
    fi

    # Run custom validation hooks
    run_hook "post-deploy"

    log_success "Post-deployment validation completed"
}

# Function: Rollback deployment
rollback_deployment() {
    log_warn "Starting deployment rollback..."

    # Run pre-rollback hooks
    run_hook "pre-rollback"

    # Restore from backup if available
    if [[ -f "$SCRIPT_DIR/.last_backup" ]]; then
        local backup_name="$(cat "$SCRIPT_DIR/.last_backup")"
        log_info "Restoring from backup: $backup_name"
        
        if restore_backup "$backup_name"; then
            log_success "Rollback completed successfully"
        else
            log_error "Rollback failed"
            return 1
        fi
    else
        log_warn "No backup available for rollback"
        return 1
    fi

    # Run post-rollback hooks
    run_hook "post-rollback"

    log_success "Rollback completed"
}

# Function: Run deployment hooks
run_hook() {
    local hook_type="$1"
    local hook_script="$SCRIPT_DIR/hooks/$hook_type.sh"

    if [[ -f "$hook_script" && -x "$hook_script" ]]; then
        log_info "Running $hook_type hook..."
        if "$hook_script" "$ENVIRONMENT" "$VERSION"; then
            log_success "$hook_type hook completed"
        else
            log_warn "$hook_type hook failed"
            return 1
        fi
    else
        log_debug "No $hook_type hook found or not executable"
    fi
}

# Function: Deploy application code
deploy_application_code() {
    local app_dir="${APP_DIRECTORY:-/opt/myapp}"
    local backup_dir="$app_dir.backup.$(date +%Y%m%d_%H%M%S)"

    # Backup current version
    if [[ -d "$app_dir" ]]; then
        log_info "Backing up current application to: $backup_dir"
        cp -r "$app_dir" "$backup_dir"
    fi

    # Deploy new version
    log_info "Deploying version: $VERSION"
    
    # This would typically download/extract the application
    # Implementation depends on your deployment method (git, artifacts, etc.)
    case "${DEPLOYMENT_METHOD:-git}" in
        "git")
            deploy_from_git
            ;;
        "artifact")
            deploy_from_artifact
            ;;
        "docker")
            deploy_docker_container
            ;;
        *)
            log_error "Unknown deployment method: ${DEPLOYMENT_METHOD:-git}"
            return 1
            ;;
    esac
}

# Function: Deploy from Git repository
deploy_from_git() {
    local app_dir="${APP_DIRECTORY:-/opt/myapp}"
    local git_repo="${GIT_REPOSITORY:-}"
    local git_branch="${GIT_BRANCH:-main}"

    if [[ -z "$git_repo" ]]; then
        log_error "GIT_REPOSITORY not configured"
        return 1
    fi

    if [[ ! -d "$app_dir/.git" ]]; then
        log_info "Cloning repository: $git_repo"
        git clone "$git_repo" "$app_dir"
    fi

    cd "$app_dir"
    git fetch origin
    
    if [[ "$VERSION" == "latest" ]]; then
        git checkout "$git_branch"
        git pull origin "$git_branch"
    else
        git checkout "tags/$VERSION" || git checkout "$VERSION"
    fi

    log_success "Application code deployed from Git"
}

# Function: Deploy from artifact
deploy_from_artifact() {
    local app_dir="${APP_DIRECTORY:-/opt/myapp}"
    local artifact_url="${ARTIFACT_URL:-}"

    if [[ -z "$artifact_url" ]]; then
        log_error "ARTIFACT_URL not configured"
        return 1
    fi

    local artifact_file="/tmp/app-$VERSION.tar.gz"
    
    log_info "Downloading artifact: $artifact_url"
    curl -fsSL "$artifact_url" -o "$artifact_file"

    log_info "Extracting artifact to: $app_dir"
    mkdir -p "$app_dir"
    tar -xzf "$artifact_file" -C "$app_dir" --strip-components=1

    rm -f "$artifact_file"
    log_success "Application code deployed from artifact"
}

# Function: Deploy Docker container
deploy_docker_container() {
    local container_name="${CONTAINER_NAME:-myapp}"
    local image_name="${DOCKER_IMAGE:-myapp:$VERSION}"

    log_info "Pulling Docker image: $image_name"
    docker pull "$image_name"

    # Stop and remove existing container
    if docker ps -q -f name="$container_name" | grep -q .; then
        log_info "Stopping existing container: $container_name"
        docker stop "$container_name"
        docker rm "$container_name"
    fi

    log_info "Starting new container: $container_name"
    docker run -d \
        --name "$container_name" \
        --restart unless-stopped \
        -p "${APP_PORT:-8080}:8080" \
        "$image_name"

    log_success "Docker container deployed"
}

# Function: Update configuration
update_configuration() {
    local config_dest="${CONFIG_DESTINATION:-/etc/myapp}"

    log_info "Updating application configuration..."

    # Create configuration directory
    mkdir -p "$config_dest"

    # Copy configuration files
    if [[ -d "$SCRIPT_DIR/config/app" ]]; then
        cp -r "$SCRIPT_DIR/config/app/"* "$config_dest/"
        chmod 640 "$config_dest"/*.conf
    fi

    log_success "Configuration updated"
}

# Function: Run database migrations
run_database_migrations() {
    local db_host="${DATABASE_HOST:-localhost}"
    local db_name="${DATABASE_NAME:-myapp}"
    local db_user="${DATABASE_USER:-myapp}"

    log_info "Running database migrations..."

    # This would run your application's migration command
    # Example implementations:
    case "${DATABASE_TYPE:-postgresql}" in
        "postgresql")
            run_postgresql_migrations
            ;;
        "mysql")
            run_mysql_migrations
            ;;
        *)
            log_warn "No migration handler for database type: ${DATABASE_TYPE:-postgresql}"
            ;;
    esac

    log_success "Database migrations completed"
}

# Function: Run PostgreSQL migrations
run_postgresql_migrations() {
    local migration_dir="${MIGRATION_DIRECTORY:-/opt/myapp/migrations}"
    
    if [[ -d "$migration_dir" ]]; then
        # Example: Run migrations using flyway, liquibase, or custom script
        log_info "Applying PostgreSQL migrations from: $migration_dir"
        # flyway -url=jdbc:postgresql://$db_host/$db_name -user=$db_user migrate
    else
        log_debug "No migration directory found: $migration_dir"
    fi
}

# Function: Run MySQL migrations
run_mysql_migrations() {
    local migration_dir="${MIGRATION_DIRECTORY:-/opt/myapp/migrations}"
    
    if [[ -d "$migration_dir" ]]; then
        log_info "Applying MySQL migrations from: $migration_dir"
        # mysql -h $db_host -u $db_user -p$db_pass $db_name < migrations.sql
    else
        log_debug "No migration directory found: $migration_dir"
    fi
}

# Function: Main deployment flow
main() {
    log_info "Starting deployment process..."
    log_info "Script: $SCRIPT_NAME"
    log_info "PID: $$"
    log_info "User: $(whoami)"
    log_info "Working Directory: $(pwd)"

    # Parse command line arguments
    parse_arguments "$@"

    # Load configuration
    load_configuration

    # Enable verbose mode if requested
    if [[ "$VERBOSE" == "true" ]]; then
        set -x
    fi

    # Trap errors for rollback
    if [[ "$ROLLBACK_ON_FAILURE" == "true" && "$DRY_RUN" != "true" ]]; then
        trap 'log_error "Deployment failed, initiating rollback..."; rollback_deployment' ERR
    fi

    # Main deployment steps
    validate_deployment
    create_deployment_backup
    deploy_application
    
    # Only validate if not dry run
    if [[ "$DRY_RUN" != "true" ]]; then
        if validate_post_deployment; then
            log_success "Deployment completed successfully!"
            log_info "Environment: $ENVIRONMENT"
            log_info "Version: $VERSION"
            log_info "Deployment time: $(date)"
            
            # Clean up old backups
            cleanup_old_backups
        else
            log_error "Post-deployment validation failed"
            if [[ "$ROLLBACK_ON_FAILURE" == "true" ]]; then
                rollback_deployment
            fi
            exit 1
        fi
    else
        log_success "Dry run completed - no changes made"
    fi
}

# Function: Cleanup old backups
cleanup_old_backups() {
    local retention_days="${BACKUP_RETENTION_DAYS:-7}"
    log_info "Cleaning up backups older than $retention_days days..."
    
    find "$BACKUP_DIR" -name "*.tar.gz" -mtime "+$retention_days" -delete 2>/dev/null || true
    
    log_success "Backup cleanup completed"
}

# Execute main function if script is run directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
