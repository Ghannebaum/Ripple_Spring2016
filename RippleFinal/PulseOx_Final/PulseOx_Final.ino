/******************************************************************************
Author: Stella Benedicta Laksono
Date: 21 February 2014
Revision History :I - Functions approved
                  II- SPI communication available
                  III - Oxygen saturation code
This is sketch to generate Texas Instrument Pulse Oximetry Analogue Front End
AFE4490
and photo transisor-NJL5501r
********************************************************************************/

/////////////////////////////////////////////////////////////////////////////////
//#include <intrinsics.h>
#include <string.h>
#include "AFE4490.h"
#include <SPI.h>
#include <math.h>
//#include "Average.h"
//Inizializiations
#define count 60
//added //////////
double IRhsSum = 0;
double RedhsSum = 0;
double maxRed = 0;
double maxIR = 0;
double minRed = 100000;
double minIR = 100000;
int rowNum = 1;
int PeakArray[count];
//////////////////
int IRheartsignal[count];
int Redheartsignal[count];
int IRdc;
int Reddc;
int IR;
int Red;
double difIRheartsig_dc;
double difREDheartsig_dc;
double powdifIR;
double powdifRed;
double IRac;
double Redac;
double SpOpercentage;
double Ratio;

////testing some stuff////
const int ADC_RDY = 2;
const int CLKOUT = 3;
const int PD_ALM = 5;
const int LED_ALM = 6;
const int DIAG_END = 7;
//////////////////////////
const int SPISTE = 10;
const int SIMO = 11;
const int SOMI = 12;
const int SCLK  = 13;

void AFE4490Init (void);
void AFE4490Write (uint8_t address, uint32_t data);
uint32_t AFE4490Read (uint8_t address);

void setup()
{
  Serial.begin(19200); //Baud rate set to 57600 bits per seconds to match ADS1292R

  SPI.begin();
  pinMode (SOMI, INPUT);
  pinMode (SPISTE, OUTPUT);
  pinMode (SCLK, OUTPUT);
  pinMode (SIMO, OUTPUT);
  ////testing some stuff////
  pinMode (ADC_RDY, INPUT);
  pinMode (CLKOUT, INPUT);
  pinMode (PD_ALM, INPUT);
  pinMode (LED_ALM, INPUT);
  pinMode (DIAG_END, INPUT);
  /////SPI settings/////////////////////
  SPI.setClockDivider (SPI_CLOCK_DIV128);
  SPI.setDataMode (SPI_MODE0); //SOMI cannot sample on MODE 1??
  SPI.setBitOrder (MSBFIRST);

  AFE4490Init();
}
/////////////////////////////////////////////////////////////////////////////////
//in the void loop, AFE4490 config is set, when sensor is plugged in, SOMI == High,
  //if LED sensor data is > 50000 then the pulse ox is not attached to patient and prints all -1, -1 used to keep ADS1292R data comming in even when Pulse-Ox is not connected
  //when sensor is attached to patient 
    //read senoser data from Red and IR 60 times and calculate sum, max and min of Red and IR 
    //save the 60th data to the Red and IR variables for printing at the end
    //calculate AC and DC component of signal 
    //reset sum, max and min variables for the next loop through
    //using AC and DC calculate Ratio of Ratios
    //use Ratio to calculate SpO2 %
    //print IR, Red, SpO2% to serial in one line
//If SOMI != High, print all -1, continue checking until it is connected
//commented out print statments used for different tests
/////////////////////////////////////////////////////////////////////////////////
void loop()
{
  //  for (int i = 0; i < count; i++)
  //  {
  //AFE4490 config is set
  AFE4490Write(TIAGAIN, 0x000000);  // CF = 5pF, RF = 500kR
  AFE4490Write(TIA_AMB_GAIN, 0x000005); // Timers ON, average 3 samples **000000
  AFE4490Write(LEDCNTRL, 0x011414); // Switch to READ mode
  AFE4490Write(CONTROL2, 0x000000); // LED_RANGE=100mA, LED=50mA        ***020100
  AFE4490Write(CONTROL1, 0x010707); // Timers ON, average 3 samples     ***000101
  AFE4490Write(CONTROL0, 0x000001); // Switch to READ mode              ***000000
  //    Serial.println(i);
  //delay (1000);

  if (digitalRead (SOMI) == HIGH) //when sensor is plugged in, SOMI == High
  {
    //inf while loop to consistantly print only the signal being pickd up by the AFE4490
    //will print IR to serial then Red to serial repeating until used stops it runninga
    //For Matlab plot check///////////////////////////////////////////
  //  Serial.println ("SOMI is connected, Reading register will proceed!");
//   while (1)
//   {
//    double IRheartsignal = AFE4490Read(LED1ABSVAL);
//      double Redheartsignal = AFE4490Read(LED2ABSVAL);
//      if (IRheartsignal > 50000) {
//       IRheartsignal = 0;
//    }
//    if (Redheartsignal > 50000) {
//      IRheartsignal = 0;
//   }
//   Serial.println(IRheartsignal);
//   Serial.println(Redheartsignal);
//        Serial.println();
//        delay(500);
//  }
    ///////////////////////////////////////////////////////////////////////////
    //if LED sensor data is > 50000 then the pulse ox is not attached to patient and prints all -1
    if ((AFE4490Read(LED2ABSVAL) > 50000) || (AFE4490Read(LED1ABSVAL) > 50000))
    {//original print statements for when used without ADS1292R
      //Serial.println ("-----------------------------------------------------"); 
      //Serial.println ("------------The Pulse-Oximeter is not attached!------");
      //Serial.println ("-----------------------------------------------------");
      //If the pulse-ox is not on the patient, data output is -1 
      // simplified print statement for easy import into MATLAB with ADS1292R data
      Serial.print(-1);Serial.print(", "); Serial.print(-1);Serial.print(", "); Serial.print(-1); Serial.print(' '); Serial.print('\n');
      rowNum = rowNum + 1;
    }
    //when sensor is attached to patient 
    else
    {
      //read senoser data from Red and IR 60 times and calculate sum, max and min of Red and IR
      for (int j = 0; j < count; j++)
      {
        IRheartsignal[j] = AFE4490Read(LED1ABSVAL);
        Redheartsignal[j] = AFE4490Read(LED2ABSVAL);
        IRhsSum = IRhsSum + IRheartsignal[j];
        RedhsSum = RedhsSum + Redheartsignal[j];
        if ((maxIR < IRheartsignal[j]) || (maxRed < Redheartsignal[j]))
        {
          maxIR = IRheartsignal[j];
          maxRed = Redheartsignal[j];
        }

        else if ((minIR > IRheartsignal[j]) || (minRed > Redheartsignal[j]))
        {
          minIR = IRheartsignal[j];
          minRed = Redheartsignal[j];
        }
        //save the 60th data to the Red and IR variables for printing at the end
        IR = IRheartsignal[j];
        Red = Redheartsignal[j];
        Serial.print(IR);Serial.print(", "); Serial.print(Red);Serial.print(", "); Serial.print(-1);Serial.print(' '); Serial.print('\n');
        rowNum = rowNum + 1;
      }
              //original print statements for when used without ADS1292R
              //prints the max and min IR and Red signals as a means for comparison
              // Serial.print(maxIR); Serial.print("<--Max|IR |Min-->"); Serial.println(minIR);
              // Serial.print(maxRed); Serial.print("<--Max|Red|Min-->"); Serial.println(minRed);
    //calculate AC and DC component of signal
      //DC data computation////////////////////////////////////////////////////
      IRdc = IRhsSum / count;
      Reddc = RedhsSum / count;
              //original print statements for when used without ADS1292R
              // Serial.print(IRdc); Serial.print("<--DCIR|DCRed-->"); Serial.println(Reddc);

      //AC data computation///////////////////////////////////////////////////
      IRac = maxIR - minIR;
      Redac = maxRed - minRed;
              //original print statements for when used without ADS1292R
              // Serial.print(IRac); Serial.print("<--ACIR|ACRed-->"); Serial.println(Redac);

      //reset the max, min, and sum variables for next calculation
      IRhsSum = 0; RedhsSum = 0; maxIR = 0; minIR = 100000; maxRed = 0; minRed = 100000;
      //using AC and DC calculate Ratio of Ratios
      Ratio = abs((Redac / Reddc) / (IRac / IRdc));
            //original print statements for when used without ADS1292R
            // Serial.println(Ratio);
      //use Ratio to calculate SpO2 %
      double ARat = 25 * Ratio;

      SpOpercentage = 100 - (Ratio);
      //print IR, Red, SpO2% to serial in one line
      //When SpO2 percetage invalid print SpO2 = -1
      if ((SpOpercentage > 100) || (SpOpercentage < 0))
      {
       //original print statements for when used without ADS1292R
       // Serial.print(""); Serial.print("IR:"); Serial.print(IRac); Serial.println("");
       // Serial.print(""); Serial.print("Red:"); Serial.print(Redac); Serial.println("");

       // simplified print statement for easy import into MATLAB with ADS1292R data
        Serial.print(IR);Serial.print(", "); Serial.print(Red);Serial.print(", "); Serial.print(-1);Serial.print(' '); Serial.print('\n');
        rowNum = rowNum + 1;
      }
      else
      {
       //original print statements for when used without ADS1292R
       // Serial.print(""); Serial.print("IR:"); Serial.print(IRheartsignal[count]); Serial.println("");
       // Serial.print(""); Serial.print("Red:"); Serial.print(Redheartsignal[count]); Serial.println("");

       // simplified print statement for easy import into MATLAB with ADS1292R data
       Serial.print(IR);Serial.print(", "); Serial.print(Red);Serial.print(", "); Serial.print(SpOpercentage);Serial.print(' '); Serial.print('\n');
       rowNum = rowNum + 1;
      }
    }
    AFE4490Write(CONTROL0, 0x000000); // disable READ mode
  }
  //If SOMI != High, print all -1, continue checking until it is connected
  else
  {
   // Serial.println ("------------------------------------------------------");
   // Serial.println ("----------SOMI is not connected, check the wire!------");
   // Serial.println ("------------------------------------------------------");
  // simplified print statement for easy import into MATLAB with ADS1292R data
     // Serial.print(rowNum);Serial.print(", ");Serial.print(-2);Serial.print(", "); Serial.print(-2);Serial.print(", "); Serial.print(-2); Serial.print('\n');
  }
  
}
/////////////////////////////////////////////////////////////////////////////////
//Initialization for AFE4490, prints start stament and Done stament
//Done stament used by ADSandAFEArduinoSerial.py to check to see where data starts
//Specific variable explanation and different bit options for each is in the data sheet for AFE4490R starting on page 59
void AFE4490Init (void)
{

  Serial.println("AFE4490 Initialization Starts");
  AFE4490Write(CONTROL1, 0x000101);
  AFE4490Write(CONTROL2, 0x000000);
  AFE4490Write(PRPCOUNT, 0X001F3F);

  AFE4490Write(LED2STC, 0X0017C0); //timer control   ***0017C0
  AFE4490Write(LED2ENDC, 0X001F3E); //timer control
  AFE4490Write(LED2LEDSTC, 0X001770); //timer control
  AFE4490Write(LED2LEDENDC, 0X001F3F); //timer control
  AFE4490Write(ALED2STC, 0X000050); //timer control  ***000050
  AFE4490Write(ALED2ENDC, 0X0007CE); //timer control
  AFE4490Write(LED2CONVST, 0X000006); //timer control***000006
  AFE4490Write(LED2CONVEND, 0X0007CF); //timer control
  AFE4490Write(ALED2CONVST, 0X0007D6); //timer control**0007D6
  AFE4490Write(ALED2CONVEND, 0X000F9F); //timer control

  AFE4490Write(LED1STC, 0X000820); //timer control   ***000820
  AFE4490Write(LED1ENDC, 0X000F9E); //timer control
  AFE4490Write(LED1LEDSTC, 0X0007D0); //timer control
  AFE4490Write(LED1LEDENDC, 0X000F9F); //timer control
  AFE4490Write(ALED1STC, 0X000FF0); //timer control   ***000FF0
  AFE4490Write(ALED1ENDC, 0X00176E); //timer control
  AFE4490Write(LED1CONVST, 0X000FA6); //timer control ***000FA6
  AFE4490Write(LED1CONVEND, 0X00176F); //timer control
  AFE4490Write(ALED1CONVST, 0X001776); //timer control***001776
  AFE4490Write(ALED1CONVEND, 0X001F3F); //timer control

  AFE4490Write(ADCRSTCNT0, 0X000000); //timer control
  AFE4490Write(ADCRSTENDCT0, 0X000005); //timer control***000005
  AFE4490Write(ADCRSTCNT1, 0X0007D0); //timer control
  AFE4490Write(ADCRSTENDCT1, 0X0007D5); //timer control***0007D5
  AFE4490Write(ADCRSTCNT2, 0X000FA0); //timer control
  AFE4490Write(ADCRSTENDCT2, 0X000FA5); //timer control***000FA5
  AFE4490Write(ADCRSTCNT3, 0X001770); //timer control
  AFE4490Write(ADCRSTENDCT3, 0X001775); //timer control***001775

  delay(1000);
  // python code ADSandAFEArduinoSerial.py checks for this to say Done before running full script
 Serial.println("Done");
}
//functions used by above code to read and write to AFE4490
/////////////////////////////////////////////////////////////////////////////////
void AFE4490Write (uint8_t address, uint32_t data)
{
  digitalWrite (SPISTE, LOW); // enable device
  SPI.transfer (address); // send address to device
  SPI.transfer ((data >> 16) & 0xFF); // write top 8 bits
  SPI.transfer ((data >> 8) & 0xFF); // write middle 8 bits
  SPI.transfer (data & 0xFF); // write bottom 8 bits
  digitalWrite (SPISTE, HIGH); // disable device
}
/////////////////////////////////////////////////////////////////////////////////
uint32_t AFE4490Read (uint8_t address)
{
  uint32_t data = 0;
  digitalWrite (SPISTE, LOW); // enable device
  SPI.transfer (address); // send address to device
  //SPI.transfer (data);
  data |= (SPI.transfer (0) << 16); // read top 8 bits data
  data |= (SPI.transfer (0) << 8); // read middle 8 bits  data
  data |= SPI.transfer (0); // read bottom 8 bits data
  digitalWrite (SPISTE, HIGH); // disable device
  return data; // return with 24 bits of read data
}
/////////////////////////////////////////////////////////////////////////////////
