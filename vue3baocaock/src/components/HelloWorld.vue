<template>
  <div id="main">
    <div id="left">
    <div class="form-group">
    <label for="exampleFormControlSelect1">Select Map</label>
    <select @change="loadMap" v-model="name_map" class="form-control" id="exampleFormControlSelect1">
      <option value="bachkhoa">bachkhoa</option>
      <option value="pisa">pisa</option>
    </select>
  </div>
  </div>
  <div ref="threejsContainer" class="threejs-container"></div>
  </div>

</template>

<script>
import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls';

export default {
  name: 'HelloWorld',
  data() {
    return {
      renderer: null,
      scene: null,
      camera: null,
      cubeCamera: null,
      lightProbe: null,
      name_map: "bachkhoa",
    };
  },
  mounted() {
    this.init();
    window.addEventListener('resize', this.onWindowResize);
  },
  beforeUnmount() {
    window.removeEventListener('resize', this.onWindowResize);
    this.dispose();
  },
  methods: {
    loadMap() {
      this.dispose();
      this.init();
    },
    init() {
      const container = this.$refs.threejsContainer;

      // Renderer
      this.renderer = new THREE.WebGLRenderer({ antialias: true });
      this.renderer.setPixelRatio(window.devicePixelRatio);
      this.renderer.setSize(container.clientWidth, window.innerHeight);
      container.appendChild(this.renderer.domElement);

      // Scene
      this.scene = new THREE.Scene();

      // Camera
      this.camera = new THREE.PerspectiveCamera(50, container.clientWidth / window.innerHeight, 1, 1000);
      this.camera.position.set(0, 0, 30);

      // Cube Camera
      const cubeRenderTarget = new THREE.WebGLCubeRenderTarget(256);
      this.cubeCamera = new THREE.CubeCamera(1, 1000, cubeRenderTarget);

      // Controls
      const controls = new OrbitControls(this.camera, this.renderer.domElement);
      controls.addEventListener('change', this.renderScene);
      controls.minDistance = 10;
      controls.maxDistance = 50;
      controls.enablePan = false;

      // Light Probe
      this.lightProbe = new THREE.LightProbe();
      this.scene.add(this.lightProbe);

      this.loadEnvironmentMap(this.name_map);
    },
    loadEnvironmentMap(mapName) {
      const genCubeUrls = (prefix, postfix) => {
        return [
          `${prefix}px${postfix}`, `${prefix}nx${postfix}`,
          `${prefix}py${postfix}`, `${prefix}ny${postfix}`,
          `${prefix}pz${postfix}`, `${prefix}nz${postfix}`,
        ];
      };

      const urls = genCubeUrls(mapName + '/', '.png');
      new THREE.CubeTextureLoader().load(urls, (cubeTexture) => {
        this.scene.background = cubeTexture;
        this.cubeCamera.update(this.renderer, this.scene);
        this.renderScene();
      });
    },
    dispose() {
      if (this.renderer) {
        this.renderer.dispose();
        this.renderer.domElement.remove();
      }
      if (this.scene) {
        this.scene.traverse((object) => {
          if (!object.isMesh) return;
          object.geometry.dispose();

          if (object.material.isMaterial) {
            this.cleanMaterial(object.material);
          } else {
            for (const material of object.material) this.cleanMaterial(material);
          }
        });
      }
    },
    cleanMaterial(material) {
      material.dispose();

      for (const key of Object.keys(material)) {
        const value = material[key];
        if (value && typeof value === 'object' && 'minFilter' in value) {
          value.dispose();
        }
      }
    },
    onWindowResize() {
      const container = this.$refs.threejsContainer;
      this.renderer.setSize(container.clientWidth, window.innerHeight);
      this.camera.aspect = container.clientWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();
      this.renderScene();
    },
    renderScene() {
      if (this.renderer && this.scene && this.camera) {
        this.renderer.render(this.scene, this.camera);
      }
    },
  },
};
</script>
<style scoped>
#left {
  width: 40vw;
}
.threejs-container {
  width: 60vw;
  height: 100vh;
}
.threejs-container canvas {
  width: 100% !important;
  height: 100% !important;
}
#main {
  display: flex;
}
</style>