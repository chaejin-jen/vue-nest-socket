import { Module } from '@nestjs/common';
import { EventsModule } from './events/events.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SocketModule } from './socket/socket.module';
import { ChatModule } from './chat/chat.module';
import { GameModule } from './game/game.module';

@Module({
  imports: [EventsModule, SocketModule, ChatModule, GameModule],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
