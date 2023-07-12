<template>
  <head> </head>

  <body>
    <div class="container">
      <input v-model="message" placeholder="입력" @keyup.enter="sendMessage" />
      <div>
        {{ recv?.data }}
      </div>
    </div>
  </body>
</template>

<script setup lang="ts">
import { onUnmounted, ref } from 'vue'

const ws = new WebSocket('ws://localhost:8080')

const recv = ref()
const message = ref('')

// ws.addEventListener('open', () => {
//   ws.send(message.value)
// })

ws.addEventListener('message', (event) => {
  console.log(event.data)
  recv.value = event.data
})

const sendMessage = () => {
  ws.send(
    JSON.stringify({
      event: 'message',
      data: message.value
    })
  )
  message.value = ''
}

ws.onopen = function () {
  console.log('Connected')
  ws.send(
    JSON.stringify({
      event: 'events',
      data: 'test'
    })
  )
  ws.onmessage = function (data) {
    console.log(data)
    recv.value = data
  }
}

onUnmounted(() => {
  ws.onclose = () => {
    console.log("websocket closed");
  }
})
</script>

<style scoped>
@media (min-width: 1024px) {
  .chat {
    min-height: 100vh;
    display: flex;
    align-items: center;
  }
}

.container {
  display: flex;
  flex-direction: column;
}
</style>
