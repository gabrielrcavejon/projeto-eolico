//CONFIGURAÇÕES GLOBAIS
bool flagligado = true;

//CONFIGURAÇÕES LEITOR RFID
#include <MFRC522.h>
#include <SPI.h>
#define RST 9
#define SDA 10
MFRC522 rfid(SDA, RST);

//CONFIGURAÇÕES BUZZER
#define BUZZER 7

//CONFIGURAÇÕES RELÉ
#define RELE 6

void setup() 
{
  pinMode(BUZZER, OUTPUT);
  pinMode(RELE, OUTPUT);
  Serial.begin(9600);
  SPI.begin();
  rfid.PCD_Init();
}

void loop() 
{
  verificaStatusSistemaRFID();

  serialCommunication();

  if(flagligado){
    SerialSendTensao();
  }

  delay(1500);
}

void verificaStatusSistemaRFID(){
  if(rfid.PICC_IsNewCardPresent()){
    if (rfid.PICC_ReadCardSerial()) {
      String UID = "";
      for(byte i = 0; i < rfid.uid.size; i++){
        UID.concat(String(rfid.uid.uidByte[i] < 0x10 ? " 0" : " "));
        UID.concat(String(rfid.uid.uidByte[i], HEX));
      }

      UID.toUpperCase();
      UID = UID.substring(1);
      
      if(UID == "93 1A 2B AD" || UID == "4C AB D2 CF"){
        if(flagligado){
          serialSendByte('F');
          flagligado = false;
          digitalWrite(RELE, HIGH);
        }
        else{
          serialSendByte('T');
          flagligado = true;
          digitalWrite(RELE, LOW);
        }

        digitalWrite(BUZZER, HIGH);
        delay(500);
        digitalWrite(BUZZER, LOW);
        delay(500);
      }
    }
  }
}

void serialCommunication(){
  if(Serial.available()){
    switch(Serial.read()){
      case 'T': { 
        flagligado = true;
        digitalWrite(RELE, LOW);
        ligarBuzzer();        
        break;
      }

      case 'F': {
        flagligado = false;
        digitalWrite(RELE, HIGH);
        ligarBuzzer();
        break;
      } 
    }
  }
}

void serialSendByte(char texto){
  Serial.write(texto);
}

void SerialSendTensao(){
  Serial.print(analogRead(0) * 5.0 / 1023.0);
}

void ligarBuzzer(){
  digitalWrite(BUZZER, HIGH);
  delay(500);
  digitalWrite(BUZZER, LOW);
}
