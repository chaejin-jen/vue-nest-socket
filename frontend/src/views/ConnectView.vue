<template>
  <div class="radio-botton-group">
    <div>
      <input type="radio" :value="1" v-model="selected" />
      <label> websocket</label>
    </div>
    <div>
      <input type="radio" :value="2" v-model="selected" />
      <label> socketio</label>
    </div>
    <div>
      <input type="radio" :value="3" v-model="selected" />
      <label> namespace chat</label>
    </div>
  </div>
  <body>
    <WS v-if="selected == 1" />
    <SIO v-else-if="selected == 2" />
    <SIONS v-else-if="selected == 3" />
    
  </body>
</template>

<script setup lang="ts">
import { ref, onUpdated } from 'vue'
import WS from '@/components/connect/WebSocket.vue'
import SIO from '@/components/connect/SocketIO.vue'
import SIONS from '@/components/connect/SocketIONamespace.vue'

const selected = ref(2)
console.log(selected)

onUpdated(() => {
  if (selected.value !== null) {
    console.log('Selected value:', selected.value)
  }
})
</script>

<style>
.radio-botton-group {
  margin: 10px;
  justify-content: space-around;
}
</style>
