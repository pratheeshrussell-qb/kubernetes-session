const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const port = 3000;

app.use(cors());

// Database configuration
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  ssl: (process.env.DB_TLS && process.env.DB_TLS.toLowerCase() == 'true') ? {
    rejectUnauthorized: false,
  } : false,
});

// Get random quote
app.get('/api/quotes/random', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT text, author 
      FROM quotes.messages 
      ORDER BY RANDOM() 
      LIMIT 1
    `);
    res.json(result.rows[0]);
    
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/healthz', async (req, res) => {
  res.status(200).json({ message: 'OK' });
});

app.listen(port, () => {
  console.log(`Backend running on port ${port}`);
});