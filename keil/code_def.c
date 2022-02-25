#include "code_def.h"
#include <string.h>
#include <stdio.h>

extern uint8_t Number;

void delay_ms(int ms)
{
	uint32_t temp;
	SysTick->LOAD  = 50000;
	SysTick->VALUE = 0x00;      //清空计数器
	SysTick->CTRL  = 0x05;      //使能 无中断 采用处理器时钟
	do
	{
		temp = SysTick->CTRL;
	}while((temp&0x01)&&!(temp&(1<<16)));
	SysTick->CTRL  = 0x00;      //关闭计数器
	SysTick->VALUE = 0x00;			//清空计数器
}

void KEY0Handle(void)
{
	LED->OUT = LED->OUT | 0x01;
}

void KEY1Handle(void)
{
	LED->OUT = LED->OUT | 0x02;
}

void KEY2Handle(void)
{
	LED->OUT = LED->OUT | 0x04;
}

void KEY3Handle(void)
{
	LED->OUT = LED->OUT | 0x08;
}

void KEY4Handle(void)
{
	LED->OUT = LED->OUT | 0x10;
}

void KEY5Handle(void)
{
	LED->OUT = LED->OUT | 0x20;
}

void KEY6Handle(void)
{
	LED->OUT = LED->OUT | 0x40;
}

void KEY7Handle(void)
{
	LED->OUT = LED->OUT | 0x80;
}

char ReadUARTState()
{
    char state;
	state = UART -> UARTTX_STATE;
    return(state);
}

char ReadUART()
{
    char data;
	data = UART -> UARTRX_DATA;
    return(data);
}

void WriteUART(char data)
{
    while(ReadUARTState());
	UART -> UARTTX_DATA = data;
}

void UARTString(char *stri)
{
	int i;
	for(i=0;i<strlen(stri);i++)
	{
		WriteUART(stri[i]);
	}
}

void UARTHandle()
{
	int data;
	data = ReadUART();
	WriteUART(data);
	WriteUART('\r\n');
}

void  Key_Scan()
{
	MKEY->ROW = 0x00;           //按键检测
	if(MKEY->COL != 0x0F)
	{
		delay_ms(5);              //消抖
	
	  if(MKEY->COL != 0x0F)     //按键按下
		{
			MKEY->ROW = 0x07;       //0111  Row3
			switch(MKEY->COL)
			{
				case 0x07: Number = 1; break;
				case 0x0B: Number = 2; break;
				case 0x0D: Number = 3; break;
				case 0x0E: Number = 4; break;
			}
			
			MKEY->ROW = 0x0B;       //1011  Row2
			switch(MKEY->COL)
			{
				case 0x07: Number = 5; break;
				case 0x0B: Number = 6; break;
				case 0x0D: Number = 7; break;
				case 0x0E: Number = 8; break;
			}

			MKEY->ROW = 0x0D;       //1101  Row1
			switch(MKEY->COL)
			{
				case 0x07: Number = 9;  break;
				case 0x0B: Number = 10; break;
				case 0x0D: Number = 11; break;
				case 0x0E: Number = 12; break;
			}

			MKEY->ROW = 0x0E;       //1110  Row0
			switch(MKEY->COL)
			{
				case 0x07: Number = 13; break;
				case 0x0B: Number = 14; break;
				case 0x0D: Number = 15; break;
				case 0x0E: Number = 16; break;
			}		
		}	
	}
	
}

void Display()          //按键数字 显示
{
	SEG->DATA = Number;
}

void TIME_Init()        //T = 1s
{
	TIMER->LOAD   = 50000000;
	TIMER->ENABLE = 1;
}	

void TIMEHandle()
{
	printf("Cortex_M0 SEG_%X",Number);
}
