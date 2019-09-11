# Talus
Documentation and code for the ARC Talus team's Makerspace AI greeter.

[Documentation Prior to Fall 2019 Semester](https://github.com/TNTECHARC/Talus/tree/master/Before%20Fall%202019 "Old Documentation")

[Arc Meeting Record](./Arc%20Meeting.txt)

## Have a Suggestion
Tell us what you think Talus should do!
[Form](https://docs.google.com/forms/d/e/1FAIpQLSeFa8XaVLIra4dBYN972fmorVdxVl_9EeBlFkYPPKFkGGHmSQ/viewform?usp=sf_link)

---

## Goals for Fall 2019
| Goal            									| Status  |
| :-------------: 									| :-----: |
| [Alexa Setup](#alexa-setup)    					| Started |
| [Alexa Custom Wake](#alexa-custom-wake)			| Planned |
| [Alexa Custom Commands](#alexa-custom-commands)	| Planned |
| [Raspberry Pi Wiring](#raspberry-pi-wiring)		| Started |
| [Alexa Moving Motors](#alexa-moving-motors)		| Planned |
| [RGB Eyes](#rgb-eyes)								| Planned |
| [Alexa Eyes](#alexa-eyes) 						| Planned |

### Alexa Setup
Setting Up a Raspberry Pi 3B+ or 4 to run Amazon's [Alexa](https://developer.amazon.com/alexa).
This will be made to use the microphone on the [Xbox 360's Kinect sensor](https://developer.microsoft.com/en-us/windows/kinect).

### Alexa Custom Wake
This addition should allow us to cause the wake command for Alexa to be changed.
The plan is to change it from "Alexa" to say "Talus".
This could be easy or difficult based on the Raspberry Pi's Alexa configuration.

### Alexa Custom Commands
We plan on adding many commands to Talus. With this addition we plan on setting up a large list of commands or questions for Talus to address.
The list will be added here and finalized when we get to the stage of adding them.
###### Note:
You can tell us your idea for Talus to do [here](https://docs.google.com/forms/d/e/1FAIpQLSeFa8XaVLIra4dBYN972fmorVdxVl_9EeBlFkYPPKFkGGHmSQ/viewform?usp=sf_link).

### Raspberry Pi Wiring
We have several new servo boards purchased. We have already taken apart the previous wiring. 
The plan is to take the new servo boards, set them up by servo number, plug them in to the RPi in sets of 5 on the Raspberry Pi GPIO.
Finally we will plug in the power supply into the main body servo board. The hands servo board will be addressed later.

### Alexa Moving Motors
After setting up all of the wiring, we will try and recreate a similar project to [this](https://www.instructables.com/id/Animate-a-Billy-Bass-Mouth-With-Any-Audio-Source/) for the movement.
This should all happen internally on the Raspberry Pi. A connector piece will need to be designed and printed for the mouth to connect to the servo behind Talus's nose.

### RGB Eyes
We are planning on using either two RGB Addressable LEDs, or two RGB Dot Matrix. A semi-transparent, thin, rounded layer is preferable to diffuse the light.
Wiring and some soldering will be required.

### Alexa Eyes
Use the RGB Eyes along with the mouth to help set the mood of Talus. This way, the Alexa 'ring' can be used to identify when Talus is listening.



