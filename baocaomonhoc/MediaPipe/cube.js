
import * as THREE from 'three';
var xSpeed= 1.0;
var direction= "stop";

var scene = new THREE.Scene();
scene.background = new THREE.Color( 0xFFFFFF );
var camera = new THREE.PerspectiveCamera(100, window.innerWidth/window.innerHeight, 1, 10000);
camera.position.z = 1000;
// Renderer
var renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);
// Cube
var geometry = new THREE.BoxGeometry(700, 700, 700, 10, 10, 10);
var material = new THREE.MeshBasicMaterial({color: 0x6D0394, wireframe: true});
var cube = new THREE.Mesh(geometry, material);
scene.add(cube);

function render() {
  requestAnimationFrame(render);
  if(direction=="right"){
    cube.position.x -= xSpeed;  
  } else if (direction=="left"){
    cube.position.x += xSpeed;
  } else {
  }
  renderer.render(scene, camera);
};

document.addEventListener("keydown", onDocumentKeyDown, false);
function onDocumentKeyDown(event) {
    var keyCode = event.which;
    // Izquierda
    if (keyCode == 37) {
      if (direction=="left"){
        direction= "stop";
      } else if (direction=="stop"){
        direction= "right";
      }
    // Derecha
    } else if (keyCode == 39) {
      if (direction=="right"){
        direction= "stop";
      } else if (direction=="stop"){
        direction= "left";
      }
    }
};

render();