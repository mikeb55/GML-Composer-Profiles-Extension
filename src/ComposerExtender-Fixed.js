const fs = require('fs');
const path = require('path');
const MidiBuilder = require('./MidiBuilder');

class ComposerExtender {
  constructor() {
    this.midiBuilder = new MidiBuilder();
    this.profiles = this.loadProfiles();
    this.originalMidi = null;
    this.sections = {};
    this.composition = null;
  }
  
  loadProfiles() {
    return {
      'Bach': { name: 'Bach', style: 'baroque' },
      'B.B. King': { name: 'B.B. King', style: 'blues' },
      'Coltrane': { name: 'Coltrane', style: 'jazz' },
      'original': { name: 'original', style: 'original' }
    };
  }
  
  importMidi(filepath) {
    try {
      this.originalMidi = fs.readFileSync(filepath);
      console.log(`✅ Imported: ${filepath} (${this.originalMidi.length} bytes)`);
      return true;
    } catch (e) {
      console.error(`Failed: ${e.message}`);
      return false;
    }
  }
  
  defineSections(config) {
    this.sections = config;
    console.log('Sections:', Object.keys(config).join(', '));
    return this;
  }
  
  generate() {
    this.composition = { allNotes: [] };
    let currentTick = 0;
    
    Object.entries(this.sections).forEach(([label, config]) => {
      const notes = this.generateSectionNotes(config.profile, config.measures || 4, currentTick);
      this.composition.allNotes.push(...notes);
      currentTick += (config.measures || 4) * 4 * 480; // 480 ticks per quarter
    });
    
    console.log(`Generated ${this.composition.allNotes.length} notes total`);
    return this.composition;
  }
  
  generateSectionNotes(profile, measures, startTick) {
    const notes = [];
    
    if (profile === 'Bach') {
      // Arpeggios
      const chord = [60, 64, 67, 72]; // C major
      for (let m = 0; m < measures; m++) {
        chord.forEach((pitch, i) => {
          notes.push({
            pitch: pitch,
            tick: startTick + m * 1920 + i * 480,
            duration: 480,
            velocity: 70
          });
        });
      }
    } else if (profile === 'B.B. King') {
      // Blues scale
      const blues = [60, 63, 65, 66, 67, 70];
      for (let m = 0; m < measures; m++) {
        notes.push({
          pitch: blues[m % 6],
          tick: startTick + m * 1920,
          duration: 1440, // Longer notes
          velocity: 80
        });
      }
    } else if (profile === 'Coltrane') {
      // Fast runs
      for (let m = 0; m < measures; m++) {
        for (let n = 0; n < 16; n++) {
          notes.push({
            pitch: 60 + (n % 12),
            tick: startTick + m * 1920 + n * 120,
            duration: 120,
            velocity: 65
          });
        }
      }
    } else {
      // Simple whole notes
      for (let m = 0; m < measures; m++) {
        notes.push({
          pitch: 60,
          tick: startTick + m * 1920,
          duration: 1920,
          velocity: 60
        });
      }
    }
    
    return notes;
  }
  
  exportMidi(filename) {
    const dir = path.dirname(filename);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    // USE THE MIDIBUILDER!
    const midiData = this.midiBuilder.buildMidi(this.composition);
    
    fs.writeFileSync(filename, midiData);
    console.log(`✅ Exported: ${filename} (${midiData.length} bytes with ${this.composition.allNotes.length} notes)`);
    return filename;
  }
}

module.exports = ComposerExtender;
