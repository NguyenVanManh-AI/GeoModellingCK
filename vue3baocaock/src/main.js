import { createApp } from 'vue'
import App from './App.vue'
const app = createApp(App);
import * as THREE from 'three';
import 'leaflet/dist/leaflet.css';
app.use(THREE)
app.mount('#app')
