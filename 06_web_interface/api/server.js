const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");
require("dotenv").config();
const path = require("path");

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// ✅ Serve static files from 06_web_interface
app.use(express.static(path.join(__dirname, "..")));

// DB Pool
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
});

// Test Route
app.get("/", (req, res) => {
  res.send("Hospital DBA API is running");
});

// API route to fetch patients
app.get("/api/patients", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM patients");
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching patients:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// API route to fetch doctors
app.get("/api/doctors", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM doctors");
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching patients:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// API route to fetch appointments
app.get("/api/appointments", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM appointments");
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching appointments:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// API route to fetch treatments
app.get("/api/treatments", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM treatments");
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching treatments:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// API route to fetch billing data
app.get("/api/billing", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM billing");
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching billing data:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Start Server
app.listen(PORT, () => {
  console.log(`✅ Server running at http://localhost:${PORT}`);
});
