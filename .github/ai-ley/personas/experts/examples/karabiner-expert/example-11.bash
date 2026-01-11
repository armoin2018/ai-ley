#!/bin/bash
# karabiner_device_inspector.sh
# Identify connected keyboards for device-specific profiles

echo "=== Karabiner Device Inspector ==="
echo ""
echo "Connected Keyboards:"
echo "===================="

# Read Karabiner configuration
KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"

if [ ! -f "$KARABINER_CONFIG" ]; then
    echo "Karabiner configuration not found!"
    echo "Expected location: $KARABINER_CONFIG"
    exit 1
fi

# Extract device information using jq
jq -r '.profiles[0].devices[] |
    select(.identifiers.is_keyboard == true) |
    "
    Device: \(.identifiers |
        if has("product_name") then .product_name
        else "Unknown Device" end)
    Vendor ID: \(.identifiers.vendor_id)
    Product ID: \(.identifiers.product_id)
    Ignored: \(.ignore)
    LED Control: \(.manipulate_caps_lock_led // false)
    ---"' "$KARABINER_CONFIG"

echo ""
echo "To create device-specific rules, use these identifiers:"
echo ""
echo '{
  "identifiers": {
    "is_keyboard": true,
    "vendor_id": YOUR_VENDOR_ID,
    "product_id": YOUR_PRODUCT_ID
  },
  "ignore": false,
  "manipulate_caps_lock_led": true
}'