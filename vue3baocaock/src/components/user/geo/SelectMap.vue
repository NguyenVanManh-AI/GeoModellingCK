<template>
    <div style="height: 600px; width: 800px">
      <l-map ref="map" v-model:zoom="zoom" :center="[16.075017, 108.1532003]">
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          layer-type="base"
          name="OpenStreetMap"
        ></l-tile-layer>
  
        <!-- Hiển thị các marker từ danh sách điểm -->
        <l-marker v-for="(point, index) in points" :key="index" :lat-lng="point.coordinates" @click="showPopup(point)">
          <l-popup :content="point.name"></l-popup>
        </l-marker>
  
        <!-- Popup để hiển thị thông tin của điểm -->
        <!-- <l-popup :lat-lng="selectedPoint.coordinates" :content="selectedPoint.name" v-if="selectedPoint">
        </l-popup> -->
      </l-map>
    </div>
  </template>
  
  <script>
  import "leaflet/dist/leaflet.css";
  import { LMap, LTileLayer, LMarker, LPopup } from "@vue-leaflet/vue-leaflet";
  
  export default {
    name: "SelectMap",
    components: {
      LMap,
      LTileLayer,
      LMarker,
      LPopup,
    },
    data() {
      return {
        zoom: 12,
        points: [
          { name: "Địa điểm 1", coordinates: [16.0639056, 108.2466932] },
          { name: "Địa điểm 2", coordinates: [16.0515477, 108.2455815] },
          { name: "Địa điểm 3", coordinates: [16.075017, 108.1532003] },
        ],
        selectedPoint: null,
      };
    },
    mounted() {
      console.log(this.points[0]['coordinates']);
      console.log(JSON.stringify(this.points[0]['coordinates']));
    },
    methods: {
      showPopup(point) {
        // Hiển thị popup khi click vào marker
        this.selectedPoint = point;
        console.log(point);
      },
    },
  };
  </script>
  
  <style></style>
  