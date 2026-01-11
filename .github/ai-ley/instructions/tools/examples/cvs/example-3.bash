#!/bin/bash
# CVS repository maintenance and backup script

set -euo pipefail

# Configuration
CVS_ROOT="${CVSROOT:-/cvsroot}"
BACKUP_DIR="/backup/cvs"
LOG_FILE="/var/log/cvs-maintenance.log"
RETENTION_DAYS=90

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

# Repository backup
backup_repository() {
    log "Starting CVS repository backup"
    
    local backup_date=$(date +%Y%m%d_%H%M%S)
    local backup_path="$BACKUP_DIR/cvs_backup_$backup_date"
    
    # Create backup directory
    mkdir -p "$backup_path"
    
    # Create compressed backup
    log "Creating compressed backup..."
    tar -czf "$backup_path/cvsroot.tar.gz" -C "$(dirname "$CVS_ROOT")" "$(basename "$CVS_ROOT")"
    
    # Verify backup integrity
    if tar -tzf "$backup_path/cvsroot.tar.gz" > /dev/null 2>&1; then
        log "Backup created successfully: $backup_path/cvsroot.tar.gz"
        
        # Create backup metadata
        cat > "$backup_path/backup_info.txt" << EOF
Backup Date: $(date)
CVS Root: $CVS_ROOT
Backup Size: $(du -h "$backup_path/cvsroot.tar.gz" | cut -f1)
Backup Path: $backup_path/cvsroot.tar.gz
CVS Version: $(cvs --version | head -1)
EOF
    else
        log "ERROR: Backup verification failed"
        return 1
    fi
    
    # Cleanup old backups
    cleanup_old_backups
}

# Cleanup old backups
cleanup_old_backups() {
    log "Cleaning up backups older than $RETENTION_DAYS days"
    
    find "$BACKUP_DIR" -name "cvs_backup_*" -type d -mtime +$RETENTION_DAYS -exec rm -rf {} \; 2>/dev/null || true
    
    log "Backup cleanup completed"
}

# Repository health check
health_check() {
    log "Performing CVS repository health check"
    
    # Check repository directory permissions
    if [ ! -r "$CVS_ROOT" ] || [ ! -w "$CVS_ROOT" ]; then
        log "ERROR: Insufficient permissions on CVS root directory"
        return 1
    fi
    
    # Check for corrupted RCS files
    log "Checking for corrupted RCS files..."
    local corrupted_files=0
    
    find "$CVS_ROOT" -name "*,v" -type f | while read rcs_file; do
        if ! rcs -l "$rcs_file" >/dev/null 2>&1; then
            log "WARNING: Potentially corrupted RCS file: $rcs_file"
            ((corrupted_files++))
        fi
    done
    
    if [ $corrupted_files -eq 0 ]; then
        log "No corrupted RCS files found"
    else
        log "WARNING: $corrupted_files potentially corrupted RCS files found"
    fi
    
    # Check repository size and growth
    local repo_size=$(du -sh "$CVS_ROOT" | cut -f1)
    log "Repository size: $repo_size"
    
    # Check for large files that might cause issues
    log "Checking for large files (>10MB)..."
    find "$CVS_ROOT" -name "*,v" -size +10M -exec ls -lh {} \; | tee -a "$LOG_FILE"
    
    log "Health check completed"
}

# Generate repository statistics
generate_statistics() {
    log "Generating repository statistics"
    
    local stats_file="$BACKUP_DIR/cvs_stats_$(date +%Y%m%d).txt"
    
    cat > "$stats_file" << EOF
CVS Repository Statistics
Generated: $(date)
Repository: $CVS_ROOT

Repository Size: $(du -sh "$CVS_ROOT" | cut -f1)
Total RCS Files: $(find "$CVS_ROOT" -name "*,v" | wc -l)
Total Modules: $(ls -1 "$CVS_ROOT" | grep -v CVSROOT | wc -l)

Largest RCS Files:
$(find "$CVS_ROOT" -name "*,v" -exec ls -lh {} \; | sort -k5 -hr | head -10)

Recently Modified Files (last 30 days):
$(find "$CVS_ROOT" -name "*,v" -mtime -30 -exec ls -lt {} \; | head -20)

Module List:
$(ls -1 "$CVS_ROOT" | grep -v CVSROOT)
EOF
    
    log "Statistics generated: $stats_file"
}

# Export module to modern format
export_module() {
    local module_name="$1"
    local export_dir="${2:-/tmp/cvs_export}"
    
    log "Exporting module '$module_name' for migration"
    
    # Create export directory
    mkdir -p "$export_dir/$module_name"
    
    # Export module with history
    cd "$export_dir"
    cvs -d "$CVS_ROOT" export -r HEAD "$module_name"
    
    # Generate change log
    cvs -d "$CVS_ROOT" log "$module_name" > "$export_dir/${module_name}_changelog.txt"
    
    # Create module information file
    cat > "$export_dir/${module_name}_info.txt" << EOF
Module: $module_name
Exported: $(date)
CVS Root: $CVS_ROOT
Export Directory: $export_dir/$module_name

Notes:
- This export contains the latest version of all files
- See ${module_name}_changelog.txt for complete history
- Use cvs2git or similar tools for history migration
- Binary files may need special handling
EOF
    
    log "Module '$module_name' exported to $export_dir"
}

# Main function dispatcher
main() {
    case "${1:-help}" in
        "backup")
            backup_repository
            ;;
        "health-check")
            health_check
            ;;
        "statistics")
            generate_statistics
            ;;
        "export")
            if [[ -z "${2:-}" ]]; then
                echo "Usage: $0 export <module-name> [export-directory]"
                exit 1
            fi
            export_module "$2" "${3:-}"
            ;;
        "full-maintenance")
            log "Starting full CVS maintenance cycle"
            health_check
            backup_repository
            generate_statistics
            log "Full maintenance cycle completed"
            ;;
        "help"|*)
            echo "CVS Repository Maintenance Script"
            echo "Usage: $0 {backup|health-check|statistics|export|full-maintenance}"
            echo ""
            echo "Commands:"
            echo "  backup                     - Create repository backup"
            echo "  health-check              - Perform repository health check"
            echo "  statistics                - Generate repository statistics"
            echo "  export <module> [dir]     - Export module for migration"
            echo "  full-maintenance          - Run all maintenance tasks"
            ;;
    esac
}

main "$@"