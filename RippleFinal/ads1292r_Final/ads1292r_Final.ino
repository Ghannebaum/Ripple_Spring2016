
#include <ads1292r.h>
#include <SPI.h>


ads1292r ADS1292;
//Packet format
#define	CES_CMDIF_PKT_START_1		0x0A
#define	CES_CMDIF_PKT_START_2		0xFA
#define	CES_CMDIF_TYPE_DATA		0x02
#define	CES_CMDIF_PKT_STOP		0x0B

volatile char DataPacketHeader[5];
volatile char DataPacketFooter[2];
volatile int datalen = 135;

volatile char SPI_RX_Buff[150];
volatile static int SPI_RX_Buff_Count = 0;
volatile char *SPI_RX_Buff_Ptr;
volatile int Responsebyte = false;

void setup() 
{
  // initalize the  data ready and chip select pins:
  pinMode(ADS1292_DRDY_PIN, INPUT);
  pinMode(ADS1292_CS_PIN, OUTPUT);
  pinMode(ADS1292_START_PIN, OUTPUT);
  pinMode(ADS1292_PWDN_PIN, OUTPUT);
  
  //initalize ADS1292 slave
  ADS1292.ads1292_Init();
  
  DataPacketHeader[0] = CES_CMDIF_PKT_START_1;
  DataPacketHeader[1] = CES_CMDIF_PKT_START_2;
  DataPacketHeader[2] = (datalen);
  DataPacketHeader[3] = (datalen >> 8);
  DataPacketHeader[4] = CES_CMDIF_TYPE_DATA;
  
  DataPacketFooter[0] = 0x00;
  DataPacketFooter[1] = CES_CMDIF_PKT_STOP;
}

void loop() 
{
  volatile int i;
  
  if((digitalRead(ADS1292_DRDY_PIN)) == LOW)
  {  
    SPI_RX_Buff_Ptr = ADS1292.ads1292_Read_Data();
    Responsebyte = true;
  }

  if(Responsebyte == true)
  {
     for(i = 0; i < 9; i++)
     {
       SPI_RX_Buff[SPI_RX_Buff_Count++] = *(SPI_RX_Buff_Ptr + i);
     }
     Responsebyte = false;
  }
  
  if(SPI_RX_Buff_Count > 135)
  {   
     /*
     for(i = 0; i < 5; i++)
     {
       Serial.print(DataPacketHeader[i]);
     }
     */
    // char dataString[280];
     for(i = 0; i < 135; i++)
     {
       //sprintf(dataString + (i*2), "%02X", SPI_RX_Buff[i]);
       Serial.print(SPI_RX_Buff[i]);
     }
     
    // Serial.println(dataString);
     /*
     for(i = 0; i < 2; i++)
     {
       Serial.print(DataPacketFooter[i]);
     }
     */
     SPI_RX_Buff_Count = 0; 
  }
}
