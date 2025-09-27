# fix-v12.py - Creates working v1.2

html_content = """<!DOCTYPE html>
<html>
<head>
    <title>MRProfiles FretboardKit v1.2 Working</title>
    <style>
        body { font-family: Arial; background: linear-gradient(135deg, #667eea, #764ba2); padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; }
        button { padding: 10px 20px; margin: 5px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #764ba2; }
        select { padding: 8px; margin: 5px; width: 250px; }
        #output { background: #f0f0f0; padding: 15px; margin: 20px 0; border-radius: 5px; font-family: monospace; white-space: pre; }
        #fretboard { width: 100%; height: 300px; border: 2px solid #e0e0e0; background: white; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎸 MRProfiles FretboardKit v1.2 - Working</h1>
        
        <div>
            <select id="profileSelect">
                <option value="">Select Profile</option>
                <option value="wes">Wes Montgomery - Jazz</option>
                <option value="jim">Jim Hall - Jazz</option>
                <option value="joe">Joe Pass - Jazz</option>
                <option value="greek">Greek Rebetiko</option>
                <option value="travis">Travis Picking</option>
            </select>
            <button onclick="showPitches()">Show Pitches</button>
            <button onclick="exportMusicXML()">Export MusicXML</button>
        </div>
        
        <svg id="fretboard"></svg>
        <div id="output"></div>
    </div>
    
    <script>
        // Profiles with correct patterns
        const profiles = {
            wes: {
                name: 'Wes Montgomery',
                patterns: [
                    {string: 3, fret: 3},  // Bb
                    {string: 3, fret: 6},  // Db
                    {string: 2, fret: 3},  // Eb
                    {string: 2, fret: 4},  // E
                    {string: 2, fret: 3},  // Eb
                    {string: 3, fret: 3}   // Bb
                ]
            },
            jim: {
                name: 'Jim Hall',
                patterns: [
                    {string: 1, fret: 3},  // G
                    {string: 1, fret: 5},  // A
                    {string: 0, fret: 3},  // G
                    {string: 0, fret: 5}   // A
                ]
            },
            joe: {
                name: 'Joe Pass',
                patterns: [
                    {string: 5, fret: 3},  // G
                    {string: 5, fret: 5},  // A
                    {string: 4, fret: 2},  // B
                    {string: 4, fret: 3}   // C
                ]
            },
            greek: {
                name: 'Greek Rebetiko',
                patterns: [
                    {string: 4, fret: 0},  // A
                    {string: 4, fret: 1},  // Bb
                    {string: 4, fret: 4},  // C#
                    {string: 3, fret: 2},  // D
                    {string: 4, fret: 0}   // A
                ]
            },
            travis: {
                name: 'Travis Picking',
                patterns: [
                    {string: 5, fret: 3},  // C bass
                    {string: 2, fret: 1},  // C melody
                    {string: 4, fret: 3},  // G bass
                    {string: 1, fret: 0}   // E melody
                ]
            }
        };
        
        // Standard tuning MIDI notes
        const tuning = [64, 59, 55, 50, 45, 40]; // E4, B3, G3, D3, A2, E2
        
        // Convert string/fret to MIDI
        function stringFretToMIDI(string, fret) {
            return tuning[string] + fret;
        }
        
        // Convert MIDI to note name
        function midiToNoteName(midi) {
            const notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
            const octave = Math.floor(midi / 12) - 1;
            const note = notes[midi % 12];
            return note + octave;
        }
        
        // Show pitches
        function showPitches() {
            const profileId = document.getElementById('profileSelect').value;
            if (!profileId) {
                alert('Please select a profile');
                return;
            }
            
            const profile = profiles[profileId];
            let output = 'Pitches for ' + profile.name + ':\\n\\n';
            
            profile.patterns.forEach((p, i) => {
                const midi = stringFretToMIDI(p.string, p.fret);
                const note = midiToNoteName(midi);
                output += (i+1) + '. String ' + (p.string+1) + ', Fret ' + p.fret + ' = ' + note + ' (MIDI ' + midi + ')\\n';
            });
            
            document.getElementById('output').textContent = output;
        }
        
        // Export MusicXML
        function exportMusicXML() {
            const profileId = document.getElementById('profileSelect').value;
            if (!profileId) {
                alert('Please select a profile');
                return;
            }
            
            const profile = profiles[profileId];
            
            let xml = '<?xml version="1.0" encoding="UTF-8"?>\\n';
            xml += '<!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 3.1 Partwise//EN" "http://www.musicxml.org/dtds/partwise.dtd">\\n';
            xml += '<score-partwise version="3.1">\\n';
            xml += '  <part-list>\\n';
            xml += '    <score-part id="P1">\\n';
            xml += '      <part-name>' + profile.name + '</part-name>\\n';
            xml += '    </score-part>\\n';
            xml += '  </part-list>\\n';
            xml += '  <part id="P1">\\n';
            xml += '    <measure number="1">\\n';
            xml += '      <attributes>\\n';
            xml += '        <divisions>256</divisions>\\n';
            xml += '        <time><beats>4</beats><beat-type>4</beat-type></time>\\n';
            xml += '        <clef><sign>G</sign><line>2</line></clef>\\n';
            xml += '      </attributes>\\n';
            
            profile.patterns.forEach(p => {
                const midi = stringFretToMIDI(p.string, p.fret);
                const notes = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B'];
                const octave = Math.floor(midi / 12) - 1;
                const noteIndex = midi % 12;
                const noteName = notes[noteIndex];
                const step = noteName.replace('#', '');
                const alter = noteName.includes('#') ? 1 : 0;
                
                xml += '      <note>\\n';
                xml += '        <pitch>\\n';
                xml += '          <step>' + step + '</step>\\n';
                if (alter) xml += '          <alter>' + alter + '</alter>\\n';
                xml += '          <octave>' + octave + '</octave>\\n';
                xml += '        </pitch>\\n';
                xml += '        <duration>256</duration>\\n';
                xml += '        <type>quarter</type>\\n';
                xml += '      </note>\\n';
            });
            
            xml += '    </measure>\\n';
            xml += '  </part>\\n';
            xml += '</score-partwise>';
            
            // Download
            const blob = new Blob([xml], {type: 'text/xml'});
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = profile.name + '.musicxml';
            a.click();
            
            document.getElementById('output').textContent = 
                'Downloaded: ' + profile.name + '.musicxml\\n\\n' +
                'Move from Downloads to: C:\\\\Users\\\\mike\\\\Documents\\\\Scores\\\\';
        }
        
        // Draw fretboard
        function drawFretboard() {
            const svg = document.getElementById('fretboard');
            
            // Draw strings
            for (let i = 0; i < 6; i++) {
                const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
                line.setAttribute('x1', '50');
                line.setAttribute('y1', 30 + i * 40);
                line.setAttribute('x2', '950');
                line.setAttribute('y2', 30 + i * 40);
                line.setAttribute('stroke', '#333');
                line.setAttribute('stroke-width', '2');
                svg.appendChild(line);
            }
            
            // Draw frets
            for (let i = 0; i <= 12; i++) {
                const line = document.createElementNS('http://www.w3.org/2000/svg', 'line');
                line.setAttribute('x1', 50 + i * 70);
                line.setAttribute('y1', '30');
                line.setAttribute('x2', 50 + i * 70);
                line.setAttribute('y2', '230');
                line.setAttribute('stroke', i === 0 ? '#000' : '#999');
                line.setAttribute('stroke-width', i === 0 ? '4' : '2');
                svg.appendChild(line);
            }
        }
        
        // Initialize
        drawFretboard();
    </script>
</body>
</html>"""

# Write the file
with open('MRProfiles-FretboardKit-v1.2-WORKING.html', 'w') as f:
    f.write(html_content)

print("Created: MRProfiles-FretboardKit-v1.2-WORKING.html")
print("Open this file in your browser to use it.")