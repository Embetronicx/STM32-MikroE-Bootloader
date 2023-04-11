#line 1 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Bootloader/Bootloader_STM32.c"
#line 1 "c:/mikroe/mikroc pro for arm/include/built_in.h"
#pragma orgall 0x40000
#line 16 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Bootloader/Bootloader_STM32.c"
void Write_Begin();
void FLASH_EraseWrite(unsigned long address);


static char block[ ( 1024 ) ];


sbit LED at ODR13_GPIOC_ODR_bit;


void Start_Program() org  0x60000 
{

}


unsigned short UART_Write_Loop(char send, char receive)
{
 unsigned int rslt = 0;

 while(1)
 {
 LED = 1;
 Delay_ms(20);
 UART_Write(send);
 LED = 0;
 Delay_ms(20);

 rslt++;
 if (rslt == 0x64)
 return 0;
 if(UART_Data_Ready()) {
 if(UART_Read() == receive)
 return 1;
 }
 }
}

void FLASH_EraseWrite(unsigned long address)
{
 unsigned int i = 0;
 unsigned int dataToWrite;

 FLASH_Unlock();

 for (i = 0; i < 512; i++)
 {
 dataToWrite = block[i * 2] | (block[i * 2 + 1] << 8);
 FLASH_Write_HalfWord( ( address + i*2 + +  0x08000000  ), dataToWrite);
 }

 FLASH_Lock();
}

void Write_Begin()
{
 unsigned int i;
 unsigned long* ptr;
 unsigned char appResetVector[16];
 unsigned long arm_m0_inst;
 unsigned int dataToWrite;


 arm_m0_inst = 0x4800 + 1;

 appResetVector[0] = arm_m0_inst;
 appResetVector[1] = arm_m0_inst >> 8;


 arm_m0_inst = 0x4685;

 appResetVector[2] = arm_m0_inst;
 appResetVector[3] = arm_m0_inst >> 8;


 arm_m0_inst = 0x4800 + 1;

 appResetVector[4] = arm_m0_inst;
 appResetVector[5] = arm_m0_inst >> 8;


 arm_m0_inst = 0x4700;
 appResetVector[6] = arm_m0_inst;
 appResetVector[7] = arm_m0_inst >> 8;


 appResetVector[8] = block[0];
 appResetVector[9] = block[1];
 appResetVector[10] = block[2];
 appResetVector[11] = block[3];


 appResetVector[12] = block[4];
 appResetVector[13] = block[5];
 appResetVector[14] = block[6];
 appResetVector[15] = block[7];

 FLASH_Unlock();


 FLASH_EraseSector(_FLASH_SECTOR_7);

 for (i = 0; i < 8; i++)
 {
 dataToWrite = appResetVector[i * 2] | (appResetVector[i * 2 + 1] << 8);
 FLASH_Write_HalfWord( (  0x60000  +  0x08000000  + i*2 ), dataToWrite);
 }

 FLASH_Lock();

 ptr = (unsigned long*)0x00000000;
 block[0] =  ((unsigned *)&*ptr)[0] ;
 block[1] =  ((unsigned *)&*ptr)[0]  >> 8;
 block[2] =  ((unsigned *)&*ptr)[1] ;
 block[3] =  ((unsigned *)&*ptr)[1]  >> 8;

 ptr++;

 block[4] =  ((unsigned *)&*ptr)[0] ;
 block[5] =  ((unsigned *)&*ptr)[0]  >> 8;
 block[6] =  ((unsigned *)&*ptr)[1] ;
 block[7] =  ((unsigned *)&*ptr)[1]  >> 8;


 FLASH_EraseSector(_FLASH_SECTOR_0);
 FLASH_EraseSector(_FLASH_SECTOR_1);
 FLASH_EraseSector(_FLASH_SECTOR_2);
 FLASH_EraseSector(_FLASH_SECTOR_3);
 FLASH_EraseSector(_FLASH_SECTOR_4);
 FLASH_EraseSector(_FLASH_SECTOR_5);
}

void Start_Bootload()
{
 unsigned int i = 0;
 char xx, yy;
 long j = 0x0;
 int k =0;
 unsigned int fw_size = 0;
 unsigned int curr_fw_size = 0;



 UART_Write('y');
 while (!UART_Data_Ready()) ;

 yy = UART_Read();

 UART_Write('x');
 while (!UART_Data_Ready()) ;

 xx = UART_Read();

 fw_size = yy | (xx << 8);

 while (1) {
 if( (i ==  ( 1024 ) ) || ( curr_fw_size >= fw_size ) ) {

 if (!j)
 Write_Begin();
 if (j <  0x40000 ) {
 FLASH_EraseWrite(j);
 }

 i = 0;
 j += 0x400;

 for(k=0; k< ( 1024 ) ; k++)
 {
 block[k] = 0;
 }
 }
 if( curr_fw_size >= fw_size )
 {
 LED = 1;
 Delay_ms(2000);
 UART2_Write_Text("Jumping to Application!!!\r\n");
 Start_Program();
 }


 UART_Write('y');
 while (!UART_Data_Ready()) ;

 yy = UART_Read();

 UART_Write('x');
 while (!UART_Data_Ready()) ;

 xx = UART_Read();

 block[i++] = yy;
 block[i++] = xx;

 curr_fw_size += 2;
 }
}

void main()
{
 int i;

 GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_13);
 UART2_Init(115200);


 UART2_Write_Text("!------Firmware Update using UART------!\r\n");
 UART1_Init(115200);
 if(UART_Write_Loop('g','r'))
 {
 Start_Bootload();
 }
 else

 {
 UART2_Write_Text("Jumping to Application!!!\r\n");
 Start_Program();
 }

 UART2_Write_Text("No Application Available...HALT!!!\r\n");
 while(1)
 {
 }
}
