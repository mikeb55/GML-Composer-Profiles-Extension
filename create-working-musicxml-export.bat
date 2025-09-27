@echo off
cd C:\Users\mike\Documents\gml-workspace\gml-composer-profiles-extension

echo Creating working MusicXML exporter...

(
echo ^<html^>^<body style="font-family:Arial;padding:20px;"^>
echo ^<h1^>Working MusicXML Export^</h1^>
echo ^<button onclick="exportValid()"^>Export Valid MusicXML^</button^>
echo ^<div id="out" style="margin:20px 0;padding:15px;background:#f0f0f0;"^>Ready^</div^>
echo ^<script^>
echo function exportValid(){
echo var xml='';
echo xml+='^<?xml version="1.0" encoding="UTF-8"?^>\n';
echo xml+='^<!DOCTYPE score-partwise PUBLIC "-//Recordare//DTD MusicXML 3.1 Partwise//EN" "http://www.musicxml.org/dtds/partwise.dtd"^>\n';
echo xml+='^<score-partwise version="3.1"^>\n';
echo xml+=' ^<part-list^>\n';
echo xml+='  ^<score-part id="P1"^>^<part-name^>Guitar^</part-name^>^</score-part^>\n';
echo xml+=' ^</part-list^>\n';
echo xml+=' ^<part id="P1"^>\n';
echo xml+='  ^<measure number="1"^>\n';
echo xml+='   ^<attributes^>\n';
echo xml+='    ^<divisions^>256^</divisions^>\n';
echo xml+='    ^<key^>^<fifths^>0^</fifths^>^</key^>\n';
echo xml+='    ^<time^>^<beats^>4^</beats^>^<beat-type^>4^</beat-type^>^</time^>\n';
echo xml+='    ^<clef^>^<sign^>G^</sign^>^<line^>2^</line^>^</clef^>\n';
echo xml+='   ^</attributes^>\n';
echo xml+='   ^<note^>\n';
echo xml+='    ^<pitch^>^<step^>C^</step^>^<octave^>4^</octave^>^</pitch^>\n';
echo xml+='    ^<duration^>256^</duration^>^<type^>quarter^</type^>\n';
echo xml+='   ^</note^>\n';
echo xml+='   ^<note^>\n';
echo xml+='    ^<pitch^>^<step^>E^</step^>^<octave^>4^</octave^>^</pitch^>\n';
echo xml+='    ^<duration^>256^</duration^>^<type^>quarter^</type^>\n';
echo xml+='   ^</note^>\n';
echo xml+='   ^<note^>\n';
echo xml+='    ^<pitch^>^<step^>G^</step^>^<octave^>4^</octave^>^</pitch^>\n';
echo xml+='    ^<duration^>256^</duration^>^<type^>quarter^</type^>\n';
echo xml+='   ^</note^>\n';
echo xml+='   ^<note^>\n';
echo xml+='    ^<pitch^>^<step^>C^</step^>^<octave^>5^</octave^>^</pitch^>\n';
echo xml+='    ^<duration^>256^</duration^>^<type^>quarter^</type^>\n';
echo xml+='   ^</note^>\n';
echo xml+='  ^</measure^>\n';
echo xml+=' ^</part^>\n';
echo xml+='^</score-partwise^>';
echo var blob=new Blob([xml],{type:'text/xml'});
echo var a=document.createElement('a');
echo a.href=URL.createObjectURL(blob);
echo a.download='test-valid.musicxml';
echo a.click();
echo document.getElementById('out').innerHTML='Downloaded test-valid.musicxml - This should work in Sibelius';
echo }
echo ^</script^>^</body^>^</html^>
) > working-musicxml-export.html

echo Opening working exporter...
start working-musicxml-export.html
echo.
echo Done! Click the button to export a valid MusicXML file.
pause