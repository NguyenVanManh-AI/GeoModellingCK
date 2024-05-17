<template>
    <section>
      <h2>Upload</h2>
      <label>
        Upload a panoramic image:
        <input id="imageInput" type="file" accept="image/*" @change="loadImage" />
      </label>
      <ul>
        <li>The image should be formatted with the equirectangular projection.</li>
        <li>The image should have an aspect ratio of 2:1 (the width must be exactly twice the height).</li>
      </ul>
      <p>A cubemap will be generated from your image.</p>
  
      <section class="settings">
        <h2>Settings</h2>
        <div>
          <label>
            Cube Rotation:
            <input id="cubeRotation" type="number" min="0" max="359" v-model="rotation" @change="loadImage" />°
          </label>
        </div>
        <fieldset title="The resampling algorithm to use when generating the cubemap.">
          <legend>Interpolation type</legend>
          <label>
            <input type="radio" name="interpolation" value="lanczos" v-model="interpolation" @change="loadImage" />Lanczos (best but slower)
          </label>
          <label>
            <input type="radio" name="interpolation" value="cubic" v-model="interpolation" @change="loadImage" />Cubic (sharper details)
          </label>
          <label>
            <input type="radio" name="interpolation" value="linear" v-model="interpolation" @change="loadImage" />Linear (softer details)
          </label>
        </fieldset>
        <fieldset>
          <legend>Output format</legend>
          <label>
            <input type="radio" name="format" value="png" v-model="format" @change="loadImage" />PNG
          </label>
          <label>
            <input type="radio" name="format" value="jpg" v-model="format" @change="loadImage" />JPEG
          </label>
        </fieldset>
      </section>
  
      <section>
        <h2>Output</h2>
        <p>Click each cube face to save it to your computer.</p>
        <div id="cubemap">
          <b id="generating" v-show="generating">Generating...</b>
          <output id="faces">
            <a v-for="face in faces" :key="face.faceName" :href="face.url" :download="face.download">
              <img :src="face.preview" :title="face.faceName" />
            </a>
          </output>
        </div>
        <button @click="uploadImages">Upload Images</button>
      </section>
    </section>
  </template>
  
  <script>
  import { ref } from 'vue';
  
  export default {
    setup() {
      const rotation = ref(180);
      const interpolation = ref('lanczos');
      const format = ref('png');
      const generating = ref(false);
      const faces = ref([]);
  
      var fullfile ;
      const loadImage = (event) => {
        const file = event.target.files[0];
        fullfile = file;
  
        if (!file) return;
  
        const img = new Image();
        img.src = URL.createObjectURL(file);
        img.onload = () => {
          const canvas = document.createElement('canvas');
          const ctx = canvas.getContext('2d');
          canvas.width = img.width;
          canvas.height = img.height;
          ctx.drawImage(img, 0, 0);
          const data = ctx.getImageData(0, 0, canvas.width, canvas.height);
  
          processImage(data);
        };
      };
  
      const processImage = (data) => {
        faces.value = [];
        generating.value = true;
  
        const facePositions = {
          pz: { x: 1, y: 1 },
          nz: { x: 3, y: 1 },
          px: { x: 2, y: 1 },
          nx: { x: 0, y: 1 },
          py: { x: 1, y: 0 },
          ny: { x: 1, y: 2 }
        };
  
        const options = {
          data,
          rotation: Math.PI * rotation.value / 180,
          interpolation: interpolation.value
        };
  
        Object.entries(facePositions).forEach(([faceName, position]) => {
          renderFace(data, faceName, position, options);
        });
      };
  
      const renderFace = (data, faceName, position, options) => {
        const worker = new Worker('convert.js');
  
        worker.onmessage = ({ data: imageData }) => {
          const canvas = document.createElement('canvas');
          const ctx = canvas.getContext('2d');
          canvas.width = imageData.width;
          canvas.height = imageData.height;
          ctx.putImageData(imageData, 0, 0);
  
          canvas.toBlob((blob) => {
            const url = URL.createObjectURL(blob);
            faces.value.push({
              faceName,
              preview: url,
              download: `${faceName}.${format.value}`,
              url
            });
  
            if (faces.value.length === 6) {
              generating.value = false;
            }
          }, `image/${format.value}`);
        };
  
        worker.postMessage({ ...options, face: faceName });
      };
      const uploadImages = () => {
  if (faces.value.length !== 6) {
    console.error("You must generate all 6 faces before uploading.");
    return;
  }

  const formData = new FormData();
  const promises = [];

  faces.value.forEach(face => {
    promises.push(
      fetch(face.url)
        .then(response => response.blob())
        .then(blob => {
          formData.append(face.faceName, blob);
          console.log(blob);
        })
        .catch(error => {
          console.error('Error fetching image:', error);
        })
    );
  });

  console.log(formData);
  Promise.all(promises)
    .then(() => {
      formData.append('imagefull', fullfile);
      formData.append('address', "Khoa CNTT Bach Khoa");
      formData.append('coordinates', JSON.stringify([47.41322, -1.219482]));

      fetch('http://localhost:8000/api/map/add', {
        method: 'POST',
        body: formData
      })
      .then(response => {
        if (!response.ok) {
          throw new Error('Error uploading images.');
        }
        return response.json();
      })
      .then(data => {
        console.log('Images uploaded successfully.', data);
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
};

  
    return {
      rotation,
      interpolation,
      format,
      generating,
      faces,
      loadImage,
      uploadImages
    };
    }
  };
  </script>
  