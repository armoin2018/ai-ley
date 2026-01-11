# Ubuntu/Debian
sudo apt update
sudo apt install couchdb

# macOS (via Homebrew)
brew install couchdb

# Docker installation
docker run -d --name couchdb \
  -e COUCHDB_USER=admin \
  -e COUCHDB_PASSWORD=password \
  -p 5984:5984 \
  apache/couchdb:3.3

# Start CouchDB service
sudo systemctl start couchdb
sudo systemctl enable couchdb

# Verify installation
curl http://localhost:5984/