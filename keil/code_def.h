#include <stdint.h>

//INTERRUPT DEF
#define NVIC_CTRL_ADDR (*(volatile unsigned *)0xe000e100)
	
//SysTick DEF
typedef struct{
    volatile uint32_t CTRL;
    volatile uint32_t LOAD;
    volatile uint32_t VALUE;
    volatile uint32_t CALIB;
}SysTickType;

#define SysTick_BASE 0xe000e010
#define SysTick ((SysTickType *)SysTick_BASE)


//LED DEF
typedef struct{
    volatile uint32_t OUT;
}LEDType;

#define LED_BASE 0x40000000
#define LED ((LEDType *)LED_BASE)

//UART DEF
typedef struct{
    volatile uint32_t UARTRX_DATA;
    volatile uint32_t UARTTX_STATE;
    volatile uint32_t UARTTX_DATA;
}UARTType;

#define UART_BASE 0x40010000
#define UART ((UARTType *)UART_BASE)


//Matrix_Key DEF
typedef struct{
    volatile uint32_t ROW;
    volatile uint32_t COL;
}MKEYType;

#define MKEY_BASE 0x40020000
#define MKEY ((MKEYType *)MKEY_BASE)


//SEG DEF
typedef struct{
    volatile uint32_t DATA;
}SEGType;

#define SEG_BASE 0x40030000
#define SEG ((SEGType *)SEG_BASE)


//TIME DEF
typedef struct{
    volatile uint32_t LOAD;
    volatile uint32_t ENABLE;
    volatile uint32_t VALUE;
}TIMERType;

#define TIMER_BASE 0x40040000
#define TIMER ((TIMERType *)TIMER_BASE)

void delay_ms(int ms);

void KEY0Handle(void);
void KEY1Handle(void);
void KEY2Handle(void);
void KEY3Handle(void);
void KEY4Handle(void);
void KEY5Handle(void);
void KEY6Handle(void);
void KEY7Handle(void);

char ReadUARTState(void);
char ReadUART(void);
void WriteUART(char data);
void UARTString(char *stri);
void UARTHandle(void);

void Key_Scan(void);

void Display();

void TIME_Init(void);
void TIMEHandle(void);
