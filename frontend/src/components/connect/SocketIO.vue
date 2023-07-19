<template>
  <div>
    <button @click="sendMessage">Send Message</button>
    {{ recv }}
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { io } from 'socket.io-client'

// const socket = io('http://localhost:81', { transports: ['websocket'] })
// const socket = io('http://backend:81', { transports: ['websocket'] })
// const socket = io('http://test-back-dev:81', { transports: ['websocket'] })
// const socket = io('http://172.27.0.3:81', { transports: ['websocket'] })
// const socket = io('http://[::1]:81', { transports: ['websocket'] })
// const socket = io('http://localhost:81')
// const socket = io('http://backend:81')
// const socket = io('http://test-back-dev:3000')
// const socket = io('http://test-back-dev:3000', { transports: ['websocket'] })
// const socket = io('http://172.27.0.3:3000', { transports: ['websocket'] })
// const socket = io('http://0.0.0.0:3000', { transports: ['websocket'] })
const socket = io('http://localhost:3000', { transports: ['websocket'] })

const recv = ref()
const message = ref('hello world!')

const sendMessage = () => {
  socket.emit('message', message.value)
}

socket.on('connect', () => {
  console.log('Connected to server')
})

socket.on('message', (message) => {
  console.log('Received message: ' + message)
  recv.value = message
})

socket.emit('message', 'Hello, server!')
</script>
