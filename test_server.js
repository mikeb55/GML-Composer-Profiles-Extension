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
