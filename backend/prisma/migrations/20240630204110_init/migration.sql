-- CreateTable
CREATE TABLE "volts" (
    "idvolt" SERIAL NOT NULL,
    "volt" DECIMAL(65,30) NOT NULL,

    CONSTRAINT "volts_pkey" PRIMARY KEY ("idvolt")
);

-- CreateTable
CREATE TABLE "config" (
    "flagligado" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "config_flagligado_key" ON "config"("flagligado");
