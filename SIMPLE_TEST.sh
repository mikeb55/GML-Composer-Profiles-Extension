#!/bin/bash

echo "SIMPLE FILE SAVE TEST"
echo "===================="

# 1. Create directory
mkdir -p composer-profiles-data
echo "✅ Directory ready"

# 2. Create a simple test file directly
echo '{"name":"test","notes":[60,62,64]}' > composer-profiles-data/direct_test.json

# 3. Check if it saved
if [ -f "composer-profiles-data/direct_test.json" ]; then
    echo "✅ File system write WORKS!"
    echo "   File saved at: composer-profiles-data/direct_test.json"
    cat composer-profiles-data/direct_test.json
else
    echo "❌ Cannot write to file system"
fi

# 4. Test if Node.js exists
if command -v node &> /dev/null; then
    echo "✅ Node.js installed: $(node --version)"
    
    # 5. Create minimal Node test
    echo 'console.log("Node works");' > test.js
    node test.js
    rm test.js
else
    echo "❌ Node.js NOT installed"
    echo "   You need Node.js for the server approach"
    echo "   Download from: https://nodejs.org"
fi

echo ""
echo "RESULTS:"
ls -la composer-profiles-data/
