// Node.js repository pattern with connection pooling
const mysql = require('mysql2/promise');

class DatabaseConnection {
  constructor() {
    this.pool = mysql.createPool({
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
      waitForConnections: true,
      connectionLimit: 10,
      queueLimit: 0,
      acquireTimeout: 60000,
      timeout: 60000,
      reconnect: true,
    });
  }

  async query(sql, params) {
    try {
      const [rows] = await this.pool.execute(sql, params);
      return rows;
    } catch (error) {
      console.error('Database query error:', error);
      throw error;
    }
  }

  async transaction(callback) {
    const connection = await this.pool.getConnection();
    await connection.beginTransaction();

    try {
      const result = await callback(connection);
      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

class UserRepository {
  constructor(db) {
    this.db = db;
  }

  async findById(id) {
    const sql = `
      SELECT id, email, username, first_name, last_name, created_at 
      FROM users 
      WHERE id = ? AND is_active = 1
    `;
    const users = await this.db.query(sql, [id]);
    return users[0] || null;
  }

  async create(userData) {
    const sql = `
      INSERT INTO users (email, username, password_hash, first_name, last_name)
      VALUES (?, ?, ?, ?, ?)
    `;

    return this.db.transaction(async (connection) => {
      const [result] = await connection.execute(sql, [
        userData.email,
        userData.username,
        userData.passwordHash,
        userData.firstName,
        userData.lastName,
      ]);

      return { id: result.insertId, ...userData };
    });
  }

  async findWithPosts(userId, limit = 10, offset = 0) {
    const sql = `
      SELECT 
        u.id, u.username, u.first_name, u.last_name,
        p.id as post_id, p.title, p.content, p.created_at as post_created_at
      FROM users u
      LEFT JOIN posts p ON u.id = p.user_id AND p.status = 'published'
      WHERE u.id = ? AND u.is_active = 1
      ORDER BY p.created_at DESC
      LIMIT ? OFFSET ?
    `;

    const rows = await this.db.query(sql, [userId, limit, offset]);

    if (rows.length === 0) return null;

    // Transform flat result into nested structure
    const user = {
      id: rows[0].id,
      username: rows[0].username,
      firstName: rows[0].first_name,
      lastName: rows[0].last_name,
      posts: [],
    };

    for (const row of rows) {
      if (row.post_id) {
        user.posts.push({
          id: row.post_id,
          title: row.title,
          content: row.content,
          createdAt: row.post_created_at,
        });
      }
    }

    return user;
  }
}