/*
 Version:  0.01
 Name:		talus2.ino
 Created:	11/19/2019 8:08:06 PM
 Author:	payton
 Instructions: plug the servo into pin 22 and the mosfet gate line into 23
 servo 2 into pin 23 and mosfet 2 into pin 24 repeat until all servos are attached
 then run this code and all servos will go from 0 to 90 every 2 secons
*/
#include <Servo.h>
// the setup function runs once when you press reset or power the board
Servo servo[8];
String num = "0";
void setup() {
	Serial.begin(9600);
	int temp = 0;
	for (int i = 22; i < 40;i++) {
		pinMode(i, OUTPUT);
		digitalWrite(i, HIGH);
		i++;
		servo[temp].attach(i);
		temp++;
	}
}

// the loop function runs over and over again until power down or reset
void loop() {

	//code for bouncing back and forth between 0 and 180
	for (int i = 0; i < 8;i++) {
		servo[i].write(0);
	}
	delay(2000);
	for (int i = 0; i < 8; i++) {
		servo[i].write(90);
	}
	delay(2000);
	

	//code for serial input of servo position *** WIP ***
	/*if (Serial.available()) {
		num = Serial.readStringUntil('/n');
	}
	Serial.println(num);
	for (int i = 0; i < 8; i++) {
		servo[i].write(num.toInt());
	}*/

}
