#include <stdint.h>
#include <stdbool.h>

uint16_t* buttons = (uint16_t*)0x80469140; // UTSC 1.0
//The buttons are a 16bit bitfield 
enum inputs{left,right,down,up,Z,R,L,A,B,X,Y};

inline bool buttonDown(int input)
{
    return *buttons & (1 << input);
}
//Bit set indicates the button is being held down


//Set Stamina HP based on DPad and the R button
int staminaHP()
{
    if(buttonDown(R))
    {
        if(buttonDown(left)){
            return 300;
        }
        if(buttonDown(down)){
            return 500;
        }
        if(buttonDown(right)){
            return 999;
        }
    }
    return 150; //default
}