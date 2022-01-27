//TALUS i2c communication server (Raspberry Pi)

#include <unistd.h>         //i2c library support
#include <fcntl.h>          //i2c library support
#include <sys/ioctl.h>      //i2c library support
#include <linux/i2c-dev.h>  //i2c library support
#include <stdint.h>         //fixed with variables
#include <stdio.h>          //io capabilities

struct testPkg
{
    uint
}