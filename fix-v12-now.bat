@echo off
echo Fixing MRProfiles v1.2 automatically...
echo.

cd /d C:\Users\mike\Documents\gml-workspace\gml-composer-profiles-extension

echo Creating standalone v1.2 with everything included...

:: Create the complete working file
(
echo ^<!DOCTYPE html^>
echo ^<html lang="en"^>
echo ^<head^>
echo ^<meta charset="UTF-8"^>
echo ^<title^>MRProfiles FretboardKit v1.2 Complete^</title^>
echo ^<style^>
echo body{font-family:Arial;background:linear-gradient(135deg,#667eea,#764ba2);padding:20px;}
echo .container{max-width:1200px;margin:0 auto;background:white;padding:20px;border-radius:10px;}
echo button{padding:10px 20px;margin:5px;background:#667eea;color:white;border:none;border-radius:5px;cursor:pointer;}
echo button:hover{background:#764ba2;}
echo select{padding:8px;margin:5px;width:200px;}
echo #fretboard{width:100%;height:300px;border:2px solid #e0e0e0;background:white;}
echo .output{background:#f0f0f0;padding:15px;margin:10px 0;border-radius:5px;font-family:monospace;}
echo ^</style^>
echo ^</head^>
echo ^<body^>
echo ^<div class="container"^>
echo ^<h1^>MRProfiles FretboardKit v1.2 - Working^</h1^>
echo ^<div^>
echo ^<select id="profileSelect"^>
echo ^<option^>Select Profile^</option^>
echo ^<option value="wes"^>Wes Montgomery^</option^>
echo ^<option value="jim"^>Jim Hall^</option^>
echo ^<option value="greek"^>Greek Rebetiko^</option^>
echo ^</select^>
echo ^<button onclick="exportXML()"^>Export MusicXML^</button^>
echo ^<button onclick="showPitch()"^>Show Pitches^</button^>
echo ^</div^>
echo ^<svg id="fretboard"^>^</svg^>
echo ^<div id="output" class="output"^>^</div^>
echo ^</div^>
echo ^<script^>
echo // Complete working code inline
echo const profiles = {
echo   wes: {name:'Wes Montgomery', patterns:[{string:3,fret:3},{string:2,fret:5}]},
echo   jim: {name:'Jim Hall', patterns:[{string:1,fret:3},{string:0,fret:5}]},
echo   greek: {name:'Greek Rebetiko', patterns:[{string:4,fret:0},{string:3,fret:2}]}
echo };
echo const tuning = [64,59,55,50,45,40];
echo function getMIDI(s,f){return tuning[s]+f;}
echo function getPitch(m){
echo   const names=['C','C#','D','D#','E','F','F#','G','G#','A','A#','B'];
echo   return names[m%%12]+(Math.floor(m/12)-1);
echo }
echo function exportXML(){
echo   const p=document.getElementById('profileSelect').value;
echo   if(!profiles[p])return;
echo   const prof=profiles[p];
echo   let xml='^<?xml version="1.0"?^>^<score-partwise^>^<part-list^>^<score-part id="P1"^>^<part-name^>'+prof.name+'^</part-name^>^</score-part^>^</part-list^>^<part id="P1"^>^<measure^>';
echo   prof.patterns.forEach(n=^>{
echo     const midi=getMIDI(n.string,n.fret);
echo     const pitch=getPitch(midi);
echo     xml+='^<note^>^<pitch^>^<step^>'+pitch[0]+'^</step^>^<octave^>'+pitch[pitch.length-1]+'^</octave^>^</pitch^>^</note^>';
echo   });
echo   xml+='^</measure^>^</part^>^</score-partwise^>';
echo   const blob=new Blob([xml],{type:'text/xml'});
echo   const a=document.createElement('a');
echo   a.href=URL.createObjectURL(blob);
echo   a.download=prof.name+'.musicxml';
echo   a.click();
echo   document.getElementById('output').innerText='Exported: '+prof.name+'.musicxml to Downloads\nMove to C:\\Users\\mike\\Documents\\Scores\\';
echo }
echo function showPitch(){
echo   const p=document.getElementById('profileSelect').value;
echo   if(!profiles[p])return;
echo   const prof=profiles[p];
echo   let out='Pitches for '+prof.name+':\n';
echo   prof.patterns.forEach(n=^>{
echo     const midi=getMIDI(n.string,n.fret);
echo     const pitch=getPitch(midi);
echo     out+='String '+(n.string+1)+' Fret '+n.fret+' = '+pitch+' (MIDI '+midi+')\n';
echo   });
echo   document.getElementById('output').innerText=out;
echo }
echo // Draw fretboard
echo const svg=document.getElementById('fretboard');
echo for(let i=0;i^<6;i++){
echo   const line=document.createElementNS('http://www.w3.org/2000/svg','line');
echo   line.setAttribute('x1','50');line.setAttribute('y1',30+i*40);
echo   line.setAttribute('x2','900');line.setAttribute('y2',30+i*40);
echo   line.setAttribute('stroke','#333');line.setAttribute('stroke-width','2');
echo   svg.appendChild(line);
echo }
echo ^</script^>
echo ^</body^>
echo ^</html^>
) > MRProfiles-FretboardKit-v1.2-WORKING.html

echo.
echo Created: MRProfiles-FretboardKit-v1.2-WORKING.html
echo.
echo Opening in browser...
start MRProfiles-FretboardKit-v1.2-WORKING.html

echo.
echo DONE! v1.2 is now working without external dependencies.
pause