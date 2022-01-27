#ifndef TALUS_I2C_H
#define TALUS_I2C_H

#include <stdint.h>         //fixed with variables

#define MAX_BUFF 4

struct test_package_struct
{
    uint8_t funcNum;
    uint8_t param1;
    uint8_t param2;
}__attribute__((packed));
typedef test_package_struct dataPkg;

void bufferUnpack(uint8_t* buffer, dataPkg* pkg)
{
    pkg->funcNum = buffer[0];
    pkg->param1 = buffer[1];
    pkg->param2 = buffer[2];
}
void bufferPack(uint8_t* buffer, dataPkg* pkg)
{
    buffer[0] = pkg->funcNum;
    buffer[1] = pkg->param1;
    buffer[2] = pkg->param2;
}

#endif //TALUS_I2C_H