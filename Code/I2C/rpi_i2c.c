//TALUS i2c communication server (Raspberry Pi)
//Jim Moroney 2022


#include <TALUS_i2c.h>      //various stuff for talus

#define MAX_SLAVE 8 //Maximum amount of slaves on program run

int main()
{
    int i2c_bus = 0;
    int slaveAddrs[MAX_SLAVE] = {0};
    int numDevices = 0;

    char* busPATH = (char*)"/dev/i2c-1";
    if ((i2c_bus = open(busPATH, O_RDRW)) < 0) // Open and varify the i2c bus.
    {
        printf("Failed to open the i2c bus");
        return 0;
    }

    for (int address = 1; address < 127; address++) // Sweep through all possible bus i2c addresses
    {   // test if there is a valid i2c device at this address
        if(ioctl(i2c_bus, I2C_SLAVE, address) < 0) 
        {   // if there isn't, say so and advance to next address
            printf("I2C: No device found at address %x\n", address);
        }
        else
        {   // if there is, add it to the slave address array
            printf("I2C: Device found at address %x\n", address)
            slaveAddrs[numDevices] = address;
            numDevices++;
        }
    }



    return 0;
}