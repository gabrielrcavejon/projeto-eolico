import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma/prisma.service";
import { CreateVoltDto } from "./dto/create-volt.dto";
import { UpdateConfigDto } from "./dto/update-config.dto";
import { Volt } from "./models/Volt";

@Injectable()
export class AppRepository {
  constructor(private readonly prisma: PrismaService) { }

  async updateConfig(data: UpdateConfigDto): Promise<any> {
    return this.prisma.config.updateMany({
      data: data
    });
  }

  async create(data: CreateVoltDto) {
    await this.prisma.volts.create({
      data
    });
  }

  async findAll() {
    return this.prisma.volts.findMany();
  }

  async findLast(): Promise<Volt> {
    return {
      volt: parseFloat((await this.prisma.volts.findFirst({
        select: {
          volt: true
        },
        orderBy: {
          idvolt: 'desc',
        },
        take: 1
      })).volt.toString()),
      flagligado: (await this.prisma.config.findFirst()).flagligado
    };
  }
}

