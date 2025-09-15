const ComposerExtender = require('./src/ComposerExtender-Fixed');
const ext = new ComposerExtender();

console.log('🎵 Testing FIXED version...\n');

ext.importMidi('test/input/V4 Mist Chorus and Outro - 1 Sept 2025.mid');

ext.defineSections({
  A: { profile: 'Bach', measures: 4 },
  B: { profile: 'B.B. King', measures: 4 },
  C: { profile: 'Coltrane', measures: 4 }
});

const comp = ext.generate();
ext.exportMidi('test/output/V4-Fixed.mid');

console.log('\n✅ Created V4-Fixed.mid with REAL notes!');
