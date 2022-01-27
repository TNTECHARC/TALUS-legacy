//TALUS i2c communication server (Raspberry Pi)
//Jim Moroney 2022

#include <unistd.h>         //i2c library support
#include <fcntl.h>          //i2c library support
#include <sys/ioctl.h>      //i2c library support
#include <linux/i2c-dev.h>  //i2c library support
#include <stdio.h>          //io capabilities
#include <TALUS_i2c.h>      //various stuff for talus


int main()
{
    int i2c_bus;
    int slave_addr;

    char* busPATH = (char*)"/dev/i2c-1";
    if ((i2c_bus = open(busPATH, 0_RDRW)) < 0) // Open and varify the i2c bus.
    {
        printf("Failed to open the i2c bus");
        return 0;
    }



    return 0;
}