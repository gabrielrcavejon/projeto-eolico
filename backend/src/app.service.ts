import { Injectable } from '@nestjs/common';
import { SerialPort } from 'serialport'
import { AppRepository } from './app.repository';

@Injectable()
export class AppService {
  private port: SerialPort
  constructor(private readonly appRepository: AppRepository) {
    this.port = new SerialPort({
      path: "COM6",
      baudRate: 9600
    });
  }

  async onModuleInit() {
    this.port.on("data", data => {
      if (data.toString() === "T" || data.toString() === "F") {
        this.appRepository.updateConfig({
          flagligado: data.toString()
        });
        return;
      }

      this.appRepository.create({
        volt: data.toString()
      })
    })
  }

  findAll() {
    return this.appRepository.findAll();
  }

  findLast() {
    return this.appRepository.findLast();
  }
}
