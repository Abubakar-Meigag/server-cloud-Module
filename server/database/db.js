// require("dotenv").config();
const { Pool } = require("pg");

if (!process.env.DB_URL) {
  throw new Error("DB_URL is not defined in environment variables!");
}

const pool = new Pool({
  connectionString: process.env.DB_URL,
  ssl: { rejectUnauthorized: false },
});

module.exports = pool;