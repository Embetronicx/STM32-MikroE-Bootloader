_Start_Program:
;Bootloader_STM32.c,26 :: 		void Start_Program() org START_PROGRAM_ADDR
;Bootloader_STM32.c,29 :: 		}
L_end_Start_Program:
BX	LR
; end of _Start_Program
_UART_Write_Loop:
;Bootloader_STM32.c,32 :: 		unsigned short UART_Write_Loop(char send, char receive)
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
;Bootloader_STM32.c,34 :: 		unsigned int rslt = 0;
MOVW	R2, #0
STRH	R2, [SP, #4]
;Bootloader_STM32.c,36 :: 		while(1)
L_UART_Write_Loop0:
;Bootloader_STM32.c,38 :: 		LED = 1;       // ON PC13
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R2, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R2, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,39 :: 		Delay_ms(20);
MOVW	R7, #41129
MOVT	R7, #1
NOP
NOP
L_UART_Write_Loop2:
SUBS	R7, R7, #1
BNE	L_UART_Write_Loop2
NOP
NOP
;Bootloader_STM32.c,40 :: 		UART_Write(send);
LDRB	R0, [SP, #8]
BL	_UART_Write+0
;Bootloader_STM32.c,41 :: 		LED = 0;       // OFF PC13
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R2, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R2, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,42 :: 		Delay_ms(20);
MOVW	R7, #41129
MOVT	R7, #1
NOP
NOP
L_UART_Write_Loop4:
SUBS	R7, R7, #1
BNE	L_UART_Write_Loop4
NOP
NOP
;Bootloader_STM32.c,44 :: 		rslt++;
LDRH	R2, [SP, #4]
ADDS	R2, R2, #1
UXTH	R2, R2
STRH	R2, [SP, #4]
;Bootloader_STM32.c,45 :: 		if (rslt == 0x64)           // 100 times
CMP	R2, #100
IT	NE
BNE	L_UART_Write_Loop6
;Bootloader_STM32.c,46 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_UART_Write_Loop
L_UART_Write_Loop6:
;Bootloader_STM32.c,47 :: 		if(UART_Data_Ready()) {
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	EQ
BEQ	L_UART_Write_Loop7
;Bootloader_STM32.c,48 :: 		if(UART_Read() == receive)
BL	_UART_Read+0
LDRB	R2, [SP, #12]
CMP	R0, R2
IT	NE
BNE	L_UART_Write_Loop8
;Bootloader_STM32.c,49 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_UART_Write_Loop
L_UART_Write_Loop8:
;Bootloader_STM32.c,50 :: 		}
L_UART_Write_Loop7:
;Bootloader_STM32.c,51 :: 		}
IT	AL
BAL	L_UART_Write_Loop0
;Bootloader_STM32.c,52 :: 		}
L_end_UART_Write_Loop:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _UART_Write_Loop
_FLASH_EraseWrite:
;Bootloader_STM32.c,54 :: 		void FLASH_EraseWrite(unsigned long address)
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R2, R0
; address end address is: 0 (R0)
; address start address is: 8 (R2)
;Bootloader_STM32.c,56 :: 		unsigned int i = 0;
;Bootloader_STM32.c,59 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;Bootloader_STM32.c,61 :: 		for (i = 0; i < 512; i++)
; i start address is: 28 (R7)
MOVS	R7, #0
; address end address is: 8 (R2)
; i end address is: 28 (R7)
MOV	R6, R2
L_FLASH_EraseWrite9:
; i start address is: 28 (R7)
; address start address is: 24 (R6)
; address start address is: 24 (R6)
; address end address is: 24 (R6)
CMP	R7, #512
IT	CS
BCS	L_FLASH_EraseWrite10
; address end address is: 24 (R6)
;Bootloader_STM32.c,63 :: 		dataToWrite = block[i * 2] | (block[i * 2 + 1] << 8);
; address start address is: 24 (R6)
LSLS	R4, R7, #1
UXTH	R4, R4
MOVW	R1, #lo_addr(Bootloader_STM32_block+0)
MOVT	R1, #hi_addr(Bootloader_STM32_block+0)
ADDS	R1, R1, R4
LDRB	R3, [R1, #0]
ADDS	R2, R4, #1
UXTH	R2, R2
MOVW	R1, #lo_addr(Bootloader_STM32_block+0)
MOVT	R1, #hi_addr(Bootloader_STM32_block+0)
ADDS	R1, R1, R2
LDRB	R1, [R1, #0]
LSLS	R1, R1, #8
UXTH	R1, R1
ORR	R2, R3, R1, LSL #0
;Bootloader_STM32.c,64 :: 		FLASH_Write_HalfWord( ( address + i*2 + + FLASH_DEFAULT_ADDR ), dataToWrite);
ADDS	R1, R6, R4
ADD	R1, R1, #134217728
MOV	R0, R1
UXTH	R1, R2
BL	_FLASH_Write_HalfWord+0
;Bootloader_STM32.c,61 :: 		for (i = 0; i < 512; i++)
ADDS	R7, R7, #1
UXTH	R7, R7
;Bootloader_STM32.c,65 :: 		}
; address end address is: 24 (R6)
; i end address is: 28 (R7)
IT	AL
BAL	L_FLASH_EraseWrite9
L_FLASH_EraseWrite10:
;Bootloader_STM32.c,67 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;Bootloader_STM32.c,68 :: 		}
L_end_FLASH_EraseWrite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _FLASH_EraseWrite
_Write_Begin:
;Bootloader_STM32.c,70 :: 		void Write_Begin()
SUB	SP, SP, #20
STR	LR, [SP, #0]
;Bootloader_STM32.c,79 :: 		arm_m0_inst = 0x4800 + 1;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18433
;Bootloader_STM32.c,81 :: 		appResetVector[0] = arm_m0_inst;
ADD	R2, SP, #4
MOVS	R0, #1
STRB	R0, [R2, #0]
;Bootloader_STM32.c,82 :: 		appResetVector[1] = arm_m0_inst >> 8;
ADDS	R1, R2, #1
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,85 :: 		arm_m0_inst = 0x4685;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18053
;Bootloader_STM32.c,87 :: 		appResetVector[2] = arm_m0_inst;
ADDS	R1, R2, #2
MOVS	R0, #133
STRB	R0, [R1, #0]
;Bootloader_STM32.c,88 :: 		appResetVector[3] = arm_m0_inst >> 8;
ADDS	R1, R2, #3
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,91 :: 		arm_m0_inst = 0x4800 + 1;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18433
;Bootloader_STM32.c,93 :: 		appResetVector[4] = arm_m0_inst;
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;Bootloader_STM32.c,94 :: 		appResetVector[5] = arm_m0_inst >> 8;
ADDS	R1, R2, #5
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,97 :: 		arm_m0_inst = 0x4700;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18176
;Bootloader_STM32.c,98 :: 		appResetVector[6] = arm_m0_inst;
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;Bootloader_STM32.c,99 :: 		appResetVector[7] = arm_m0_inst >> 8;
ADDS	R1, R2, #7
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,102 :: 		appResetVector[8] = block[0];
ADDW	R1, R2, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,103 :: 		appResetVector[9] = block[1];
ADDW	R1, R2, #9
MOVW	R0, #lo_addr(Bootloader_STM32_block+1)
MOVT	R0, #hi_addr(Bootloader_STM32_block+1)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,104 :: 		appResetVector[10] = block[2];
ADDW	R1, R2, #10
MOVW	R0, #lo_addr(Bootloader_STM32_block+2)
MOVT	R0, #hi_addr(Bootloader_STM32_block+2)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,105 :: 		appResetVector[11] = block[3];
ADDW	R1, R2, #11
MOVW	R0, #lo_addr(Bootloader_STM32_block+3)
MOVT	R0, #hi_addr(Bootloader_STM32_block+3)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,108 :: 		appResetVector[12] = block[4];
ADDW	R1, R2, #12
MOVW	R0, #lo_addr(Bootloader_STM32_block+4)
MOVT	R0, #hi_addr(Bootloader_STM32_block+4)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,109 :: 		appResetVector[13] = block[5];
ADDW	R1, R2, #13
MOVW	R0, #lo_addr(Bootloader_STM32_block+5)
MOVT	R0, #hi_addr(Bootloader_STM32_block+5)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,110 :: 		appResetVector[14] = block[6];
ADDW	R1, R2, #14
MOVW	R0, #lo_addr(Bootloader_STM32_block+6)
MOVT	R0, #hi_addr(Bootloader_STM32_block+6)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,111 :: 		appResetVector[15] = block[7];
ADDW	R1, R2, #15
MOVW	R0, #lo_addr(Bootloader_STM32_block+7)
MOVT	R0, #hi_addr(Bootloader_STM32_block+7)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,113 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;Bootloader_STM32.c,116 :: 		FLASH_EraseSector(_FLASH_SECTOR_7);
MOV	R0, #56
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,118 :: 		for (i = 0; i < 8; i++)
; i start address is: 24 (R6)
MOVS	R6, #0
; i end address is: 24 (R6)
L_Write_Begin12:
; i start address is: 24 (R6)
CMP	R6, #8
IT	CS
BCS	L_Write_Begin13
;Bootloader_STM32.c,120 :: 		dataToWrite = appResetVector[i * 2] | (appResetVector[i * 2 + 1] << 8);
LSLS	R3, R6, #1
UXTH	R3, R3
ADD	R2, SP, #4
ADDS	R0, R2, R3
LDRB	R1, [R0, #0]
ADDS	R0, R3, #1
UXTH	R0, R0
ADDS	R0, R2, R0
LDRB	R0, [R0, #0]
LSLS	R0, R0, #8
UXTH	R0, R0
ORRS	R1, R0
;Bootloader_STM32.c,121 :: 		FLASH_Write_HalfWord( ( START_PROGRAM_ADDR + FLASH_DEFAULT_ADDR + i*2 ), dataToWrite);
MOVW	R0, #0
MOVT	R0, #2054
ADDS	R0, R0, R3
BL	_FLASH_Write_HalfWord+0
;Bootloader_STM32.c,118 :: 		for (i = 0; i < 8; i++)
ADDS	R6, R6, #1
UXTH	R6, R6
;Bootloader_STM32.c,122 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_Write_Begin12
L_Write_Begin13:
;Bootloader_STM32.c,124 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;Bootloader_STM32.c,126 :: 		ptr = (unsigned long*)0x00000000;
; ptr start address is: 12 (R3)
MOVW	R3, #0
MOVT	R3, #0
;Bootloader_STM32.c,127 :: 		block[0] = LoWord(*ptr);
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,128 :: 		block[1] = LoWord(*ptr) >> 8;
LDRH	R0, [R3, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+1)
MOVT	R0, #hi_addr(Bootloader_STM32_block+1)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,129 :: 		block[2] = HiWord(*ptr);
ADDS	R0, R3, #2
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+2)
MOVT	R0, #hi_addr(Bootloader_STM32_block+2)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,130 :: 		block[3] = HiWord(*ptr) >> 8;
ADDS	R0, R3, #2
LDRH	R0, [R0, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+3)
MOVT	R0, #hi_addr(Bootloader_STM32_block+3)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,132 :: 		ptr++;
ADDS	R2, R3, #4
; ptr end address is: 12 (R3)
;Bootloader_STM32.c,134 :: 		block[4] = LoWord(*ptr);
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+4)
MOVT	R0, #hi_addr(Bootloader_STM32_block+4)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,135 :: 		block[5] = LoWord(*ptr) >> 8;
LDRH	R0, [R2, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+5)
MOVT	R0, #hi_addr(Bootloader_STM32_block+5)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,136 :: 		block[6] = HiWord(*ptr);
ADDS	R0, R2, #2
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+6)
MOVT	R0, #hi_addr(Bootloader_STM32_block+6)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,137 :: 		block[7] = HiWord(*ptr) >> 8;
ADDS	R0, R2, #2
LDRH	R0, [R0, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+7)
MOVT	R0, #hi_addr(Bootloader_STM32_block+7)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,140 :: 		FLASH_EraseSector(_FLASH_SECTOR_0);
MOV	R0, #0
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,141 :: 		FLASH_EraseSector(_FLASH_SECTOR_1);
MOV	R0, #8
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,142 :: 		FLASH_EraseSector(_FLASH_SECTOR_2);
MOV	R0, #16
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,143 :: 		FLASH_EraseSector(_FLASH_SECTOR_3);
MOV	R0, #24
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,144 :: 		FLASH_EraseSector(_FLASH_SECTOR_4);
MOV	R0, #32
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,145 :: 		FLASH_EraseSector(_FLASH_SECTOR_5);
MOV	R0, #40
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,146 :: 		}
L_end_Write_Begin:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _Write_Begin
_Start_Bootload:
;Bootloader_STM32.c,148 :: 		void Start_Bootload()
SUB	SP, SP, #16
STR	LR, [SP, #0]
;Bootloader_STM32.c,150 :: 		unsigned int i = 0;
MOVW	R0, #0
STRH	R0, [SP, #6]
;Bootloader_STM32.c,152 :: 		long j = 0x0;
MOV	R0, #0
STR	R0, [SP, #8]
MOVW	R0, #0
STRH	R0, [SP, #12]
;Bootloader_STM32.c,153 :: 		int k =0;
;Bootloader_STM32.c,154 :: 		unsigned int fw_size = 0;
;Bootloader_STM32.c,155 :: 		unsigned int curr_fw_size = 0;
;Bootloader_STM32.c,159 :: 		UART_Write('y');
MOVS	R0, #121
BL	_UART_Write+0
;Bootloader_STM32.c,160 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload15:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload16
IT	AL
BAL	L_Start_Bootload15
L_Start_Bootload16:
;Bootloader_STM32.c,162 :: 		yy = UART_Read();
BL	_UART_Read+0
STRB	R0, [SP, #4]
;Bootloader_STM32.c,164 :: 		UART_Write('x');
MOVS	R0, #120
BL	_UART_Write+0
;Bootloader_STM32.c,165 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload17:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload18
IT	AL
BAL	L_Start_Bootload17
L_Start_Bootload18:
;Bootloader_STM32.c,167 :: 		xx = UART_Read();
BL	_UART_Read+0
;Bootloader_STM32.c,169 :: 		fw_size = yy | (xx << 8);
UXTB	R0, R0
LSLS	R1, R0, #8
UXTH	R1, R1
LDRB	R0, [SP, #4]
ORRS	R0, R1
STRH	R0, [SP, #14]
;Bootloader_STM32.c,171 :: 		while (1) {
L_Start_Bootload19:
;Bootloader_STM32.c,172 :: 		if( (i == MAX_BLOCK_SIZE) || ( curr_fw_size >= fw_size ) ) {
LDRH	R0, [SP, #6]
CMP	R0, #1024
IT	EQ
BEQ	L__Start_Bootload42
LDRH	R1, [SP, #14]
LDRH	R0, [SP, #12]
CMP	R0, R1
IT	CS
BCS	L__Start_Bootload41
IT	AL
BAL	L_Start_Bootload23
L__Start_Bootload42:
L__Start_Bootload41:
;Bootloader_STM32.c,174 :: 		if (!j)
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload24
;Bootloader_STM32.c,175 :: 		Write_Begin();
BL	_Write_Begin+0
L_Start_Bootload24:
;Bootloader_STM32.c,176 :: 		if (j < BOOTLOADER_START_ADDR) {
LDR	R0, [SP, #8]
CMP	R0, #262144
IT	GE
BGE	L_Start_Bootload25
;Bootloader_STM32.c,177 :: 		FLASH_EraseWrite(j);
LDR	R0, [SP, #8]
BL	_FLASH_EraseWrite+0
;Bootloader_STM32.c,178 :: 		}
L_Start_Bootload25:
;Bootloader_STM32.c,180 :: 		i = 0;
MOVS	R0, #0
STRH	R0, [SP, #6]
;Bootloader_STM32.c,181 :: 		j += 0x400;
LDR	R0, [SP, #8]
ADD	R0, R0, #1024
STR	R0, [SP, #8]
;Bootloader_STM32.c,183 :: 		for(k=0; k<MAX_BLOCK_SIZE; k++)
; k start address is: 20 (R5)
MOVS	R5, #0
SXTH	R5, R5
; k end address is: 20 (R5)
SXTH	R2, R5
L_Start_Bootload26:
; k start address is: 8 (R2)
CMP	R2, #1024
IT	GE
BGE	L_Start_Bootload27
;Bootloader_STM32.c,185 :: 		block[k] = 0;
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
ADDS	R1, R0, R2
MOVS	R0, #0
STRB	R0, [R1, #0]
;Bootloader_STM32.c,183 :: 		for(k=0; k<MAX_BLOCK_SIZE; k++)
ADDS	R0, R2, #1
; k end address is: 8 (R2)
; k start address is: 20 (R5)
SXTH	R5, R0
;Bootloader_STM32.c,186 :: 		}
SXTH	R2, R5
; k end address is: 20 (R5)
IT	AL
BAL	L_Start_Bootload26
L_Start_Bootload27:
;Bootloader_STM32.c,187 :: 		}
L_Start_Bootload23:
;Bootloader_STM32.c,188 :: 		if( curr_fw_size >= fw_size )
LDRH	R1, [SP, #14]
LDRH	R0, [SP, #12]
CMP	R0, R1
IT	CC
BCC	L_Start_Bootload29
;Bootloader_STM32.c,190 :: 		LED = 1; // OFF PC13
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R0, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R0, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,191 :: 		Delay_ms(2000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_Start_Bootload30:
SUBS	R7, R7, #1
BNE	L_Start_Bootload30
NOP
NOP
;Bootloader_STM32.c,192 :: 		UART2_Write_Text("Jumping to Application!!!\r\n");
MOVW	R0, #lo_addr(?lstr1_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr1_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,193 :: 		Start_Program();
BL	393216
;Bootloader_STM32.c,194 :: 		}
L_Start_Bootload29:
;Bootloader_STM32.c,197 :: 		UART_Write('y');
MOVS	R0, #121
BL	_UART_Write+0
;Bootloader_STM32.c,198 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload32:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload33
IT	AL
BAL	L_Start_Bootload32
L_Start_Bootload33:
;Bootloader_STM32.c,200 :: 		yy = UART_Read();
BL	_UART_Read+0
STRB	R0, [SP, #4]
;Bootloader_STM32.c,202 :: 		UART_Write('x');
MOVS	R0, #120
BL	_UART_Write+0
;Bootloader_STM32.c,203 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload34:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload35
IT	AL
BAL	L_Start_Bootload34
L_Start_Bootload35:
;Bootloader_STM32.c,205 :: 		xx = UART_Read();
BL	_UART_Read+0
; xx start address is: 8 (R2)
UXTB	R2, R0
;Bootloader_STM32.c,207 :: 		block[i++] = yy;
LDRH	R1, [SP, #6]
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
ADDS	R1, R0, R1
LDRB	R0, [SP, #4]
STRB	R0, [R1, #0]
LDRH	R0, [SP, #6]
ADDS	R1, R0, #1
UXTH	R1, R1
STRH	R1, [SP, #6]
;Bootloader_STM32.c,208 :: 		block[i++] = xx;
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
ADDS	R0, R0, R1
STRB	R2, [R0, #0]
; xx end address is: 8 (R2)
LDRH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;Bootloader_STM32.c,210 :: 		curr_fw_size += 2;
LDRH	R0, [SP, #12]
ADDS	R0, R0, #2
STRH	R0, [SP, #12]
;Bootloader_STM32.c,211 :: 		}
IT	AL
BAL	L_Start_Bootload19
;Bootloader_STM32.c,212 :: 		}
L_end_Start_Bootload:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _Start_Bootload
_main:
;Bootloader_STM32.c,214 :: 		void main()
;Bootloader_STM32.c,218 :: 		GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_13);
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Bootloader_STM32.c,219 :: 		UART2_Init(115200);                                        //Debug Print UART
MOV	R0, #115200
BL	_UART2_Init+0
;Bootloader_STM32.c,222 :: 		UART2_Write_Text("!------Firmware Update using UART------!\r\n");
MOVW	R0, #lo_addr(?lstr2_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr2_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,223 :: 		UART1_Init(115200);
MOV	R0, #115200
BL	_UART1_Init+0
;Bootloader_STM32.c,224 :: 		if(UART_Write_Loop('g','r'))       // Send 'g' for ~5 sec, if 'r'
MOVS	R1, #114
MOVS	R0, #103
BL	_UART_Write_Loop+0
CMP	R0, #0
IT	EQ
BEQ	L_main36
;Bootloader_STM32.c,226 :: 		Start_Bootload();                //   received start bootload
BL	_Start_Bootload+0
;Bootloader_STM32.c,227 :: 		}
IT	AL
BAL	L_main37
L_main36:
;Bootloader_STM32.c,231 :: 		UART2_Write_Text("Jumping to Application!!!\r\n");
MOVW	R0, #lo_addr(?lstr3_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr3_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,232 :: 		Start_Program();                  //   else start program
BL	393216
;Bootloader_STM32.c,233 :: 		}
L_main37:
;Bootloader_STM32.c,235 :: 		UART2_Write_Text("No Application Available...HALT!!!\r\n");
MOVW	R0, #lo_addr(?lstr4_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr4_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,236 :: 		while(1)
L_main38:
;Bootloader_STM32.c,238 :: 		}
IT	AL
BAL	L_main38
;Bootloader_STM32.c,239 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
