import {
  MessageBody,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
  ConnectedSocket,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway(3000, { transports: ['websocket'] })
export class SocketGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  handleConnection(@ConnectedSocket() client: Socket) {
    console.log('Client connected: ' + client.id);
    client.send('Connection successed');
  }

  handleDisconnect(@ConnectedSocket() client: Socket) {
    console.log('Client disconnected: ' + client.id);
  }

  @SubscribeMessage('message')
  handleMessage(
    @ConnectedSocket() client: Socket,
    @MessageBody() body: any,
  ): void {
    this.server.emit('message', body); // Broadcast the received message to all connected clients
    console.log('[', client.id, '] ', body);
  }
}
