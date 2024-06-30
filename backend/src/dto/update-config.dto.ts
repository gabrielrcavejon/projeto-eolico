import { IsNotEmpty } from "class-validator"

export class UpdateConfigDto {
  @IsNotEmpty()
  flagligado: string
}
