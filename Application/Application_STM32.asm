_main:
;Application_STM32.c,5 :: 		void main()
;Application_STM32.c,7 :: 		GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13); // Set PC13 as digital output
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Application_STM32.c,9 :: 		while(1) {
L_main0:
;Application_STM32.c,10 :: 		GPIOC_ODR |= LED_PIN; // ON PC13
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #8192
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Application_STM32.c,11 :: 		Delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main2:
SUBS	R7, R7, #1
BNE	L_main2
NOP
NOP
NOP
NOP
;Application_STM32.c,12 :: 		GPIOC_ODR &= (~LED_PIN); // OFF PC13
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #8192
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOC_ODR+0)
MOVT	R0, #hi_addr(GPIOC_ODR+0)
STR	R1, [R0, #0]
;Application_STM32.c,13 :: 		Delay_ms(1000);
MOVW	R7, #24915
MOVT	R7, #81
NOP
NOP
L_main4:
SUBS	R7, R7, #1
BNE	L_main4
NOP
NOP
NOP
NOP
;Application_STM32.c,14 :: 		}
IT	AL
BAL	L_main0
;Application_STM32.c,15 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
