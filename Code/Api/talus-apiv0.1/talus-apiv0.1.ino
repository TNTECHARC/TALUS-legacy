/*
 Name:		talus_apiv0.ino
 Created:	2/11/2020 3:09:44 PM
 Author:	Payton DePietro
*/
#include <Servo.h>
// the setup function runs once when you press reset or power the board

//setting
//max ammount of arguments
const int ARGSNUM = 4;
//creates argument storage location
String argArray[ARGSNUM + 1];

//temp variables
String tempString;
int servonum;
//function list
String functionList[] = {"enableAll","disableAll","enablePin","disablePin","setServo","handOpen","handClose","wingsUp","wave","default" };
//servo object
Servo servos[8];

void setup() {
	//serial set up and timeout adjustment for quicker response
	Serial.begin(9600);
	Serial.setTimeout(20);

	//setup all pins as outputs
	//with i and j there are two "for" loops running together
	int j = 0;
	for (int i = 22; i < 37;i++) {
		//prints some debug information
		Serial.println("Servo Pin: " + (String)i + " Enable Pin: " + (String)(i+1) + " RefPin: " + (String)j);
		//starts at the jth servo and links/attaches it with the ith pin , then sets it to 90 degrees
		servos[j].attach(i);
		servos[j].write(90);
		//increase j and i (i need to be incremented becuse the mosfet pin and servo pin arent the same) 
		j++;
		i++;
		//sets up the mosfet as output and enables it
		pinMode(i, OUTPUT);
		digitalWrite(i, HIGH);
	}
	//servo 5 and 7 have different default locations compared to all the other servos
	servos[5].write(150);
	servos[7].write(0);
	Serial.println("end of setup!");
}


// main loop
void loop() {
	//checks if there is new data available on the serial line
	if (Serial.available()) {
		//if serial is available it then sends the string to the command parser
		commandParser(Serial.readString());
		//lists the current command and any args that go along with it
		for (int i = 0; i < ARGSNUM; i++) {
			Serial.println(argArray[i]);
		}
	}

	//stores the command number or 60 if the command is not valid
	int tempint = 60;
	//takes the most current command and compares it to the function list array to see if there are any matches
	for (int i = 0; i < (sizeof(functionList) / sizeof(*functionList)); i++) {
		if (argArray[0] == functionList[i]) {
			tempint = i;
			//exit;
		}
	}
	// takes the command number from the above search and sends it to the approiate code
	switch (tempint) {
	case 0:
		//this is the enableAll command
		for (int i = 23; i < 38; i++) {
			servonum = (i - 22) / 2;
			digitalWrite(i, HIGH);
			i++;
		}
		break;
	case 1:
		//this is the disableAll command
		for (int i = 23; i < 38; i++) {
			servonum = (i - 22) / 2;
			digitalWrite(i, LOW);
			i++;
		}
		break;
	case 2:
		//this is the enablePin command
		digitalWrite(argArray[1].toInt(), HIGH);
		break;
	case 3:
		//this is the  disabelPin command
		digitalWrite(argArray[1].toInt(), LOW);
		break;
	case 4:
		//this is the setServo command
		servonum = argArray[1].toInt();
		servos[servonum].write(argArray[2].toInt());
		break;
	case 5:
		//this is the handOpen command
		for (int i = 0; i < 5; i++) {
			servos[i].write(80);
		}
		break;
	case 6:
		//this is the handClose command
		for (int i = 0; i < 5; i++) {
			servos[i].write(0);
		}
		break;
	case 7 :
		//this is the wingsUp command
		servos[5].write(150);
		servos[0].write(90);
		servos[1].write(0);
		servos[2].write(0);
		servos[3].write(0);
		servos[4].write(90);
		break;
	case 8 :
		//this is the wave command
		servos[6].write(180);
		delay(500);
		for (int i = 0; i < 2; i++) {
			servos[5].write(160);
			delay(1000);
			servos[5].write(90);
			delay(1000);
		}
		servos[5].write(160);
		break;
	case 9 :
		//this is the default command
		servos[0].write(45);
		servos[1].write(45);
		servos[2].write(45);
		servos[3].write(45);
		servos[4].write(45);
		servos[5].write(150);
		servos[6].write(90);
		servos[7].write(0);
		break;
	default:
		break;
	}
	//this makes the current command something not in the command list so when the loop restarts and there is no serial input it doesent keep running the same command
	argArray[0] = "billybobjoe";
}

String * commandParser(String tempString){
	//variables for later use
	int j = 0;
	int beginArgs = 0;
	int endArgs = 0;
	//temp array to store the seperation potins between args
	int args[ARGSNUM + 1];
	// sets the start point of the args (has to be negative 1 for the math to work out later)
	args[j] = -1;
	j++;
	//loops throught all characters in the string being parsed, and looks for specific characters
	for (int i = 0; i < tempString.length(); i++) {
		//if the character is "(" this signafies the beging of the arguments and the end of the command
		if (tempString[i] == '(') {
			beginArgs = i;
			args[j] = i;
			j++;
		}
		//if the character is ")" this signafies the end of the arguments
		else if (tempString[i] == ')') {
			endArgs = i;
			args[j] = i;
			j++;
		}
		//searches for commas and saves there location in the args array
		else if (tempString[i] == ',') {
			if (j < ARGSNUM + 1) {
				args[j] = i;
				j++;
			}
		}
	}
	//goes throught all the save comma bracket and comma location and saves the string that is inbetween them for use in the code
	for (int i = 0; i < j; i++) {
		argArray[i] = tempString.substring(args[i] + 1, args[i + 1]);
	}
	return argArray;
}
