#ifndef TALUS_I2C_H
#define TALUS_I2C_H

#include <stdint.h>         //fixed with variables

struct test_package_struct
{
    uint8_t funcNum;
    uint8_t param1;
    uint8_t param2;
}__attribute__((packed));

#endif //TALUS_I2C_H