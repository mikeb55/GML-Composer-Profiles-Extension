#!/bin/bash

echo "🛡️ BULLETPROOF SERVER & FILE SAVE TEST"
echo "======================================"

# Step 1: Create test directory
echo "1. Creating directory..."
mkdir -p composer-profiles-data
if [ -d "composer-profiles-data" ]; then
    echo "✅ Directory created/exists"
else
    echo "❌ Directory creation failed"
    exit 1
fi

# Step 2: Create minimal test server
echo "2. Creating test server..."
cat > test_server.js << 'SERVER'
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 9999;
const DIR = path.join(__dirname, 'composer-profiles-data');

if (!fs.existsSync(DIR)) fs.mkdirSync(DIR, { recursive: true });

http.createServer((req, res) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    
    if (req.method === 'POST' && req.url === '/save') {
        let body = '';
        req.on('data', chunk => body += chunk);
        req.on('end', () => {
            const filename = 'test_' + Date.now() + '.json';
            fs.writeFileSync(path.join(DIR, filename), body);
            res.writeHead(200);
            res.end(JSON.stringify({ success: true, file: filename }));
        });
    } else {
        res.writeHead(200);
        res.end('Server running');
    }
}).listen(PORT, () => console.log('Test server on port ' + PORT));

setTimeout(() => {
    console.log('Auto-closing after 10 seconds...');
    process.exit(0);
}, 10000);
SERVER

# Step 3: Create test HTML
echo "3. Creating test client..."
cat > test_client.html << 'CLIENT'
<!DOCTYPE html>
<html>
<head><title>Test</title></head>
<body>
<h1>BULLETPROOF Test</h1>
<button onclick="testSave()">Test Save</button>
<div id="result"></div>
<script>
async function testSave() {
    const testData = {
        name: 'test_profile',
        timestamp: Date.now(),
        notes: [60, 62, 64],
        test: true
    };
    
    try {
        const response = await fetch('http://localhost:9999/save', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(testData)
        });
        const result = await response.json();
        document.getElementById('result').innerHTML = 
            result.success ? '✅ SAVED: ' + result.file : '❌ FAILED';
    } catch (err) {
        document.getElementById('result').innerHTML = '❌ Server not running';
    }
}

// Auto-test after 1 second
setTimeout(testSave, 1000);
</script>
</body>
</html>
CLIENT

# Step 4: Check if Node.js exists
echo "4. Checking Node.js..."
if command -v node &> /dev/null; then
    echo "✅ Node.js found: $(node --version)"
else
    echo "❌ Node.js NOT installed!"
    echo "   Download from: https://nodejs.org"
    exit 1
fi

# Step 5: Start server in background
echo "5. Starting test server..."
node test_server.js &
SERVER_PID=$!
sleep 2

# Step 6: Open test page
echo "6. Opening test page..."
start test_client.html

# Step 7: Wait and check for files
echo "7. Waiting 5 seconds for test..."
sleep 5

# Step 8: Check if files were created
echo "8. Checking for saved files..."
if ls composer-profiles-data/test_*.json 1> /dev/null 2>&1; then
    echo "✅ SUCCESS! Files saved:"
    ls -la composer-profiles-data/test_*.json
else
    echo "❌ No files saved - something failed"
fi

# Step 9: Cleanup
echo "9. Cleaning up..."
kill $SERVER_PID 2>/dev/null

echo ""
echo "======================================"
echo "TEST COMPLETE"
echo "Check: composer-profiles-data/ for test files"
echo "======================================"
