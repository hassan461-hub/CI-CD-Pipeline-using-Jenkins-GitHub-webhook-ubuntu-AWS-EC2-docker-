// Backend Express Server for DevOps Platform
// Connects to MySQL and provides REST API endpoints

require('dotenv').config();
const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// MySQL Connection Pool Configuration
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'mysql-db',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'root',
    database: process.env.DB_NAME || 'devopsdb',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Retry configuration
const MAX_RETRIES = 5;
const RETRY_DELAY = 2000; // 2 seconds

// Health check flag to track DB connection status
let dbConnected = false;

// Function to test database connection with retry logic
async function testDatabaseConnection(retries = 0) {
    try {
        const connection = await pool.getConnection();
        await connection.ping();
        connection.release();
        dbConnected = true;
        console.log('✓ Database connected successfully!');
        return true;
    } catch (error) {
        dbConnected = false;
        if (retries < MAX_RETRIES) {
            console.log(`Database connection attempt ${retries + 1}/${MAX_RETRIES} failed. Retrying in ${RETRY_DELAY}ms...`);
            console.log(`Error: ${error.message}`);
            
            return new Promise((resolve) => {
                setTimeout(() => {
                    resolve(testDatabaseConnection(retries + 1));
                }, RETRY_DELAY);
            });
        } else {
            console.error(`✗ Failed to connect to database after ${MAX_RETRIES} attempts`);
            console.error(`Database Error: ${error.message}`);
            return false;
        }
    }
}

// Initialize database connection on startup
testDatabaseConnection();

// ==================== ROUTES ====================

// Root endpoint
app.get('/', (req, res) => {
    res.status(200).json({
        message: 'Backend Running',
        version: '1.0.0',
        timestamp: new Date().toISOString()
    });
});

// Health check endpoint
app.get('/api/health', (req, res) => {
    const status = {
        status: 'ok',
        timestamp: new Date().toISOString(),
        database: dbConnected ? 'connected' : 'disconnected',
        uptime: process.uptime()
    };

    if (dbConnected) {
        res.status(200).json(status);
    } else {
        res.status(503).json(status);
    }
});

// API Message endpoint
app.get('/api/message', (req, res) => {
    res.status(200).json({
        success: true,
        message: 'DevOps Final Project Backend API Working',
        service: 'Secure Cloud-Native DevOps Platform',
        timestamp: new Date().toISOString(),
        environment: {
            node_version: process.version,
            port: PORT,
            database_status: dbConnected ? 'connected' : 'disconnected'
        }
    });
});

// Database test endpoint - checks connection and retrieves data
app.get('/api/db-test', async (req, res) => {
    try {
        const connection = await pool.getConnection();

        // Try to query the messages table
        const [rows] = await connection.query('SELECT * FROM messages LIMIT 1');

        connection.release();

        res.status(200).json({
            success: true,
            message: 'Database connection successful',
            data: rows[0] || { message: 'Database is ready but no messages found' },
            timestamp: new Date().toISOString()
        });
    } catch (error) {
        console.error('Database error:', error.message);

        res.status(500).json({
            success: false,
            message: 'Database connection failed',
            error: error.message,
            troubleshooting: [
                'Ensure MySQL container is running',
                'Check DB_HOST, DB_USER, DB_PASSWORD, DB_NAME environment variables',
                'Verify network connectivity between containers',
                'Check MySQL logs: docker logs mysql-db'
            ],
            timestamp: new Date().toISOString()
        });
    }
});

// 404 handler
app.use((req, res) => {
    res.status(404).json({
        error: 'Not Found',
        message: `Endpoint '${req.path}' does not exist`,
        availableEndpoints: [
            'GET /',
            'GET /api/health',
            'GET /api/message',
            'GET /api/db-test'
        ]
    });
});

// Error handler
app.use((err, req, res, next) => {
    console.error('Server error:', err);
    res.status(500).json({
        error: 'Internal Server Error',
        message: err.message,
        timestamp: new Date().toISOString()
    });
});

// ==================== START SERVER ====================
app.listen(PORT, () => {
    console.log(`
╔════════════════════════════════════════════════╗
║     DevOps Platform Backend Server Started      ║
╚════════════════════════════════════════════════╝
    Server: http://0.0.0.0:${PORT}
    Database: ${process.env.DB_HOST || 'mysql-db'}
    Node Version: ${process.version}
    Time: ${new Date().toISOString()}
    `);
});

// Graceful shutdown
process.on('SIGTERM', async () => {
    console.log('SIGTERM received, closing server gracefully...');
    await pool.end();
    process.exit(0);
});

process.on('SIGINT', async () => {
    console.log('SIGINT received, closing server gracefully...');
    await pool.end();
    process.exit(0);
});
