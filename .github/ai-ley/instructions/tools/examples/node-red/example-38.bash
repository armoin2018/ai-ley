# Check Node-RED logs
journalctl -u nodered -f

# Validate flow JSON
node -e "console.log(JSON.parse(require('fs').readFileSync('flows.json')))"

# Safe mode start
node-red --safe

# Clear cache
rm -rf ~/.node-red/.sessions.json