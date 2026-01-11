# Karabiner-Elements Troubleshooting Guide

## Configuration Not Loading

- [ ] Validate JSON syntax with `jq empty karabiner.json`
- [ ] Check console for Karabiner error messages: `log stream --predicate 'process == "karabiner_console_user_server"' --level debug`
- [ ] Restart Karabiner-Elements from menu bar
- [ ] Check file permissions: `ls -la ~/.config/karabiner/karabiner.json`
- [ ] Restore from backup if corrupted

## Modifications Not Working

- [ ] Verify modification is enabled in Karabiner preferences
- [ ] Check EventViewer to confirm key codes are correct
- [ ] Test with simpler rule to isolate issue
- [ ] Check for conflicting rules (order matters!)
- [ ] Verify frontmost_application bundle identifier
- [ ] Confirm device is not in "ignore" list

## Permission Issues

- [ ] Grant Input Monitoring permission: System Settings → Privacy & Security → Input Monitoring
- [ ] Grant Accessibility permission if using shell commands
- [ ] Restart Karabiner after granting permissions
- [ ] Check for macOS security policies blocking drivers

## Performance Problems

- [ ] Reduce simultaneous_threshold_milliseconds if keys feel laggy
- [ ] Simplify complex rule chains
- [ ] Remove unused complex modifications
- [ ] Check Activity Monitor for karabiner_grabber CPU usage
- [ ] Restart karabiner_grabber process if hanging

## Device-Specific Issues

- [ ] Verify vendor_id and product_id with Device Inspector
- [ ] Check if device requires special USB settings
- [ ] Test device without Karabiner to rule out hardware issues
- [ ] Try different USB port or hub
- [ ] Update device firmware if available

## Emergency Recovery

- [ ] Hold Shift during boot to disable kernel extensions temporarily
- [ ] Delete `~/.config/karabiner/karabiner.json` to reset
- [ ] Uninstall and reinstall Karabiner-Elements
- [ ] Restore system keyboard settings in System Settings