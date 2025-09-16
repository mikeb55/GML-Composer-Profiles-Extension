const fs = require('fs');

class SimpleExtender {
  extend(inputFile, outputFile) {
    // Just copy input to output for now
    const data = fs.readFileSync(inputFile);
    fs.writeFileSync(outputFile, data);
    console.log('Copied (not extended yet):', outputFile);
  }
}

module.exports = SimpleExtender;
