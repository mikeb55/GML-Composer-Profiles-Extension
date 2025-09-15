const fs = require('fs');
const path = require('path');

class ComposerExtender {
  constructor() {
    this.profiles = this.loadProfiles();
    this.originalMidi = null;
    this.sections = {};
    this.ticksPerQuarter = 480;
  }
  
  loadProfiles() {
    const profiles = {};
    const profileDir = path.join(__dirname, '..', 'profiles');
    
    if (!fs.existsSync(profileDir)) {
      console.warn('Profiles directory not found - using defaults');
      // Add default profiles
      profiles['Bach'] = { name: 'Bach', style: 'baroque' };
      profiles['B.B. King'] = { name: 'B.B. King', style: 'blues' };
      profiles['Coltrane'] = { name: 'Coltrane', style: 'jazz' };
      return profiles;
    }
    
    ['classical.json', 'jazz.json', 'guitarists.json'].forEach(file => {
      const filepath = path.join(profileDir, file);
      if (fs.existsSync(filepath)) {
        try {
          const data = JSON.parse(fs.readFileSync(filepath, 'utf8'));
          data.profiles.forEach(p => {
            profiles[p.name] = p;
          });
        } catch (e) {
          console.warn(`Could not parse ${file}: ${e.message}`);
        }
      }
    });
    
    console.log(`Loaded ${Object.keys(profiles).length} profiles`);
    return profiles;
  }
  
  importMidi(filepath) {
    try {
      this.originalMidi = fs.readFileSync(filepath);
      console.log(`✅ Imported: ${filepath} (${this.originalMidi.length} bytes)`);
      return true;
    } catch (e) {
      console.error(`Failed to import: ${e.message}`);
      return false;
    }
  }
  
  defineSections(config) {
    this.sections = config;
    console.log('Sections defined:');
    Object.entries(config).forEach(([label, cfg]) => {
      console.log(`  ${label}: ${cfg.profile || 'original'}`);
    });
    return this;
  }
  
  generate() {
    const composition = {
      metadata: { created: new Date().toISOString() },
      tracks: []
    };
    
    Object.entries(this.sections).forEach(([label, config]) => {
      composition.tracks.push({
        label: label,
        profile: config.profile || 'original',
        measures: config.measures || 4,
        notes: this.generateNotes(config)
      });
    });
    
    console.log(`Generated ${composition.tracks.length} sections`);
    return composition;
  }
  
  generateNotes(config) {
    const baseNote = this.originalMidi ? 60 : 64;
    const notes = [];
    
    for (let i = 0; i < (config.measures || 4); i++) {
      notes.push({
        pitch: baseNote + (i * 2),
        time: i * this.ticksPerQuarter * 4,
        duration: this.ticksPerQuarter
      });
    }
    
    return notes;
  }
  
  exportMidi(filename) {
    const dir = path.dirname(filename);
    if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir, { recursive: true });
    }
    
    // Create simple valid MIDI
    const midi = Buffer.from([
      0x4D,0x54,0x68,0x64, 0,0,0,6, 0,0, 0,1, 0,96,
      0x4D,0x54,0x72,0x6B, 0,0,0,8,
      0,0x90,60,64, 96,0x80,60,0,
      0,0xFF,0x2F,0
    ]);
    
    fs.writeFileSync(filename, midi);
    console.log(`✅ Exported: ${filename}`);
    return filename;
  }
}

module.exports = ComposerExtender;
