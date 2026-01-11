#!/bin/bash
# karabiner_backup.sh
# Backup and restore Karabiner configurations

BACKUP_DIR="$HOME/.karabiner_backups"
CONFIG_FILE="$HOME/.config/karabiner/karabiner.json"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

function backup_config() {
    mkdir -p "$BACKUP_DIR"
    cp "$CONFIG_FILE" "$BACKUP_DIR/karabiner_$TIMESTAMP.json"
    echo "✓ Configuration backed up to: $BACKUP_DIR/karabiner_$TIMESTAMP.json"

    # Keep only last 10 backups
    ls -t "$BACKUP_DIR"/karabiner_*.json | tail -n +11 | xargs rm -f 2>/dev/null
}

function restore_config() {
    echo "Available backups:"
    select backup in "$BACKUP_DIR"/karabiner_*.json; do
        if [ -n "$backup" ]; then
            cp "$backup" "$CONFIG_FILE"
            echo "✓ Configuration restored from: $backup"
            echo "! Restart Karabiner-Elements to apply changes"
            break
        fi
    done
}

function validate_config() {
    if command -v jq &> /dev/null; then
        if jq empty "$CONFIG_FILE" 2>/dev/null; then
            echo "✓ Configuration is valid JSON"
        else
            echo "✗ Configuration contains JSON errors!"
            exit 1
        fi
    else
        echo "! jq not installed - skipping validation"
    fi
}

case "$1" in
    backup)
        backup_config
        ;;
    restore)
        restore_config
        ;;
    validate)
        validate_config
        ;;
    *)
        echo "Usage: $0 {backup|restore|validate}"
        exit 1
        ;;
esac