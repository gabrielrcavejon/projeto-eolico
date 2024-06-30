import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AppRepository } from './app.repository';
import { PrismaService } from 'prisma/prisma.service';

@Module({
  controllers: [AppController],
  providers: [AppService, AppRepository, PrismaService],
})
export class AppModule { }
