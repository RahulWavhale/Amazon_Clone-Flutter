const mysql = require('mysql2/promise');

// Create a pool of connections
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'amazon_clone',
  connectionLimit: 10,
  waitForConnections: true,
  queueLimit: 0,
  connectTimeout: 10000, // 10 seconds
});

async function findOne(email) {
  if (!email) {
    throw new Error('Email is required');
  }
  const [rows] = await pool.execute('SELECT * FROM user WHERE email = ?', [email]);
  return rows[0]; // Assuming you only need the first result
}

async function insertUser(name, email, password) {
  if (!name || !email || !password) {
    throw new Error('All fields (name, email, password) are required');
  }
  await pool.execute('INSERT INTO user (name, email, password) VALUES (?, ?, ?)', [name, email, password]);
}




module.exports = { findOne, insertUser,pool };
