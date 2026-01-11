// Application-level read/write splitting
const masterPool = mysql.createPool({
  host: 'master.database.com',
  user: 'app_user',
  password: 'password',
  database: 'myapp',
  connectionLimit: 20,
});

const slavePool = mysql.createPool({
  host: 'slave.database.com',
  user: 'readonly_user',
  password: 'password',
  database: 'myapp',
  connectionLimit: 10,
});

// Route reads to slave, writes to master
class DatabaseManager {
  async read(query, params) {
    return slavePool.execute(query, params);
  }

  async write(query, params) {
    return masterPool.execute(query, params);
  }
}