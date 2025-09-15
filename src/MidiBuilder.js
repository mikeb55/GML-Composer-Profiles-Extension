// MidiBuilder.js - Proper MIDI file generator
class MidiBuilder {
  constructor() {
    this.buffer = [];
    this.ticksPerQuarter = 480;
  }
  
  // Variable length quantity encoding (CORRECT)
  writeVarLength(value) {
    const bytes = [];
    do {
      bytes.unshift(value & 0x7F);
      value >>>= 7;
    } while (value > 0);
    
    for (let i = 0; i < bytes.length - 1; i++) {
      bytes[i] |= 0x80;
    }
    return bytes;
  }
  
  buildMidi(composition) {
    const midi = [];
    
    // Header
    midi.push(...[0x4D, 0x54, 0x68, 0x64]); // MThd
    midi.push(...[0x00, 0x00, 0x00, 0x06]); // Header size
    midi.push(...[0x00, 0x01]);             // Format 1
    midi.push(...[0x00, 0x02]);             // 2 tracks
    midi.push(...this.int16(this.ticksPerQuarter));
    
    // Tempo track
    const tempoTrack = this.buildTempoTrack();
    midi.push(...tempoTrack);
    
    // Note track
    const noteTrack = this.buildNoteTrack(composition);
    midi.push(...noteTrack);
    
    return Buffer.from(midi);
  }
  
  buildTempoTrack() {
    const track = [];
    const events = [];
    
    // Tempo
    events.push(0x00, 0xFF, 0x51, 0x03);
    events.push(0x07, 0xA1, 0x20); // 120 BPM
    
    // Time signature
    events.push(0x00, 0xFF, 0x58, 0x04);
    events.push(0x04, 0x02, 0x18, 0x08); // 4/4
    
    // End
    events.push(0x00, 0xFF, 0x2F, 0x00);
    
    // Track header
    track.push(...[0x4D, 0x54, 0x72, 0x6B]); // MTrk
    track.push(...this.int32(events.length));
    track.push(...events);
    
    return track;
  }
  
  buildNoteTrack(composition) {
    const track = [];
    const events = [];
    
    // Piano
    events.push(0x00, 0xC0, 0x00);
    
    if (composition && composition.allNotes && composition.allNotes.length > 0) {
      // Build note on/off events
      const noteEvents = [];
      
      composition.allNotes.forEach(note => {
        noteEvents.push({
          tick: note.tick || 0,
          type: 'on',
          pitch: note.pitch,
          velocity: note.velocity || 64
        });
        
        noteEvents.push({
          tick: (note.tick || 0) + (note.duration || 480),
          type: 'off',
          pitch: note.pitch,
          velocity: 0
        });
      });
      
      // Sort by time
      noteEvents.sort((a, b) => a.tick - b.tick);
      
      // Convert to MIDI events
      let lastTick = 0;
      noteEvents.forEach(evt => {
        const delta = evt.tick - lastTick;
        events.push(...this.writeVarLength(delta));
        
        if (evt.type === 'on') {
          events.push(0x90, evt.pitch & 0x7F, evt.velocity & 0x7F);
        } else {
          events.push(0x80, evt.pitch & 0x7F, 0);
        }
        
        lastTick = evt.tick;
      });
      
      console.log(`Added ${noteEvents.length} MIDI events`);
    } else {
      // Fallback C major scale
      console.log('No notes found - adding default scale');
      [60,62,64,65,67,69,71,72].forEach(pitch => {
        events.push(0x00, 0x90, pitch, 0x40);
        events.push(0x60, 0x80, pitch, 0x00);
      });
    }
    
    // End track
    events.push(0x00, 0xFF, 0x2F, 0x00);
    
    // Track header
    track.push(...[0x4D, 0x54, 0x72, 0x6B]);
    track.push(...this.int32(events.length));
    track.push(...events);
    
    return track;
  }
  
  int16(v) { return [(v >>> 8) & 0xFF, v & 0xFF]; }
  int32(v) { return [(v >>> 24) & 0xFF, (v >>> 16) & 0xFF, (v >>> 8) & 0xFF, v & 0xFF]; }
}

module.exports = MidiBuilder;
