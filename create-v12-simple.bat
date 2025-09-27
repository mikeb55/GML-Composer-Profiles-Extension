@echo off
cd C:\Users\mike\Documents\gml-workspace\gml-composer-profiles-extension

echo Creating v1.2 Working...

echo ^<html^>^<head^>^<title^>v1.2 Working^</title^>^</head^> > v12-working.html
echo ^<body style="font-family:Arial;padding:20px;"^> >> v12-working.html
echo ^<h1^>MRProfiles v1.2 - Simple Working Version^</h1^> >> v12-working.html
echo ^<select id="p"^>^<option^>Select^</option^>^<option value="w"^>Wes^</option^>^<option value="j"^>Jim^</option^>^</select^> >> v12-working.html
echo ^<button onclick="test()"^>Export^</button^> >> v12-working.html
echo ^<div id="o" style="background:#f0f0f0;padding:10px;margin:10px 0;"^>Output^</div^> >> v12-working.html
echo ^<script^> >> v12-working.html
echo function test(){ >> v12-working.html
echo var s=document.getElementById('p').value; >> v12-working.html
echo if(s=='w'){var n='Wes Montgomery';} >> v12-working.html
echo if(s=='j'){var n='Jim Hall';} >> v12-working.html
echo var x='^<?xml version="1.0"?^>^<score-partwise^>^<part-list^>^<score-part id="P1"^>^<part-name^>'+n+'^</part-name^>^</score-part^>^</part-list^>^</part^>^</score-partwise^>'; >> v12-working.html
echo var b=new Blob([x],{type:'text/xml'}); >> v12-working.html
echo var a=document.createElement('a'); >> v12-working.html
echo a.href=URL.createObjectURL(b); >> v12-working.html
echo a.download=n+'.musicxml'; >> v12-working.html
echo a.click(); >> v12-working.html
echo document.getElementById('o').innerHTML='Downloaded '+n+'.musicxml - Move to Scores folder'; >> v12-working.html
echo } >> v12-working.html
echo ^</script^>^</body^>^</html^> >> v12-working.html

echo.
echo Created: v12-working.html
echo Opening...
start v12-working.html

pause