// Simple File Server for Composer-Profiles
const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8888;
const PROFILES_DIR = path.join(__dirname, 'composer-profiles-data');

// Create directory if it doesn't exist
if (!fs.existsSync(PROFILES_DIR)) {
    fs.mkdirSync(PROFILES_DIR, { recursive: true });
}

const server = http.createServer((req, res) => {
    // Enable CORS
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
    
    if (req.method === 'OPTIONS') {
        res.writeHead(200);
        res.end();
        return;
    }
    
    // Save profile
    if (req.method === 'POST' && req.url === '/save-profile') {
        let body = '';
        req.on('data', chunk => body += chunk);
        req.on('end', () => {
            try {
                const profile = JSON.parse(body);
                const filename = `${profile.name}_${Date.now()}.json`;
                const filepath = path.join(PROFILES_DIR, filename);
                
                fs.writeFileSync(filepath, JSON.stringify(profile, null, 2));
                res.writeHead(200, { 'Content-Type': 'application/json' });
                res.end(JSON.stringify({ success: true, filename }));
            } catch (err) {
                res.writeHead(500);
                res.end(JSON.stringify({ error: err.message }));
            }
        });
    }
    
    // List profiles
    else if (req.method === 'GET' && req.url === '/list-profiles') {
        const files = fs.readdirSync(PROFILES_DIR)
            .filter(f => f.endsWith('.json'))
            .map(f => ({
                filename: f,
                path: path.join(PROFILES_DIR, f)
            }));
        
        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(files));
    }
    
    // Serve index.html
    else if (req.url === '/' || req.url === '/index.html') {
        const html = fs.readFileSync('index.html', 'utf8');
        res.writeHead(200, { 'Content-Type': 'text/html' });
        res.end(html);
    }
    
    else {
        res.writeHead(404);
        res.end('Not found');
    }
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
    console.log(`Profiles will be saved to: ${PROFILES_DIR}`);
    console.log('Press Ctrl+C to stop');
});
