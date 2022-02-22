//Talus I2C Communication client (Arduino)
//Jim Moroney 2022

#include <TALUS_i2c.h>

#define ADDR 0x8 // i2c bus address must be something that can be changed
                 // many items do not have flexible i2c addresses

dataPkg test;

void setup()
{
    Wire.begin(ADDR) // join the i2c bus using the defined address
    Wire.onReceive(receivedEvent); // call function receivedEvent when data is received
}

void receivedEvent()
{
    int position = 0;
    uint8_t buffer[MAX_BUFF] = {0}
    while(Wire.available()) //loop through all the values currently received
    {
        buffer[position] = Wire.read();
        position++;
    }
    bufferUnpack(buffer, test); // found in TALUS_i2c.h
    switch(test.funcNum) // what do I do now?
    {
        case 1:
            //placeholder
            break;
        case 2:
            break;
        default:
            //write error handler, i2c bidirectional comm
            break;
    }
}
void loop()
{
    delay(100);
}