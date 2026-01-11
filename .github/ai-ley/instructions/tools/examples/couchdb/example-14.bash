# Database operations via HTTP API
curl -X PUT http://admin:password@localhost:5984/mydb
curl -X GET http://admin:password@localhost:5984/mydb
curl -X DELETE http://admin:password@localhost:5984/mydb

# Document operations
curl -X PUT http://admin:password@localhost:5984/mydb/doc1 -d '{"name":"test"}'
curl -X GET http://admin:password@localhost:5984/mydb/doc1
curl -X DELETE http://admin:password@localhost:5984/mydb/doc1?rev=1-abc123

# View queries
curl -X GET http://admin:password@localhost:5984/mydb/_design/users/_view/by_email?key="john@example.com"

# Replication
curl -X POST http://admin:password@localhost:5984/_replicate -d '{"source":"db1","target":"db2"}'