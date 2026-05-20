// Configuration
// Frontend runs on port 80, backend on port 3000
// This allows dynamic API calls based on hostname
const API_BASE_URL = `${window.location.protocol}//${window.location.hostname}:3000`;

// DOM Elements
const testBtn = document.getElementById('testBtn');
const responseBox = document.getElementById('response');
const backendStatus = document.getElementById('backendStatus');
const dbStatus = document.getElementById('dbStatus');

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    checkBackendHealth();
    checkDatabaseStatus();
    testBtn.addEventListener('click', testBackendAPI);
});

// Test Backend API
async function testBackendAPI() {
    responseBox.classList.add('show', 'loading');
    responseBox.innerHTML = '<span class="loading-spinner"></span>Testing backend API...';
    testBtn.disabled = true;

    try {
        const response = await fetch(`${API_BASE_URL}/api/message`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();
        
        responseBox.classList.remove('loading');
        responseBox.classList.add('success');
        responseBox.innerHTML = `
            <strong>✓ Success!</strong><br><br>
            <strong>Message from Backend:</strong><br>
            ${JSON.stringify(data, null, 2)}
        `;
    } catch (error) {
        responseBox.classList.remove('loading');
        responseBox.classList.add('error');
        responseBox.innerHTML = `
            <strong>✗ Error!</strong><br><br>
            <strong>Message:</strong><br>
            ${error.message}<br><br>
            <strong>API URL Tried:</strong><br>
            ${API_BASE_URL}/api/message<br><br>
            <strong>Troubleshooting:</strong><br>
            1. Check if backend service is running: docker ps<br>
            2. Check backend logs: docker logs backend-app<br>
            3. Verify MySQL connection from backend<br>
            4. Check firewall/security group allows port 3000
        `;
    } finally {
        testBtn.disabled = false;
    }
}

// Check Backend Health
async function checkBackendHealth() {
    try {
        const response = await fetch(`${API_BASE_URL}/api/health`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            backendStatus.classList.remove('checking', 'unhealthy');
            backendStatus.classList.add('healthy');
            backendStatus.textContent = '✓ Healthy';
        } else {
            throw new Error('Health check failed');
        }
    } catch (error) {
        backendStatus.classList.remove('checking', 'healthy');
        backendStatus.classList.add('unhealthy');
        backendStatus.textContent = '✗ Unhealthy';
    }
}

// Check Database Status
async function checkDatabaseStatus() {
    try {
        const response = await fetch(`${API_BASE_URL}/api/db-test`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json'
            }
        });

        if (response.ok) {
            const data = await response.json();
            if (data.success) {
                dbStatus.classList.remove('checking', 'unhealthy');
                dbStatus.classList.add('healthy');
                dbStatus.textContent = '✓ Connected';
            } else {
                throw new Error(data.message || 'Database connection failed');
            }
        } else {
            throw new Error('Database test endpoint failed');
        }
    } catch (error) {
        dbStatus.classList.remove('checking', 'healthy');
        dbStatus.classList.add('unhealthy');
        dbStatus.textContent = '✗ Disconnected';
    }
}

// Refresh status every 30 seconds
setInterval(checkBackendHealth, 30000);
setInterval(checkDatabaseStatus, 30000);
