;/**************************************************************************//**
; * @file     startup_CMSDK_CM0.s
; * @brief    CMSIS Cortex-M0 Core Device Startup File for
; *           Device CMSDK_CM0
; * @version  V3.01
; * @date     06. March 2012
; *
; * @note
; * Copyright (C) 2012 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/
;/*
;//-------- <<< Use Configuration Wizard in Context Menu >>> ------------------
;*/


; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=4
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=4
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     0			              ; NMI Handler
                DCD     0				          ; Hard Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0			              ; SVCall Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0            			  ; PendSV Handler
                DCD     0          				  ; SysTick Handler
			
                DCD     UART_Handler              ; IRQ0 Handler
                DCD     TIME_Handler              ; IRQ1 Handler
                DCD     KEY0_Handler              ; IRQ2 Handler
                DCD     KEY1_Handler              ; IRQ3 Handler
                DCD     KEY2_Handler              ; IRQ4 Handler
                DCD     KEY3_Handler              ; IRQ5 Handler
                DCD     KEY4_Handler              ; IRQ6 Handler
                DCD     KEY5_Handler              ; IRQ7 Handler
                DCD     KEY6_Handler              ; IRQ8 Handler
                DCD     KEY7_Handler              ; IRQ9 Handler
					
                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                GLOBAL  Reset_Handler
				ENTRY
                IMPORT  __main
                LDR     R0, =__main
				MOV     R8, R0
                MOV     R9, R8
                BX      R0
                ENDP
					
 
UART_Handler    PROC
                EXPORT UART_Handler            [WEAK]
				IMPORT UARTHandle
				PUSH	{R0,R1,R2,LR}
                BL		UARTHandle
				POP		{R0,R1,R2,PC}
                ENDP
					
TIME_Handler    PROC
                EXPORT TIME_Handler            [WEAK]
				IMPORT TIMEHandle
				PUSH	{R0,R1,R2,LR}
                BL		TIMEHandle
				POP		{R0,R1,R2,PC}
                ENDP

KEY0_Handler    PROC
                EXPORT KEY0_Handler            [WEAK]
				IMPORT KEY0Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY0Handle
				POP		{R0,R1,R2,PC}
                ENDP
					
KEY1_Handler    PROC
                EXPORT KEY1_Handler            [WEAK]
				IMPORT KEY1Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY1Handle
				POP		{R0,R1,R2,PC}
                ENDP					
					
KEY2_Handler    PROC
                EXPORT KEY2_Handler            [WEAK]
				IMPORT KEY2Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY2Handle
				POP		{R0,R1,R2,PC}
                ENDP					
					
KEY3_Handler    PROC
                EXPORT KEY3_Handler            [WEAK]
				IMPORT KEY3Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY3Handle
				POP		{R0,R1,R2,PC}
                ENDP
					
KEY4_Handler    PROC
                EXPORT KEY4_Handler            [WEAK]
				IMPORT KEY4Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY4Handle
				POP		{R0,R1,R2,PC}
                ENDP
					
KEY5_Handler    PROC
                EXPORT KEY5_Handler            [WEAK]
				IMPORT KEY5Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY5Handle
				POP		{R0,R1,R2,PC}
                ENDP
					
KEY6_Handler    PROC
                EXPORT KEY6_Handler            [WEAK]
				IMPORT KEY6Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY6Handle
				POP		{R0,R1,R2,PC}
                ENDP
			
KEY7_Handler    PROC
                EXPORT KEY7_Handler            [WEAK]
				IMPORT KEY7Handle
				PUSH	{R0,R1,R2,LR}
                BL		KEY7Handle
				POP		{R0,R1,R2,PC}
                ENDP

                ALIGN 4

				IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap

__user_initial_stackheap 

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR
     
                ALIGN 

				ENDIF
					
                END
