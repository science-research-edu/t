<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>Switch Browser Deep Test</title>

<style>
body{
    background:#111;
    color:white;
    font-family:Arial;
    text-align:center;
    padding:20px;
}

.box{
    background:#1d1d1d;
    padding:15px;
    margin:15px auto;
    border-radius:10px;
    max-width:700px;
}

.pass{color:lime;}
.fail{color:red;}
.warn{color:orange;}

canvas{
    background:black;
    border:2px solid white;
}
</style>
</head>

<body>

<h1>🎮 Deep Browser Capability Test</h1>

<div class="box">
<h2>WebGL</h2>
<p id="webgl"></p>
</div>

<div class="box">
<h2>Other Graphics APIs</h2>
<p id="graphics"></p>
</div>

<div class="box">
<h2>WebAssembly</h2>
<p id="wasm"></p>
</div>

<div class="box">
<h2>Canvas Test</h2>
<canvas id="c" width="300" height="120"></canvas>
<p>If square moves, Canvas works.</p>
</div>

<div class="box">
<h2>Video Codec Tests</h2>

<p>MP4 H264</p>
<video id="mp4" width="250" controls>
<source src="https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4" type="video/mp4">
</video>
<p id="mp4r"></p>

<p>WebM</p>
<video id="webm" width="250" controls>
<source src="https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.webm" type="video/webm">
</video>
<p id="webmr"></p>

<p>OGG/Theora</p>
<video id="ogg" width="250" controls>
<source src="https://upload.wikimedia.org/wikipedia/commons/transcoded/b/bd/Big_Buck_Bunny_Trailer_400p.ogv/Big_Buck_Bunny_Trailer_400p.ogv.360p.webm" type="video/ogg">
</video>
<p id="oggr"></p>

</div>

<div class="box">
<h2>Audio Tests</h2>

<button onclick="play('a1')">MP3</button>
<button onclick="play('a2')">OGG</button>
<button onclick="play('a3')">WAV</button>

<audio id="a1" src="https://interactive-examples.mdn.mozilla.net/media/cc0-audio/t-rex-roar.mp3"></audio>

<audio id="a2" src="https://upload.wikimedia.org/wikipedia/commons/c/c8/Example.ogg"></audio>

<audio id="a3" src="https://www2.cs.uic.edu/~i101/SoundFiles/BabyElephantWalk60.wav"></audio>

<p id="audio"></p>
</div>

<div class="box">
<h2>Gamepad API</h2>
<p id="gamepad">Press Joy-Con buttons...</p>
</div>

<div class="box">
<h2>Keyboard Test</h2>
<h1 id="key">---</h1>
</div>

<script>

/* WEBGL */

let gl=document.createElement("canvas").getContext("webgl");

document.getElementById("webgl").innerHTML=
gl
? '<span class="pass">✅ WebGL Supported</span>'
: '<span class="fail">❌ WebGL Blocked</span>';

/* OTHER GRAPHICS */

let results=[];

results.push(
window.WebGPU
? "✅ WebGPU"
: "❌ WebGPU"
);

results.push(
window.WebGL2RenderingContext
? "✅ WebGL2"
: "❌ WebGL2"
);

results.push(
window.OffscreenCanvas
? "✅ OffscreenCanvas"
: "❌ OffscreenCanvas"
);

document.getElementById("graphics").innerHTML=results.join("<br>");

/* WASM */

document.getElementById("wasm").innerHTML=
(typeof WebAssembly==="object")
? '<span class="pass">✅ WebAssembly Supported</span>'
: '<span class="fail">❌ WebAssembly Missing</span>';

/* CANVAS */

const c=document.getElementById("c");
const ctx=c.getContext("2d");

let x=0;

function anim(){

    ctx.clearRect(0,0,c.width,c.height);

    ctx.fillStyle="lime";
    ctx.fillRect(x,40,40,40);

    x+=2;

    if(x>300)x=-40;

    requestAnimationFrame(anim);
}

anim();

/* VIDEO */

function testVideo(id,res){

let v=document.getElementById(id);

v.onplay=()=>{
document.getElementById(res).innerHTML=
'<span class="pass">✅ Works</span>';
};

v.onerror=()=>{
document.getElementById(res).innerHTML=
'<span class="fail">❌ Failed</span>';
};

}

testVideo("mp4","mp4r");
testVideo("webm","webmr");
testVideo("ogg","oggr");

/* AUDIO */

function play(id){

document.getElementById(id).play()
.then(()=>{
document.getElementById("audio").innerHTML=
'<span class="pass">✅ Audio Works</span>';
})
.catch(()=>{
document.getElementById("audio").innerHTML=
'<span class="fail">❌ Audio Failed</span>';
});

}

/* GAMEPAD */

setInterval(()=>{

let gps=navigator.getGamepads
? navigator.getGamepads()
: [];

let found=false;

for(let gp of gps){

if(gp){

found=true;

let pressed=[];

gp.buttons.forEach((b,i)=>{
if(b.pressed)pressed.push(i);
});

document.getElementById("gamepad").innerHTML=
"✅ Connected<br>Buttons: "+pressed.join(", ");

break;
}

}

if(!found){

document.getElementById("gamepad").innerHTML=
'<span class="warn">⚠ No Gamepad Detected</span>';

}

},100);

/* KEYBOARD */

document.addEventListener("keydown",(e)=>{

document.getElementById("key").innerText=e.key;

});

</script>

</body>
</html>
