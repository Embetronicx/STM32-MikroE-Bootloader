_Start_Program:
;Bootloader_STM32.c,38 :: 		void Start_Program() org START_PROGRAM_ADDR
;Bootloader_STM32.c,41 :: 		}
L_end_Start_Program:
BX	LR
; end of _Start_Program
_Mmc_TimeoutCallback:
;Bootloader_STM32.c,44 :: 		void Mmc_TimeoutCallback(char errorCode) {
; errorCode start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
UXTB	R7, R0
; errorCode end address is: 0 (R0)
; errorCode start address is: 28 (R7)
;Bootloader_STM32.c,46 :: 		if (errorCode == _MMC_INIT_TIMEOUT) {
CMP	R7, #1
IT	NE
BNE	L_Mmc_TimeoutCallback0
;Bootloader_STM32.c,47 :: 		UART2_Write_Text("INIT TIMEOUT!!!\r\n");
MOVW	R1, #lo_addr(?lstr1_Bootloader_STM32+0)
MOVT	R1, #hi_addr(?lstr1_Bootloader_STM32+0)
MOV	R0, R1
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,48 :: 		}
L_Mmc_TimeoutCallback0:
;Bootloader_STM32.c,51 :: 		if (errorCode == _MMC_CMD_TIMEOUT) {
CMP	R7, #2
IT	NE
BNE	L_Mmc_TimeoutCallback1
;Bootloader_STM32.c,52 :: 		UART2_Write_Text("READ TIMEOUT!!!\r\n");
MOVW	R1, #lo_addr(?lstr2_Bootloader_STM32+0)
MOVT	R1, #hi_addr(?lstr2_Bootloader_STM32+0)
MOV	R0, R1
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,53 :: 		}
L_Mmc_TimeoutCallback1:
;Bootloader_STM32.c,56 :: 		if (errorCode == _MMC_SPI_TIMEOUT) {
CMP	R7, #3
IT	NE
BNE	L_Mmc_TimeoutCallback2
; errorCode end address is: 28 (R7)
;Bootloader_STM32.c,57 :: 		UART2_Write_Text("SPI TIMEOUT!!!\r\n");
MOVW	R1, #lo_addr(?lstr3_Bootloader_STM32+0)
MOVT	R1, #hi_addr(?lstr3_Bootloader_STM32+0)
MOV	R0, R1
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,58 :: 		}
L_Mmc_TimeoutCallback2:
;Bootloader_STM32.c,59 :: 		}
L_end_Mmc_TimeoutCallback:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Mmc_TimeoutCallback
_SD_Card_FW_Update:
;Bootloader_STM32.c,63 :: 		void SD_Card_FW_Update( void )
SUB	SP, SP, #32
STR	LR, [SP, #0]
;Bootloader_STM32.c,66 :: 		char str[10] = {0};
ADD	R11, SP, #8
ADD	R10, R11, #18
MOVW	R12, #lo_addr(?ICSSD_Card_FW_Update_str_L0+0)
MOVT	R12, #hi_addr(?ICSSD_Card_FW_Update_str_L0+0)
BL	___CC2DW+0
;Bootloader_STM32.c,67 :: 		uint32_t temp_size = 0;
;Bootloader_STM32.c,68 :: 		uint32_t read_size = 0;
;Bootloader_STM32.c,69 :: 		int del_file = 0;
;Bootloader_STM32.c,71 :: 		UART2_Write_Text("Ok\r\nFiles available in the SD Card:");
MOVW	R0, #lo_addr(?lstr4_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr4_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,74 :: 		UART_Set_Active(&UART2_Read, &UART2_Write, &UART2_Data_Ready, &UART2_Tx_Idle);
MOVW	R3, #lo_addr(_UART2_Tx_Idle+0)
MOVT	R3, #hi_addr(_UART2_Tx_Idle+0)
MOVW	R2, #lo_addr(_UART2_Data_Ready+0)
MOVT	R2, #hi_addr(_UART2_Data_Ready+0)
MOVW	R1, #lo_addr(_UART2_Write+0)
MOVT	R1, #hi_addr(_UART2_Write+0)
MOVW	R0, #lo_addr(_UART2_Read+0)
MOVT	R0, #hi_addr(_UART2_Read+0)
BL	_UART_Set_Active+0
;Bootloader_STM32.c,75 :: 		FAT32_Dir();
BL	_FAT32_Dir+0
;Bootloader_STM32.c,76 :: 		UART_Write(CR);
MOVS	R0, #13
BL	_UART_Write+0
;Bootloader_STM32.c,79 :: 		UART2_Write_Text("Open Firmware file... ");
MOVW	R0, #lo_addr(?lstr5_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr5_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,80 :: 		fileHandle = FAT32_Open(FIRMWARE_FILE_NAME, FILE_READ);
MOVW	R0, #lo_addr(?lstr6_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr6_Bootloader_STM32+0)
MOVS	R1, #1
BL	_FAT32_Open+0
MOVW	R1, #lo_addr(_fileHandle+0)
MOVT	R1, #hi_addr(_fileHandle+0)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,81 :: 		if(fileHandle != 0) {
CMP	R0, #0
IT	EQ
BEQ	L_SD_Card_FW_Update3
;Bootloader_STM32.c,82 :: 		UART2_Write_Text("No Firmware File Found!!!\r\n");
MOVW	R0, #lo_addr(?lstr7_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr7_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,83 :: 		}
IT	AL
BAL	L_SD_Card_FW_Update4
L_SD_Card_FW_Update3:
;Bootloader_STM32.c,85 :: 		UART2_Write_Text("OK\r\n");
MOVW	R0, #lo_addr(?lstr8_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr8_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,86 :: 		FAT32_Size(FIRMWARE_FILE_NAME, &size);
ADD	R1, SP, #4
MOVW	R0, #lo_addr(?lstr9_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr9_Bootloader_STM32+0)
BL	_FAT32_Size+0
;Bootloader_STM32.c,87 :: 		IntToStr(size, str);
ADD	R0, SP, #8
MOV	R1, R0
LDR	R0, [SP, #4]
BL	_IntToStr+0
;Bootloader_STM32.c,88 :: 		UART2_Write_Text("Firmware File Size = ");
MOVW	R0, #lo_addr(?lstr10_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr10_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,89 :: 		UART2_Write_Text(str);
ADD	R0, SP, #8
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,90 :: 		UART2_Write_Text("\r\n");
MOVW	R0, #lo_addr(?lstr11_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr11_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,91 :: 		if( size <= MAX_APP_SIZE ) {
LDR	R0, [SP, #4]
CMP	R0, #262144
IT	HI
BHI	L_SD_Card_FW_Update5
;Bootloader_STM32.c,92 :: 		if( size > 0 )  {
LDR	R0, [SP, #4]
CMP	R0, #0
IT	LS
BLS	L_SD_Card_FW_Update6
;Bootloader_STM32.c,93 :: 		while( temp_size < size ) {
L_SD_Card_FW_Update7:
LDR	R1, [SP, #4]
LDR	R0, [SP, #20]
CMP	R0, R1
IT	CS
BCS	L_SD_Card_FW_Update8
;Bootloader_STM32.c,94 :: 		if( ( size - temp_size ) > MAX_BLOCK_SIZE ) {
LDR	R1, [SP, #20]
LDR	R0, [SP, #4]
SUB	R0, R0, R1
CMP	R0, #1024
IT	LS
BLS	L_SD_Card_FW_Update9
;Bootloader_STM32.c,95 :: 		read_size = MAX_BLOCK_SIZE;
MOVW	R0, #1024
STR	R0, [SP, #28]
;Bootloader_STM32.c,96 :: 		}
IT	AL
BAL	L_SD_Card_FW_Update10
L_SD_Card_FW_Update9:
;Bootloader_STM32.c,98 :: 		read_size = ( size - temp_size );
LDR	R1, [SP, #20]
LDR	R0, [SP, #4]
SUB	R0, R0, R1
STR	R0, [SP, #28]
;Bootloader_STM32.c,99 :: 		}
L_SD_Card_FW_Update10:
;Bootloader_STM32.c,101 :: 		IntToStr(read_size, str);
ADD	R0, SP, #8
MOV	R1, R0
LDR	R0, [SP, #28]
BL	_IntToStr+0
;Bootloader_STM32.c,102 :: 		UART2_Write_Text("Read Block Size = ");
MOVW	R0, #lo_addr(?lstr12_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr12_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,103 :: 		UART2_Write_Text(str);
ADD	R0, SP, #8
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,104 :: 		UART2_Write_Text("\r\n");
MOVW	R0, #lo_addr(?lstr13_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr13_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,106 :: 		FAT32_Read(fileHandle, block, read_size);
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
LDR	R2, [SP, #28]
MOVW	R1, #lo_addr(Bootloader_STM32_block+0)
MOVT	R1, #hi_addr(Bootloader_STM32_block+0)
BL	_FAT32_Read+0
;Bootloader_STM32.c,108 :: 		if( temp_size == 0 ) {
LDR	R0, [SP, #20]
CMP	R0, #0
IT	NE
BNE	L_SD_Card_FW_Update11
;Bootloader_STM32.c,110 :: 		Write_Begin();
BL	_Write_Begin+0
;Bootloader_STM32.c,111 :: 		}
L_SD_Card_FW_Update11:
;Bootloader_STM32.c,112 :: 		if(temp_size < BOOTLOADER_START_ADDR) {
LDR	R0, [SP, #20]
CMP	R0, #262144
IT	CS
BCS	L_SD_Card_FW_Update12
;Bootloader_STM32.c,113 :: 		FLASH_EraseWrite(temp_size);
LDR	R0, [SP, #20]
BL	_FLASH_EraseWrite+0
;Bootloader_STM32.c,114 :: 		}
L_SD_Card_FW_Update12:
;Bootloader_STM32.c,116 :: 		temp_size += read_size;
LDR	R1, [SP, #28]
LDR	R0, [SP, #20]
ADDS	R0, R0, R1
STR	R0, [SP, #20]
;Bootloader_STM32.c,119 :: 		memset( block, 0, MAX_BLOCK_SIZE );
MOVW	R2, #1024
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
BL	_memset+0
;Bootloader_STM32.c,120 :: 		}
IT	AL
BAL	L_SD_Card_FW_Update7
L_SD_Card_FW_Update8:
;Bootloader_STM32.c,121 :: 		UART2_Write_Text("SD Card Firmware Update Done!!!\r\n");
MOVW	R0, #lo_addr(?lstr14_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr14_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,123 :: 		del_file = 1;
MOVS	R0, #1
SXTH	R0, R0
STRH	R0, [SP, #24]
;Bootloader_STM32.c,124 :: 		}
L_SD_Card_FW_Update6:
;Bootloader_STM32.c,125 :: 		}
IT	AL
BAL	L_SD_Card_FW_Update13
L_SD_Card_FW_Update5:
;Bootloader_STM32.c,127 :: 		UART2_Write_Text("App size is maximum, Can't Process...\r\n");
MOVW	R0, #lo_addr(?lstr15_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr15_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,128 :: 		}
L_SD_Card_FW_Update13:
;Bootloader_STM32.c,130 :: 		FAT32_Close(fileHandle);
MOVW	R0, #lo_addr(_fileHandle+0)
MOVT	R0, #hi_addr(_fileHandle+0)
LDRSB	R0, [R0, #0]
BL	_FAT32_Close+0
;Bootloader_STM32.c,132 :: 		if( del_file == 1 ) {
LDRSH	R0, [SP, #24]
CMP	R0, #1
IT	NE
BNE	L_SD_Card_FW_Update14
;Bootloader_STM32.c,133 :: 		UART2_Write_Text("Deleting the Firmware File!!!\r\n");
MOVW	R0, #lo_addr(?lstr16_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr16_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,135 :: 		FAT32_Delete(FIRMWARE_FILE_NAME);
MOVW	R0, #lo_addr(?lstr17_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr17_Bootloader_STM32+0)
BL	_FAT32_Delete+0
;Bootloader_STM32.c,136 :: 		}
L_SD_Card_FW_Update14:
;Bootloader_STM32.c,137 :: 		}
L_SD_Card_FW_Update4:
;Bootloader_STM32.c,138 :: 		}
L_end_SD_Card_FW_Update:
LDR	LR, [SP, #0]
ADD	SP, SP, #32
BX	LR
; end of _SD_Card_FW_Update
_UART_Write_Loop:
;Bootloader_STM32.c,142 :: 		unsigned short UART_Write_Loop(char send, char receive)
SUB	SP, SP, #16
STR	LR, [SP, #0]
STRB	R0, [SP, #8]
STRB	R1, [SP, #12]
;Bootloader_STM32.c,144 :: 		unsigned int rslt = 0;
MOVW	R2, #0
STRH	R2, [SP, #4]
;Bootloader_STM32.c,146 :: 		while(1)
L_UART_Write_Loop15:
;Bootloader_STM32.c,148 :: 		LED = 1;       // ON PC13
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R2, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R2, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,149 :: 		Delay_ms(20);
MOVW	R7, #41129
MOVT	R7, #1
NOP
NOP
L_UART_Write_Loop17:
SUBS	R7, R7, #1
BNE	L_UART_Write_Loop17
NOP
NOP
;Bootloader_STM32.c,150 :: 		UART_Write(send);
LDRB	R0, [SP, #8]
BL	_UART_Write+0
;Bootloader_STM32.c,151 :: 		LED = 0;       // OFF PC13
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R2, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R2, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,152 :: 		Delay_ms(20);
MOVW	R7, #41129
MOVT	R7, #1
NOP
NOP
L_UART_Write_Loop19:
SUBS	R7, R7, #1
BNE	L_UART_Write_Loop19
NOP
NOP
;Bootloader_STM32.c,154 :: 		rslt++;
LDRH	R2, [SP, #4]
ADDS	R2, R2, #1
UXTH	R2, R2
STRH	R2, [SP, #4]
;Bootloader_STM32.c,155 :: 		if (rslt == 0x64)           // 100 times
CMP	R2, #100
IT	NE
BNE	L_UART_Write_Loop21
;Bootloader_STM32.c,157 :: 		UART2_Write_Text("No data received from UART!!!\r\n");
MOVW	R2, #lo_addr(?lstr18_Bootloader_STM32+0)
MOVT	R2, #hi_addr(?lstr18_Bootloader_STM32+0)
MOV	R0, R2
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,158 :: 		return 0;
MOVS	R0, #0
IT	AL
BAL	L_end_UART_Write_Loop
;Bootloader_STM32.c,159 :: 		}
L_UART_Write_Loop21:
;Bootloader_STM32.c,160 :: 		if(UART_Data_Ready()) {
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	EQ
BEQ	L_UART_Write_Loop22
;Bootloader_STM32.c,161 :: 		if(UART_Read() == receive)
BL	_UART_Read+0
LDRB	R2, [SP, #12]
CMP	R0, R2
IT	NE
BNE	L_UART_Write_Loop23
;Bootloader_STM32.c,162 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_UART_Write_Loop
L_UART_Write_Loop23:
;Bootloader_STM32.c,163 :: 		}
L_UART_Write_Loop22:
;Bootloader_STM32.c,164 :: 		}
IT	AL
BAL	L_UART_Write_Loop15
;Bootloader_STM32.c,165 :: 		}
L_end_UART_Write_Loop:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _UART_Write_Loop
_FLASH_EraseWrite:
;Bootloader_STM32.c,167 :: 		void FLASH_EraseWrite(unsigned long address)
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R2, R0
; address end address is: 0 (R0)
; address start address is: 8 (R2)
;Bootloader_STM32.c,169 :: 		unsigned int i = 0;
;Bootloader_STM32.c,172 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;Bootloader_STM32.c,174 :: 		for (i = 0; i < 512; i++)
; i start address is: 28 (R7)
MOVS	R7, #0
; address end address is: 8 (R2)
; i end address is: 28 (R7)
MOV	R6, R2
L_FLASH_EraseWrite24:
; i start address is: 28 (R7)
; address start address is: 24 (R6)
; address start address is: 24 (R6)
; address end address is: 24 (R6)
CMP	R7, #512
IT	CS
BCS	L_FLASH_EraseWrite25
; address end address is: 24 (R6)
;Bootloader_STM32.c,176 :: 		dataToWrite = block[i * 2] | (block[i * 2 + 1] << 8);
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
;Bootloader_STM32.c,177 :: 		FLASH_Write_HalfWord( ( address + i*2 + + FLASH_DEFAULT_ADDR ), dataToWrite);
ADDS	R1, R6, R4
ADD	R1, R1, #134217728
MOV	R0, R1
UXTH	R1, R2
BL	_FLASH_Write_HalfWord+0
;Bootloader_STM32.c,174 :: 		for (i = 0; i < 512; i++)
ADDS	R7, R7, #1
UXTH	R7, R7
;Bootloader_STM32.c,178 :: 		}
; address end address is: 24 (R6)
; i end address is: 28 (R7)
IT	AL
BAL	L_FLASH_EraseWrite24
L_FLASH_EraseWrite25:
;Bootloader_STM32.c,180 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;Bootloader_STM32.c,181 :: 		}
L_end_FLASH_EraseWrite:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _FLASH_EraseWrite
_Write_Begin:
;Bootloader_STM32.c,183 :: 		void Write_Begin()
SUB	SP, SP, #20
STR	LR, [SP, #0]
;Bootloader_STM32.c,192 :: 		arm_m0_inst = 0x4800 + 1;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18433
;Bootloader_STM32.c,194 :: 		appResetVector[0] = arm_m0_inst;
ADD	R2, SP, #4
MOVS	R0, #1
STRB	R0, [R2, #0]
;Bootloader_STM32.c,195 :: 		appResetVector[1] = arm_m0_inst >> 8;
ADDS	R1, R2, #1
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,198 :: 		arm_m0_inst = 0x4685;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18053
;Bootloader_STM32.c,200 :: 		appResetVector[2] = arm_m0_inst;
ADDS	R1, R2, #2
MOVS	R0, #133
STRB	R0, [R1, #0]
;Bootloader_STM32.c,201 :: 		appResetVector[3] = arm_m0_inst >> 8;
ADDS	R1, R2, #3
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,204 :: 		arm_m0_inst = 0x4800 + 1;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18433
;Bootloader_STM32.c,206 :: 		appResetVector[4] = arm_m0_inst;
ADDS	R1, R2, #4
MOVS	R0, #1
STRB	R0, [R1, #0]
;Bootloader_STM32.c,207 :: 		appResetVector[5] = arm_m0_inst >> 8;
ADDS	R1, R2, #5
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,210 :: 		arm_m0_inst = 0x4700;
; arm_m0_inst start address is: 12 (R3)
MOVW	R3, #18176
;Bootloader_STM32.c,211 :: 		appResetVector[6] = arm_m0_inst;
ADDS	R1, R2, #6
MOVS	R0, #0
STRB	R0, [R1, #0]
;Bootloader_STM32.c,212 :: 		appResetVector[7] = arm_m0_inst >> 8;
ADDS	R1, R2, #7
LSRS	R0, R3, #8
; arm_m0_inst end address is: 12 (R3)
STRB	R0, [R1, #0]
;Bootloader_STM32.c,215 :: 		appResetVector[8] = block[0];
ADDW	R1, R2, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,216 :: 		appResetVector[9] = block[1];
ADDW	R1, R2, #9
MOVW	R0, #lo_addr(Bootloader_STM32_block+1)
MOVT	R0, #hi_addr(Bootloader_STM32_block+1)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,217 :: 		appResetVector[10] = block[2];
ADDW	R1, R2, #10
MOVW	R0, #lo_addr(Bootloader_STM32_block+2)
MOVT	R0, #hi_addr(Bootloader_STM32_block+2)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,218 :: 		appResetVector[11] = block[3];
ADDW	R1, R2, #11
MOVW	R0, #lo_addr(Bootloader_STM32_block+3)
MOVT	R0, #hi_addr(Bootloader_STM32_block+3)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,221 :: 		appResetVector[12] = block[4];
ADDW	R1, R2, #12
MOVW	R0, #lo_addr(Bootloader_STM32_block+4)
MOVT	R0, #hi_addr(Bootloader_STM32_block+4)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,222 :: 		appResetVector[13] = block[5];
ADDW	R1, R2, #13
MOVW	R0, #lo_addr(Bootloader_STM32_block+5)
MOVT	R0, #hi_addr(Bootloader_STM32_block+5)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,223 :: 		appResetVector[14] = block[6];
ADDW	R1, R2, #14
MOVW	R0, #lo_addr(Bootloader_STM32_block+6)
MOVT	R0, #hi_addr(Bootloader_STM32_block+6)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,224 :: 		appResetVector[15] = block[7];
ADDW	R1, R2, #15
MOVW	R0, #lo_addr(Bootloader_STM32_block+7)
MOVT	R0, #hi_addr(Bootloader_STM32_block+7)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bootloader_STM32.c,226 :: 		FLASH_Unlock();
BL	_FLASH_Unlock+0
;Bootloader_STM32.c,229 :: 		FLASH_EraseSector(_FLASH_SECTOR_7);
MOV	R0, #56
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,231 :: 		for (i = 0; i < 8; i++)
; i start address is: 24 (R6)
MOVS	R6, #0
; i end address is: 24 (R6)
L_Write_Begin27:
; i start address is: 24 (R6)
CMP	R6, #8
IT	CS
BCS	L_Write_Begin28
;Bootloader_STM32.c,233 :: 		dataToWrite = appResetVector[i * 2] | (appResetVector[i * 2 + 1] << 8);
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
;Bootloader_STM32.c,234 :: 		FLASH_Write_HalfWord( ( START_PROGRAM_ADDR + FLASH_DEFAULT_ADDR + i*2 ), dataToWrite);
MOVW	R0, #0
MOVT	R0, #2054
ADDS	R0, R0, R3
BL	_FLASH_Write_HalfWord+0
;Bootloader_STM32.c,231 :: 		for (i = 0; i < 8; i++)
ADDS	R6, R6, #1
UXTH	R6, R6
;Bootloader_STM32.c,235 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_Write_Begin27
L_Write_Begin28:
;Bootloader_STM32.c,237 :: 		FLASH_Lock();
BL	_FLASH_Lock+0
;Bootloader_STM32.c,239 :: 		ptr = (unsigned long*)0x00000000;
; ptr start address is: 12 (R3)
MOVW	R3, #0
MOVT	R3, #0
;Bootloader_STM32.c,240 :: 		block[0] = LoWord(*ptr);
LDRH	R1, [R3, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,241 :: 		block[1] = LoWord(*ptr) >> 8;
LDRH	R0, [R3, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+1)
MOVT	R0, #hi_addr(Bootloader_STM32_block+1)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,242 :: 		block[2] = HiWord(*ptr);
ADDS	R0, R3, #2
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+2)
MOVT	R0, #hi_addr(Bootloader_STM32_block+2)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,243 :: 		block[3] = HiWord(*ptr) >> 8;
ADDS	R0, R3, #2
LDRH	R0, [R0, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+3)
MOVT	R0, #hi_addr(Bootloader_STM32_block+3)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,245 :: 		ptr++;
ADDS	R2, R3, #4
; ptr end address is: 12 (R3)
;Bootloader_STM32.c,247 :: 		block[4] = LoWord(*ptr);
LDRH	R1, [R2, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+4)
MOVT	R0, #hi_addr(Bootloader_STM32_block+4)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,248 :: 		block[5] = LoWord(*ptr) >> 8;
LDRH	R0, [R2, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+5)
MOVT	R0, #hi_addr(Bootloader_STM32_block+5)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,249 :: 		block[6] = HiWord(*ptr);
ADDS	R0, R2, #2
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(Bootloader_STM32_block+6)
MOVT	R0, #hi_addr(Bootloader_STM32_block+6)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,250 :: 		block[7] = HiWord(*ptr) >> 8;
ADDS	R0, R2, #2
LDRH	R0, [R0, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(Bootloader_STM32_block+7)
MOVT	R0, #hi_addr(Bootloader_STM32_block+7)
STRB	R1, [R0, #0]
;Bootloader_STM32.c,253 :: 		FLASH_EraseSector(_FLASH_SECTOR_0);
MOV	R0, #0
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,254 :: 		FLASH_EraseSector(_FLASH_SECTOR_1);
MOV	R0, #8
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,255 :: 		FLASH_EraseSector(_FLASH_SECTOR_2);
MOV	R0, #16
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,256 :: 		FLASH_EraseSector(_FLASH_SECTOR_3);
MOV	R0, #24
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,257 :: 		FLASH_EraseSector(_FLASH_SECTOR_4);
MOV	R0, #32
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,258 :: 		FLASH_EraseSector(_FLASH_SECTOR_5);
MOV	R0, #40
BL	_FLASH_EraseSector+0
;Bootloader_STM32.c,259 :: 		}
L_end_Write_Begin:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _Write_Begin
_Start_Bootload:
;Bootloader_STM32.c,261 :: 		void Start_Bootload()
SUB	SP, SP, #16
STR	LR, [SP, #0]
;Bootloader_STM32.c,263 :: 		unsigned int i = 0;
MOVW	R0, #0
STRH	R0, [SP, #6]
;Bootloader_STM32.c,265 :: 		long j = 0x0;
MOV	R0, #0
STR	R0, [SP, #8]
MOVW	R0, #0
STRH	R0, [SP, #12]
;Bootloader_STM32.c,266 :: 		int k =0;
;Bootloader_STM32.c,267 :: 		unsigned int fw_size = 0;
;Bootloader_STM32.c,268 :: 		unsigned int curr_fw_size = 0;
;Bootloader_STM32.c,272 :: 		UART_Write('y');
MOVS	R0, #121
BL	_UART_Write+0
;Bootloader_STM32.c,273 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload30:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload31
IT	AL
BAL	L_Start_Bootload30
L_Start_Bootload31:
;Bootloader_STM32.c,275 :: 		yy = UART_Read();
BL	_UART_Read+0
STRB	R0, [SP, #4]
;Bootloader_STM32.c,277 :: 		UART_Write('x');
MOVS	R0, #120
BL	_UART_Write+0
;Bootloader_STM32.c,278 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload32:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload33
IT	AL
BAL	L_Start_Bootload32
L_Start_Bootload33:
;Bootloader_STM32.c,280 :: 		xx = UART_Read();
BL	_UART_Read+0
;Bootloader_STM32.c,282 :: 		fw_size = yy | (xx << 8);
UXTB	R0, R0
LSLS	R1, R0, #8
UXTH	R1, R1
LDRB	R0, [SP, #4]
ORRS	R0, R1
STRH	R0, [SP, #14]
;Bootloader_STM32.c,284 :: 		while (1) {
L_Start_Bootload34:
;Bootloader_STM32.c,285 :: 		if( (i == MAX_BLOCK_SIZE) || ( curr_fw_size >= fw_size ) ) {
LDRH	R0, [SP, #6]
CMP	R0, #1024
IT	EQ
BEQ	L__Start_Bootload59
LDRH	R1, [SP, #14]
LDRH	R0, [SP, #12]
CMP	R0, R1
IT	CS
BCS	L__Start_Bootload58
IT	AL
BAL	L_Start_Bootload38
L__Start_Bootload59:
L__Start_Bootload58:
;Bootloader_STM32.c,287 :: 		if (!j)
LDR	R0, [SP, #8]
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload39
;Bootloader_STM32.c,288 :: 		Write_Begin();
BL	_Write_Begin+0
L_Start_Bootload39:
;Bootloader_STM32.c,289 :: 		if (j < BOOTLOADER_START_ADDR) {
LDR	R0, [SP, #8]
CMP	R0, #262144
IT	GE
BGE	L_Start_Bootload40
;Bootloader_STM32.c,290 :: 		FLASH_EraseWrite(j);
LDR	R0, [SP, #8]
BL	_FLASH_EraseWrite+0
;Bootloader_STM32.c,291 :: 		}
L_Start_Bootload40:
;Bootloader_STM32.c,293 :: 		i = 0;
MOVS	R0, #0
STRH	R0, [SP, #6]
;Bootloader_STM32.c,294 :: 		j += 0x400;
LDR	R0, [SP, #8]
ADD	R0, R0, #1024
STR	R0, [SP, #8]
;Bootloader_STM32.c,296 :: 		for(k=0; k<MAX_BLOCK_SIZE; k++)
; k start address is: 20 (R5)
MOVS	R5, #0
SXTH	R5, R5
; k end address is: 20 (R5)
SXTH	R2, R5
L_Start_Bootload41:
; k start address is: 8 (R2)
CMP	R2, #1024
IT	GE
BGE	L_Start_Bootload42
;Bootloader_STM32.c,298 :: 		block[k] = 0;
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
ADDS	R1, R0, R2
MOVS	R0, #0
STRB	R0, [R1, #0]
;Bootloader_STM32.c,296 :: 		for(k=0; k<MAX_BLOCK_SIZE; k++)
ADDS	R0, R2, #1
; k end address is: 8 (R2)
; k start address is: 20 (R5)
SXTH	R5, R0
;Bootloader_STM32.c,299 :: 		}
SXTH	R2, R5
; k end address is: 20 (R5)
IT	AL
BAL	L_Start_Bootload41
L_Start_Bootload42:
;Bootloader_STM32.c,300 :: 		}
L_Start_Bootload38:
;Bootloader_STM32.c,301 :: 		if( curr_fw_size >= fw_size )
LDRH	R1, [SP, #14]
LDRH	R0, [SP, #12]
CMP	R0, R1
IT	CC
BCC	L_Start_Bootload44
;Bootloader_STM32.c,303 :: 		LED = 1; // OFF PC13
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(ODR13_GPIOC_ODR_bit+0)
MOVT	R0, #hi_addr(ODR13_GPIOC_ODR_bit+0)
_SX	[R0, ByteOffset(ODR13_GPIOC_ODR_bit+0)]
;Bootloader_STM32.c,304 :: 		UART2_Write_Text("UART Firmware Update Done!!!\r\n");
MOVW	R0, #lo_addr(?lstr19_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr19_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,305 :: 		UART2_Write_Text("Jumping to Application!!!\r\n");
MOVW	R0, #lo_addr(?lstr20_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr20_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,306 :: 		Delay_ms(2000);
MOVW	R7, #49833
MOVT	R7, #162
NOP
NOP
L_Start_Bootload45:
SUBS	R7, R7, #1
BNE	L_Start_Bootload45
NOP
NOP
;Bootloader_STM32.c,307 :: 		Start_Program();
BL	393216
;Bootloader_STM32.c,308 :: 		}
L_Start_Bootload44:
;Bootloader_STM32.c,311 :: 		UART_Write('y');
MOVS	R0, #121
BL	_UART_Write+0
;Bootloader_STM32.c,312 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload47:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload48
IT	AL
BAL	L_Start_Bootload47
L_Start_Bootload48:
;Bootloader_STM32.c,314 :: 		yy = UART_Read();
BL	_UART_Read+0
STRB	R0, [SP, #4]
;Bootloader_STM32.c,316 :: 		UART_Write('x');
MOVS	R0, #120
BL	_UART_Write+0
;Bootloader_STM32.c,317 :: 		while (!UART_Data_Ready()) ;
L_Start_Bootload49:
BL	_UART_Data_Ready+0
CMP	R0, #0
IT	NE
BNE	L_Start_Bootload50
IT	AL
BAL	L_Start_Bootload49
L_Start_Bootload50:
;Bootloader_STM32.c,319 :: 		xx = UART_Read();
BL	_UART_Read+0
; xx start address is: 8 (R2)
UXTB	R2, R0
;Bootloader_STM32.c,321 :: 		block[i++] = yy;
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
;Bootloader_STM32.c,322 :: 		block[i++] = xx;
MOVW	R0, #lo_addr(Bootloader_STM32_block+0)
MOVT	R0, #hi_addr(Bootloader_STM32_block+0)
ADDS	R0, R0, R1
STRB	R2, [R0, #0]
; xx end address is: 8 (R2)
LDRH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;Bootloader_STM32.c,324 :: 		curr_fw_size += 2;
LDRH	R0, [SP, #12]
ADDS	R0, R0, #2
STRH	R0, [SP, #12]
;Bootloader_STM32.c,325 :: 		}
IT	AL
BAL	L_Start_Bootload34
;Bootloader_STM32.c,326 :: 		}
L_end_Start_Bootload:
LDR	LR, [SP, #0]
ADD	SP, SP, #16
BX	LR
; end of _Start_Bootload
_main:
;Bootloader_STM32.c,328 :: 		void main()
SUB	SP, SP, #28
;Bootloader_STM32.c,336 :: 		GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_13);
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Digital_Output+0
;Bootloader_STM32.c,337 :: 		UART2_Init(115200);                                        //Debug Print UART
MOV	R0, #115200
BL	_UART2_Init+0
;Bootloader_STM32.c,340 :: 		GPIO_Digital_Output(&GPIOA_BASE,_GPIO_PINMASK_8);          //Chip Select
MOVW	R1, #256
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Digital_Output+0
;Bootloader_STM32.c,341 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_13);        //SPI CLK
MOVW	R1, #8192
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Bootloader_STM32.c,342 :: 		GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_14);         //SPI MISO
MOVW	R1, #16384
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Input+0
;Bootloader_STM32.c,343 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_15);        //SPI MOSI
MOVW	R1, #32768
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Bootloader_STM32.c,345 :: 		UART2_Write_Text("!------Firmware Update using SD Card------!\r\n");
MOVW	R0, #lo_addr(?lstr21_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr21_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,346 :: 		UART2_Write_Text("Initialize SPI...\r\n");
MOVW	R0, #lo_addr(?lstr22_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr22_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,353 :: 		SPI2_Init_Advanced(_SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT |  _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15);
MOVW	R2, #lo_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVT	R2, #hi_addr(__GPIO_MODULE_SPI2_PB13_14_15+0)
MOVW	R1, #772
MOVS	R0, #0
BL	_SPI2_Init_Advanced+0
;Bootloader_STM32.c,356 :: 		timeout.cmd_timeout  = 2000;
MOVW	R0, #2000
STR	R0, [SP, #4]
;Bootloader_STM32.c,357 :: 		timeout.spi_timeout  = 2000;
MOVW	R0, #2000
STR	R0, [SP, #8]
;Bootloader_STM32.c,358 :: 		timeout.init_timeout = 2000;
MOVW	R0, #2000
STR	R0, [SP, #12]
;Bootloader_STM32.c,361 :: 		Mmc_SetTimeoutCallback(&timeout, &Mmc_TimeoutCallback);
ADD	R0, SP, #4
MOVW	R1, #lo_addr(_Mmc_TimeoutCallback+0)
MOVT	R1, #hi_addr(_Mmc_TimeoutCallback+0)
BL	_Mmc_SetTimeoutCallback+0
;Bootloader_STM32.c,364 :: 		UART2_Write_Text("Initialize FAT library...");
MOVW	R0, #lo_addr(?lstr23_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr23_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,366 :: 		i = FAT32_Init();
BL	_FAT32_Init+0
; i start address is: 4 (R1)
SXTB	R1, R0
;Bootloader_STM32.c,367 :: 		if(i != 0)
CMP	R1, #0
IT	EQ
BEQ	L_main51
;Bootloader_STM32.c,369 :: 		char str[10] = {0};
ADD	R11, SP, #16
ADD	R10, R11, #10
MOVW	R12, #lo_addr(?ICSmain_str_L1+0)
MOVT	R12, #hi_addr(?ICSmain_str_L1+0)
BL	___CC2DW+0
;Bootloader_STM32.c,370 :: 		IntToStr(i, str);
ADD	R0, SP, #16
STRH	R1, [SP, #0]
MOV	R1, R0
LDRSH	R0, [SP, #0]
; i end address is: 4 (R1)
BL	_IntToStr+0
;Bootloader_STM32.c,372 :: 		UART2_Write_Text("Error! Err = ");
MOVW	R0, #lo_addr(?lstr24_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr24_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,373 :: 		UART2_Write_Text(str);
ADD	R0, SP, #16
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,374 :: 		UART2_Write_Text("\r\n");
MOVW	R0, #lo_addr(?lstr25_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr25_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,375 :: 		}
IT	AL
BAL	L_main52
L_main51:
;Bootloader_STM32.c,378 :: 		SD_Card_FW_Update();
BL	_SD_Card_FW_Update+0
;Bootloader_STM32.c,379 :: 		}
L_main52:
;Bootloader_STM32.c,383 :: 		UART2_Write_Text("!------Firmware Update using UART------!\r\n");
MOVW	R0, #lo_addr(?lstr26_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr26_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,384 :: 		UART1_Init(115200);
MOV	R0, #115200
BL	_UART1_Init+0
;Bootloader_STM32.c,385 :: 		if(UART_Write_Loop('g','r'))       // Send 'g' for ~5 sec, if 'r'
MOVS	R1, #114
MOVS	R0, #103
BL	_UART_Write_Loop+0
CMP	R0, #0
IT	EQ
BEQ	L_main53
;Bootloader_STM32.c,387 :: 		Start_Bootload();                //   received start bootload
BL	_Start_Bootload+0
;Bootloader_STM32.c,388 :: 		}
IT	AL
BAL	L_main54
L_main53:
;Bootloader_STM32.c,392 :: 		UART2_Write_Text("Jumping to Application!!!\r\n");
MOVW	R0, #lo_addr(?lstr27_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr27_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,393 :: 		Start_Program();                  //   else start program
BL	393216
;Bootloader_STM32.c,394 :: 		}
L_main54:
;Bootloader_STM32.c,396 :: 		UART2_Write_Text("No Application Available...HALT!!!\r\n");
MOVW	R0, #lo_addr(?lstr28_Bootloader_STM32+0)
MOVT	R0, #hi_addr(?lstr28_Bootloader_STM32+0)
BL	_UART2_Write_Text+0
;Bootloader_STM32.c,397 :: 		while(1)
L_main55:
;Bootloader_STM32.c,399 :: 		}
IT	AL
BAL	L_main55
;Bootloader_STM32.c,400 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
