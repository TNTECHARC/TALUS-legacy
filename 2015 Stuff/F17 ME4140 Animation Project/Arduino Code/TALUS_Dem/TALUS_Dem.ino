
#include <Servo.h> //Includes the servo library

int jointPin = 2;
int wavePin = 3;
int led = 4;

Servo Hip; Servo ShldrPiv; Servo ShldrRot; Servo ShldrSpn;
int hpin = 6; int ppin = 9; int rpin = 10; int spin = 11;
int hPos[6] = {0,1.5,180,1.5,90,1.5}; //0: left, 180: right
int pPos[4] = {180,1.5,0,1.5}; //0: down, 180: up
int rPos[4] = {110,6,20,6}; //0: back, 110: ahead, 20: straight down
int sPos[4] = {135,5.5,45,5.5};

void DemoJointMotions();
void ZeroPos();
void Wave();


void setup() {
  pinMode(jointPin,INPUT);
  pinMode(wavePin,INPUT);
  pinMode(led,OUTPUT);
  digitalWrite(led,HIGH);
  
  Hip.attach(hpin);
  ShldrPiv.attach(ppin);
  ShldrRot.attach(rpin);
  ShldrSpn.attach(spin);
  
  ZeroPos();
  delay(5000);
}

void loop() {
 if(!digitalRead(jointPin)) {
  DemoJointMotions();
 }
 else if(!digitalRead(wavePin)) {
  Wave();
 }
 delay(2000);
}

void ZeroPos() {
  Hip.write(hPos[4]);
  ShldrPiv.write(pPos[2]);
  ShldrRot.write(rPos[2]);
  ShldrSpn.write(sPos[2]);
}

void DemoJointMotions() {
  Hip.write(hPos[0]);delay(1000*hPos[1]);
  Hip.write(hPos[2]);delay(1000*hPos[3]);
  Hip.write(hPos[4]);delay(1000*hPos[5]);
  
  ShldrPiv.write(pPos[0]);delay(1000*pPos[1]);
  ShldrPiv.write(pPos[2]);delay(1000*pPos[3]);
  
  ShldrRot.write(rPos[0]);delay(1000*rPos[1]);
  ShldrSpn.write(sPos[0]);delay(1000*sPos[1]);
  ShldrSpn.write(sPos[2]);delay(1000*sPos[3]);
  ShldrRot.write(rPos[2]);delay(1000*rPos[3]);
}

void Wave() {
  Hip.write(0);ShldrPiv.write(0);ShldrRot.write(180);ShldrSpn.write(45);delay(12000);
  ShldrPiv.write(180);delay(1500);
  ShldrPiv.write(0);delay(1500);
  ShldrPiv.write(180);delay(1500);
  ShldrPiv.write(0);delay(1500);
  ShldrPiv.write(180);delay(1500);
  ShldrPiv.write(0);delay(1500);
  Hip.write(90);ShldrRot.write(20);delay(10000);
}

