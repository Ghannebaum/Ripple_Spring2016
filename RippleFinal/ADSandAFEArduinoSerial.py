'''

Code to read ADS1292 data passed from the Arduino
Tested using Linux Mint 13 with Python 2.7 and pyserial from ubuntu repository

'''
# http://pyserial.sourceforge.net/
import serial
# open serial to Arduinos
# Changed '/dev/ttyACM0' to 'COM#' for windows use (SGH)
# Changed also outputs data to text file called ECGandRespData.txt (SGH)
# added all code coorisponding to PPG and AFE4490 (SGH)
# COM# must coorispond with Arduino COM#
ser = serial.Serial('COM3', 57600, timeout=30)
serPPG = serial.Serial('COM4', 19200, timeout=300000)
# open file with w permision to delete old data in the file at each start
#need to create formated initialization txt file and pull this from there
f = open('C:\Users\Skyler\OneDrive\Ripple\ECG_Resp_PPG.txt', 'w')
f.write('Data Point' + ', ' + 'Resp' + ', ' +  'ECG' + ', '+ 'IR' + ', ' +  'Red' + ', ' + 'SpO2'+'\n') 
f.close
count = 1
StartofFile = serPPG.read(4)
serPPG.readline()
while True:
	if(StartofFile == "Done"):
		# read data for PPG
		# determination of which data is IR,Red,and Sp02 is done in MATLAB
		PPGData = serPPG.readline()
		
		# read data for ECG/Resp
		# wait for new packet	
		# TODO: Start of status bytes may not always be 0xC0 (see ADS data sheet pg 28)
		statusBytes = ser.read()
		while(ord(statusBytes) != 0xC0):
			statusBytes = ser.read()
		# dummy reads of 2 other status bytes
		statusBytes = ser.read()
		statusBytes = ser.read()
		# read 3 bytes for channel 1
		ch1Bytes = ser.read(3)
		# read 3 bytes for channel 2
		ch2Bytes = ser.read(3)
		# 2's complement conversion for negative values
		if(ord(ch2Bytes[0]) & 0x80):
			ch2Byte1 = ~ord(ch2Bytes[0])
			ch2Byte2 = ~ord(ch2Bytes[1])
			ch2Byte3 = ~ord(ch2Bytes[2])
			ch2 = (ch2Byte1 << 16) | (ch2Byte2 << 8) | (ch2Byte3)
			ch2 += 1
		else:
			ch2 = (ord(ch2Bytes[0]) << 16) + (ord(ch2Bytes[1]) << 8) + (ord(ch2Bytes[2]))
		# TODO: apply 2's complement for channel 1 as well
		ch1 = (ord(ch1Bytes[0]) << 16) + (ord(ch1Bytes[1]) << 8) + (ord(ch1Bytes[2]))
		# print channel values and PPG values in comma-delimited form
		print  count, ",", ch1, ", ", ch2, ", ", PPGData
		# write ECG/Resp data values and PPG values to txt file, appending at end of file
		f= open('C:\Users\Skyler\OneDrive\Ripple\ECG_Resp_PPG.txt', 'a')
		f.write(str(count) + ', ' + str(ch1) + ', ' +  str(ch2) + ', '+ PPGData) 
		count = count+1
	else:
		print 'Initializing...', StartofFile
		StartofFile = serPPG.read(4)
		serPPG.readline()
# close serial port
ser.close()
serPPG.close()