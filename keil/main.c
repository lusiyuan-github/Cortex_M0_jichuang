#include "code_def.h"
#include <stdint.h>
#include <stdio.h>

int Number = 0;

int main()
{ 
	//interrupt initial
	NVIC_CTRL_ADDR = 0x03FF;      //ʹ��IRQ0 ~ IRQ9
	
	LED->OUT = 0;                 //��ʼȫ��
	
	TIME_Init();
	
	while(1)
	{
		Key_Scan();
		Display();
	}

}

