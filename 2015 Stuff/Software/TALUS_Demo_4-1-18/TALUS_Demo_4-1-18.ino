#include <Servo.h>

int ON = 37, test = 36, FA = 33, FB = 31, FC = 32; //OFF connnected to reset
int ON_LED = 22, OFF_LED = 23, test_LED = 24, FA_LED = 25, FB_LED = 26, FC_LED = 27;

Servo Waist;
Servo leftShoPiston, rightShoPiston;
Servo leftShoPitch, rightShoPitch;
Servo leftShoYaw, rightShoYaw;
Servo leftBicep, rightBicep;

void Stop();
void HomePosition();
void TestRange();
void ShakeRight(int, int, int, int);
void(* resetFunc) (void) = 0;

void setup() {
  //Button pins set as inputs
  pinMode(ON,INPUT);pinMode(test,INPUT); pinMode(FA,INPUT); pinMode(FB,INPUT); pinMode(FC,INPUT);
  PORTC |= 0xFF; //Enable pull up resistors on pins 30 - 37

  //Indicator LEDs set as outputs
  pinMode(ON_LED,OUTPUT); pinMode(OFF_LED,OUTPUT); pinMode(test_LED,OUTPUT);
  pinMode(FA_LED,OUTPUT); pinMode(FB_LED,OUTPUT); pinMode(FC_LED,OUTPUT);

  //Wait until start button is pressed
  digitalWrite(ON_LED,LOW); digitalWrite(OFF_LED,HIGH); digitalWrite(test_LED,LOW);
  digitalWrite(FA_LED,LOW); digitalWrite(FB_LED,LOW); digitalWrite(FC_LED,LOW);
  while(digitalRead(ON));
  while(!digitalRead(ON)) delay(5); //(delay for debouncing)
  digitalWrite(OFF_LED,LOW); digitalWrite(ON_LED,HIGH);
  
  //Attach servo pins and go to resting position
  Waist.attach(6);
  leftShoPiston.attach(5); rightShoPiston.attach(7);
  leftShoPitch.attach(4); rightShoPitch.attach(8);
  leftShoYaw.attach(3); rightShoYaw.attach(9);
  leftBicep.attach(2); rightBicep.attach(10);
  HomePosition();
}

void loop() {
  if(!digitalRead(test)){
    while(!digitalRead(test)) delay(5);  //(delay for debouncing)
    digitalWrite(test_LED,HIGH);delay(250);
    TestRange(); //Run through test of all joints
    digitalWrite(test_LED,LOW);
    
  } else if(!digitalRead(FA)){
    while(!digitalRead(FA)) delay(5);  //(delay for debouncing)
    digitalWrite(FA_LED,HIGH);delay(250);
    ShakeRight1(90,40,1000,4); //Shake at 90 degrees, over ~30 degrees, 1.5 s/shake, 4 shakes
    HomePosition();
    digitalWrite(FA_LED,LOW);
    
  } else if(!digitalRead(FB)){
    while(!digitalRead(FB)) delay(5);  //(delay for debouncing)
    digitalWrite(FB_LED,HIGH);delay(250);
    ////
    digitalWrite(FC_LED,LOW);
    
  } else if(!digitalRead(FC)){
    while(!digitalRead(FC)) delay(5);  //(delay for debouncing)
    digitalWrite(FC_LED,HIGH);delay(250);
    ShakeRight2(90,40,1000,4); //Shake at 90 degrees, over ~30 degrees, 1.5 s/shake, 4 shakes
    HomePosition();
    digitalWrite(FC_LED,LOW);
  }
}

void HomePosition() {
  Waist.write(90);
  leftShoPiston.write(0);  rightShoPiston.write(0);
  leftShoPitch.write(30);  rightShoPitch.write(30);
  leftShoYaw.write(90);    rightShoYaw.write(70);
  leftBicep.write(80);     rightBicep.write(80);
}

void TestRange() {
  Waist.write(180); delay(600);
  Waist.write(0); delay(1200);
  Waist.write(90); delay(600);
  
  leftShoPiston.write(180); rightShoPiston.write(180); delay(1000);
  leftShoPiston.write(0); rightShoPiston.write(0); delay(1000);
  
  leftShoPitch.write(180); rightShoPitch.write(180); delay(10000);
  leftBicep.write(0); rightBicep.write(0); delay(2000);
  leftBicep.write(80); rightBicep.write(80); delay(2000);
  leftShoPitch.write(90); rightShoPitch.write(90); delay(6000);
  
  leftShoYaw.write(20); rightShoYaw.write(120); delay(4000);
  leftShoYaw.write(140); rightShoYaw.write(0); delay(8000);
  
  HomePosition();
}

void ShakeRight1(int angle, int shake, int spd, int num) {
  angle = angle + 20; //Adjust for servo position
  angle = angle - 15; //Adjust for angle added by bicep
  int bicepCenter = 20;
  
  rightShoPitch.write(angle);delay(2000); //Move to position
  rightBicep.write(bicepCenter);delay(4000);
  
  for(int i=0; i<num; i++) {
    rightShoPitch.write(angle + shake/3);delay(spd/6);
    rightBicep.write(bicepCenter + shake/2);delay(spd/3);
    rightShoPitch.write(angle - shake/3);delay(spd/6);
    rightBicep.write(bicepCenter - shake/2); delay(spd/3);
  }
  delay(500); //Let go delay
}

void ShakeRight2(int angle, int shake, int spd, int num) {
  angle = angle + 20; //Adjust for servo position
  angle = angle - 15; //Adjust for angle added by bicep
  int bicepCenter = 20;
  
  rightShoPitch.write(angle);delay(2000); //Move to position
  rightBicep.write(bicepCenter);delay(4000);
  
  for(int i=0; i<num; i++) {
    rightShoPitch.write(angle - shake/3);rightBicep.write(bicepCenter + shake/2);delay(spd/2);
    rightShoPitch.write(angle + shake/3);rightBicep.write(bicepCenter - shake/2); delay(spd/2);
  }
  delay(500); //Let go delay
  
  rightShoPitch.write(20);rightBicep.write(80);delay(5000); //Return
}
