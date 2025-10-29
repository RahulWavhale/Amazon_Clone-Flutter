import express, { json } from 'express';
import authRouter from './route/auth'; // Ensure this path is correct
import dash from './route/dashboard'; // Ensure this path is correct
import { createPool } from 'mysql2/promise'; // Use mysql2 for promise support

const app = express();
const Port = 3000;

// Create a pool of connections
const pool = createPool({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'amazon_clone',
  connectionLimit: 10,
});

// Middleware
app.use(json()); // To parse JSON bodies
app.use('/api', authRouter); // Use authRouter for API routes
app.use('/dashboard', dash);

// Routes
app.get("/", (req, res) => {
  res.send("Home Page");
});

// Global Error Handling Middleware
app.use((err, req, res, next) => {
  console.error("Unhandled Error:", err); // Log the error
  res.status(500).json({ msg: "Server Error", error: err.message }); // Send detailed error message
});

app.listen(Port, '0.0.0.0', () => {
  console.log(`Server is running on port ${Port}`);
});
