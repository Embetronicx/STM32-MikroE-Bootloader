#include "built_in.h"

///////////////////////////////////////////////////////////////////////////////
#pragma orgall 0x40000
#define BOOTLOADER_START_ADDR   0x40000
#define START_PROGRAM_ADDR      0x60000
#define FLASH_DEFAULT_ADDR      0x08000000

#define MAX_BLOCK_SIZE          ( 1024 )                  //1KB
#define MAX_APP_SIZE            ( 262144 )                //256KB
#define FIRMWARE_FILE_NAME      "App.bin"

#define UART_FIRMWARE_UPDATE

////////////////////////////////////////////////////////////////////////////////
void Write_Begin();
void FLASH_EraseWrite(unsigned long address);

////////////////////////////////////////////////////////////////////////////////
static char block[MAX_BLOCK_SIZE];

//LED Pin PC13
sbit LED at ODR13_GPIOC_ODR_bit;

////////////////////////////////////////////////////////////////////////////////
void Start_Program() org START_PROGRAM_ADDR
{

}

////////////////////////////////////////////////////////////////////////////////
unsigned short UART_Write_Loop(char send, char receive)
{
  unsigned int rslt = 0;

  while(1)
  {
    LED = 1;       // ON PC13
    Delay_ms(20);
    UART_Write(send);
    LED = 0;       // OFF PC13
    Delay_ms(20);

    rslt++;
    if (rslt == 0x64)           // 100 times
      return 0;
    if(UART_Data_Ready()) {
      if(UART_Read() == receive)
        return 1;
    }
  }
}
////////////////////////////////////////////////////////////////////////////////
void FLASH_EraseWrite(unsigned long address)
{
  unsigned int i = 0;
  unsigned int dataToWrite;

  FLASH_Unlock();

  for (i = 0; i < 512; i++)
  {
    dataToWrite = block[i * 2] | (block[i * 2 + 1] << 8);
    FLASH_Write_HalfWord( ( address + i*2 + + FLASH_DEFAULT_ADDR ), dataToWrite);
  }

  FLASH_Lock();
}
////////////////////////////////////////////////////////////////////////////////
void Write_Begin()
{
  unsigned int i;
  unsigned long* ptr;
  unsigned char appResetVector[16];
  unsigned long arm_m0_inst;
  unsigned int dataToWrite;

  //LDR R0, PC+X
  arm_m0_inst = 0x4800 + 1;

  appResetVector[0] = arm_m0_inst;
  appResetVector[1] = arm_m0_inst >> 8;

  //MOV SP, R0
  arm_m0_inst = 0x4685;

  appResetVector[2] = arm_m0_inst;
  appResetVector[3] = arm_m0_inst >> 8;

  //LDR R0, PC+Y
  arm_m0_inst = 0x4800 + 1;

  appResetVector[4] = arm_m0_inst;
  appResetVector[5] = arm_m0_inst >> 8;

  //BX R0
  arm_m0_inst = 0x4700;
  appResetVector[6] = arm_m0_inst;
  appResetVector[7] = arm_m0_inst >> 8;

  //SP
  appResetVector[8] = block[0];
  appResetVector[9] = block[1];
  appResetVector[10] = block[2];
  appResetVector[11] = block[3];

  //PC
  appResetVector[12] = block[4];
  appResetVector[13] = block[5];
  appResetVector[14] = block[6];
  appResetVector[15] = block[7];

  FLASH_Unlock();

  //Clear the 7th Sector (App Start Point)
  FLASH_EraseSector(_FLASH_SECTOR_7);

  for (i = 0; i < 8; i++)
  {
    dataToWrite = appResetVector[i * 2] | (appResetVector[i * 2 + 1] << 8);
    FLASH_Write_HalfWord( ( START_PROGRAM_ADDR + FLASH_DEFAULT_ADDR + i*2 ), dataToWrite);
  }

  FLASH_Lock();

  ptr = (unsigned long*)0x00000000;
  block[0] = LoWord(*ptr);
  block[1] = LoWord(*ptr) >> 8;
  block[2] = HiWord(*ptr);
  block[3] = HiWord(*ptr) >> 8;

  ptr++;

  block[4] = LoWord(*ptr);
  block[5] = LoWord(*ptr) >> 8;
  block[6] = HiWord(*ptr);
  block[7] = HiWord(*ptr) >> 8;

  //Erase Application area
  FLASH_EraseSector(_FLASH_SECTOR_0);
  FLASH_EraseSector(_FLASH_SECTOR_1);
  FLASH_EraseSector(_FLASH_SECTOR_2);
  FLASH_EraseSector(_FLASH_SECTOR_3);
  FLASH_EraseSector(_FLASH_SECTOR_4);
  FLASH_EraseSector(_FLASH_SECTOR_5);
}
////////////////////////////////////////////////////////////////////////////////
void Start_Bootload()
{
  unsigned int i = 0;
  char xx, yy;
  long j = 0x0;
  int k =0;
  unsigned int fw_size = 0;
  unsigned int curr_fw_size = 0;

  //Get firmware Size
  //--- Ask for yy
  UART_Write('y');
  while (!UART_Data_Ready()) ;
  //--- Read yy
  yy = UART_Read();
  //--- Ask for xx
  UART_Write('x');
  while (!UART_Data_Ready()) ;
  //--- Read xx
  xx = UART_Read();

  fw_size = yy | (xx << 8);

  while (1) {
    if( (i == MAX_BLOCK_SIZE) || ( curr_fw_size >= fw_size ) ) {
      //--- If 256 words (1024 bytes) recieved then write to flash
      if (!j)
        Write_Begin();
      if (j < BOOTLOADER_START_ADDR) {
        FLASH_EraseWrite(j);
      }

      i = 0;
      j += 0x400;

      for(k=0; k<MAX_BLOCK_SIZE; k++)
      {
        block[k] = 0;
      }
    }
    if( curr_fw_size >= fw_size )
    {
      LED = 1; // OFF PC13
      Delay_ms(2000);
      UART2_Write_Text("Jumping to Application!!!\r\n");
      Start_Program();
    }

    //--- Ask for yy
    UART_Write('y');
    while (!UART_Data_Ready()) ;
    //--- Read yy
    yy = UART_Read();
    //--- Ask for xx
    UART_Write('x');
    while (!UART_Data_Ready()) ;
    //--- Read xx
    xx = UART_Read();
    //--- Save xxyy in block[i]
    block[i++] = yy;
    block[i++] = xx;

    curr_fw_size += 2;
  }
}

void main()
{
  int i;

  GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_13);
  UART2_Init(115200);                                        //Debug Print UART

#ifdef UART_FIRMWARE_UPDATE
  UART2_Write_Text("!------Firmware Update using UART------!\r\n");
  UART1_Init(115200);
  if(UART_Write_Loop('g','r'))       // Send 'g' for ~5 sec, if 'r'
  {
    Start_Bootload();                //   received start bootload
  }
  else
#endif   //UART_FIRMWARE_UPDATE
  {
    UART2_Write_Text("Jumping to Application!!!\r\n");
    Start_Program();                  //   else start program
  }

  UART2_Write_Text("No Application Available...HALT!!!\r\n");
  while(1)
  {
  }
}