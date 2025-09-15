const ComposerExtender = require('./src/ComposerExtender');
const ext = new ComposerExtender();

console.log('🎵 Processing V4 Mist Chorus and Outro...\n');

// Import YOUR midi file
const imported = ext.importMidi('test/input/V4 Mist Chorus and Outro - 1 Sept 2025.mid');

if (!imported) {
  console.error('Could not find MIDI file!');
  process.exit(1);
}

// Create an interesting ABCD structure
ext.defineSections({
  A: { profile: 'original', measures: 8 },      // Your original
  B: { profile: 'Bach', measures: 8 },          // Bach treatment
  A2: { profile: 'original', variation: true }, // Original varied
  C: { profile: 'B.B. King', measures: 8 },     // Blues break
  D: { profile: 'Coltrane', measures: 8 },      // Jazz explosion
  A3: { profile: 'original', measures: 8 }      // Return home
});

const comp = ext.generate();
ext.exportMidi('test/output/V4-Mist-Extended.mid');

console.log('\n✅ Done! Check test/output/V4-Mist-Extended.mid');
