-- MySQL Database Initialization Script
-- Creates database, tables, and sample data for DevOps Platform

-- Create database
CREATE DATABASE IF NOT EXISTS devopsdb;
USE devopsdb;

-- Create messages table
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample messages
INSERT INTO messages (message) VALUES 
('DevOps Final Project Database Connected Successfully'),
('Welcome to Secure Cloud-Native DevOps Platform'),
('MySQL Database is Running and Operational');

-- Create users table for extended functionality
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Create logs table for audit trail
CREATE TABLE IF NOT EXISTS audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    action VARCHAR(100) NOT NULL,
    details TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert initial audit log
INSERT INTO audit_logs (action, details) VALUES 
('DATABASE_INITIALIZATION', 'DevOps Platform database initialized successfully');

-- Grant privileges
GRANT ALL PRIVILEGES ON devopsdb.* TO 'root'@'%' IDENTIFIED BY 'root';
FLUSH PRIVILEGES;
