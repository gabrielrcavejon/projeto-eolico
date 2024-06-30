import { Decimal } from "@prisma/client/runtime/library"
import { IsDecimal, IsNotEmpty } from "class-validator"

export class CreateVoltDto {
  @IsNotEmpty()
  @IsDecimal()
  volt: Decimal
}
