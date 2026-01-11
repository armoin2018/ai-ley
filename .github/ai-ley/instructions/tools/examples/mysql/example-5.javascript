// Node.js with mysql2
const mysql = require('mysql2/promise');

// Connection configuration
const connection = await mysql.createConnection({
  host: 'localhost',
  port: 3306,
  user: 'appuser',
  password: 'apppassword',
  database: 'myapp',
  ssl: {
    rejectUnauthorized: false,
  },
  timezone: 'Z',
});

// Connection pooling
const pool = mysql.createPool({
  host: 'localhost',
  port: 3306,
  user: 'appuser',
  password: 'apppassword',
  database: 'myapp',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});