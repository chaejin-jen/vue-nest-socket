<template>
  <div>
    <button @click="sendMessage">Send Message</button>
    {{ recv }}
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { io } from 'socket.io-client'

const socket = io('http://localhost:82/chat', { transports: ['websocket'] })

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
