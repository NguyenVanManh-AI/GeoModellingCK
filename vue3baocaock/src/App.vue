<template>
  <LeafletComp />
  <CubemapGenerator />
  <HelloWorld msg="Welcome to Your Vue.js App"/>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'
import LeafletComp from './components/LeafletComp.vue'
import CubemapGenerator from './components/CubemapGenerator.vue'

export default {
  name: 'App',
  components: {
    HelloWorld,
    LeafletComp,
    CubemapGenerator
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
