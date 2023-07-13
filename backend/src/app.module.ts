import { Module } from '@nestjs/common';
import { EventsModule } from './events/events.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SocketModule } from './socket/socket.module';
import { ChatModule } from './chat/chat.module';

@Module({
  imports: [EventsModule, SocketModule, ChatModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
