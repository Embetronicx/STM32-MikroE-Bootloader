#line 1 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Bootloader/Bootloader_STM32.c"
#line 1 "c:/mikroe/mikroc pro for arm/include/built_in.h"
#pragma orgall 0x40000
#line 17 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Bootloader/Bootloader_STM32.c"
void Write_Begin();
void FLASH_EraseWrite(unsigned long address);


static char block[ ( 1024 ) ];
#line 1 "c:/mikroe/mikroc pro for arm/packages/fat32 library/uses/__lib_fat32.h"
#line 1 "c:/mikroe/mikroc pro for arm/include/stdint.h"





typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;
typedef signed long long int64_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;
typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;
typedef signed long long int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;
typedef unsigned long long uint_least64_t;



typedef signed long int int_fast8_t;
typedef signed long int int_fast16_t;
typedef signed long int int_fast32_t;
typedef signed long long int_fast64_t;


typedef unsigned long int uint_fast8_t;
typedef unsigned long int uint_fast16_t;
typedef unsigned long int uint_fast32_t;
typedef unsigned long long uint_fast64_t;


typedef signed long int intptr_t;
typedef unsigned long int uintptr_t;


typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
#line 30 "c:/mikroe/mikroc pro for arm/packages/fat32 library/uses/__lib_fat32.h"
static const uint16_t SECTOR_SIZE = 512;









static const uint8_t
 FILE_READ = 0x01,
 FILE_WRITE = 0x02,
 FILE_APPEND = 0x04;






static const uint8_t
 ATTR_NONE = 0x00,
 ATTR_READ_ONLY = 0x01,
 ATTR_HIDDEN = 0x02,
 ATTR_SYSTEM = 0x04,
 ATTR_VOLUME_ID = 0x08,
 ATTR_DIRECTORY = 0x10,
 ATTR_ARCHIVE = 0x20,
 ATTR_DEVICE = 0x40,

 ATTR_RESERVED = 0x80;

static const uint8_t
 ATTR_LONG_NAME = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID;

static const uint8_t
 ATTR_FILE_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_ARCHIVE,

 ATTR_LONG_NAME_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID |
 ATTR_DIRECTORY |
 ATTR_ARCHIVE;






static const int8_t



 OK = 0,
 ERROR = -1,
 FOUND = 1,



 E_READ = -1,
 E_WRITE = -2,
 E_INIT_CARD = -3,
 E_BOOT_SIGN = -4,
 E_BOOT_REC = -5,
 E_FILE_SYS_INFO = -6,
 E_DEVICE_SIZE = -7,
 E_FAT_TYPE = -8,
 E_VOLUME_LABEL = -9,



 E_LAST_ENTRY = -10,
 E_FREE_ENTRY = -11,
 E_CLUST_NUM = -12,
 E_NO_SWAP_SPACE = -13,
 E_NO_SPACE = -14,
 E_LAST_CLUST = -15,



 E_DIR_NAME = -20,
 E_ISNT_DIR = -21,
 E_DIR_EXISTS = -22,
 E_DIR_NOTFOUND = -23,
 E_DIR_NOTEMPTY = -24,
 E_DIR_SIZE = -25,



 E_FILE_NAME = -30,
 E_ISNT_FILE = -31,
 E_FILE_EXISTS = -32,
 E_FILE_NOTFOUND = -33,
 E_FILE_NOTEMPTY = -34,
 E_MAX_FILES = -35,
 E_FILE_NOTOPENED = -36,
 E_FILE_EOF = -37,
 E_FILE_READ = -38,
 E_FILE_WRITE = -39,
 E_FILE_HANDLE = -40,
 E_FILE_READ_ONLY = -41,
 E_FILE_OPENED = -42,



 E_TIME_YEAR = -50,
 E_TIME_MONTH = -51,
 E_TIME_DAY = -52,
 E_TIME_HOUR = -53,
 E_TIME_MINUTE = -54,
 E_TIME_SECOND = -55,



 E_NAME_NULL = -60,
 E_CHAR_UNALLOWED = -61,
 E_LFN_ORD = -62,
 E_LFN_CHK = -63,
 E_LFN_ATTR = -64,
 E_LFN_MAX_SINONIM = -65,
 E_NAME_TOLONG = -66,
 E_NAME_EXIST = -67,



 E_PARAM = -80,
 E_REAPCK = -81,
 E_DELETE = -82,
 E_DELETE_NUM = -83,
 E_ATTR = -84;



typedef struct
{
 uint8_t State[1];
 uint8_t __1[3];
 uint8_t Type[1];
 uint8_t __2[3];
 uint8_t Boot[4];
 uint8_t Size[4];
}
FAT32_PART;



typedef struct
{
 uint8_t __1[446];
 FAT32_PART Part[4];
 uint8_t BootSign[2];
}
FAT32_MBR;



typedef struct
{
 uint8_t JmpCode[3];
 uint8_t __1[8];
 uint8_t BytesPSect[2];
 uint8_t SectsPClust[1];
 uint8_t Reserved[2];
 uint8_t FATCopies[1];
 uint8_t RootEntries[2];
 uint8_t __2[2];
 uint8_t MediaDesc[1];
 uint8_t __3[10];
 uint8_t Sects[4];
 uint8_t SectsPFAT[4];
 uint8_t Flags[2];
 uint8_t __4[2];
 uint8_t RootClust[4];
 uint8_t FSISect[2];
 uint8_t BootBackup[2];
 uint8_t __5[14];
 uint8_t ExtSign[1];
 uint8_t __6[4];
 uint8_t VolName[11];
 uint8_t FATName[8];
 uint8_t __7[420];
 uint8_t BootSign[2];
}
FAT32_BR;



typedef struct
{
 uint8_t LeadSig[4];
 uint8_t __1[480];
 uint8_t StrucSig[4];
 uint8_t FreeCount[4];
 uint8_t NextFree[4];
 uint8_t __2[14];
 uint8_t TrailSig[2];
}
FAT32_FSI;


typedef struct
{
 uint8_t Entry[4];
}
FAT32_FATENT;



typedef struct
{
 uint8_t NameExt[11];
 uint8_t Attrib[1];
 uint8_t NT[1];
 uint8_t __1[1];
 uint8_t CTime[2];
 uint8_t CDate[2];
 uint8_t ATime[2];
 uint8_t HiClust[2];
 uint8_t MTime[2];
 uint8_t MDate[2];
 uint8_t LoClust[2];
 uint8_t Size[4];
}
FAT32_DIRENT;



typedef struct
{
 uint8_t OrdField[1];
 uint8_t UC0[2];
 uint8_t UC1[2];
 uint8_t UC2[2];
 uint8_t UC3[2];
 uint8_t UC4[2];
 uint8_t Attrib[1];
 uint8_t __1[1];
 uint8_t Checksum[1];
 uint8_t UC5[2];
 uint8_t UC6[2];
 uint8_t UC7[2];
 uint8_t UC8[2];
 uint8_t UC9[2];
 uint8_t UC10[2];
 uint8_t __2[2];
 uint8_t UC11[2];
 uint8_t UC12[2];
}
FAT32_LFNENT;



typedef uint32_t __CLUSTER;
typedef uint32_t __SECTOR;
typedef uint32_t __ENTRY;

typedef int8_t __HANDLE;



typedef struct
{
 uint16_t Year;
 uint8_t Month;
 uint8_t Day;
 uint8_t Hour;
 uint8_t Minute;
 uint8_t Second;
}
__TIME;



typedef struct
{
 uint8_t State;
 uint8_t Type;
 __SECTOR Boot;
 uint32_t Size;
}
__PART;



typedef struct
{
 __PART Part[1];
 uint16_t BytesPSect;
 uint8_t SectsPClust;
 uint16_t Reserved;
 uint8_t FATCopies;
 uint32_t SectsPFAT;
 uint16_t Flags;
 __SECTOR FAT;
 __CLUSTER Root;
 uint16_t RootEntries;
 __SECTOR Data;
 __SECTOR FSI;
 uint32_t ClFreeCount;
 __CLUSTER ClNextFree;
}
__INFO;

typedef struct
{
 char Path[270];
 uint16_t Length;
}
__PATH;


typedef struct
{
 char NameExt[255];
 uint8_t Attrib;

 uint32_t Size;
 __CLUSTER _1stClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;
}
__DIR;


typedef struct
{
 __CLUSTER _1stClust;
 __CLUSTER CurrClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;

 uint32_t Cursor;
 uint32_t Length;

 uint8_t Mode;
 uint8_t Attr;
}
__FILE;
#line 381 "c:/mikroe/mikroc pro for arm/packages/fat32 library/uses/__lib_fat32.h"
typedef struct
{
 __SECTOR fSectNum;
 char fSect[SECTOR_SIZE];
}
__RAW_SECTOR;


extern const char CRLF_F32[];
extern const uint8_t FAT32_MAX_FILES;
extern const uint8_t f32_fsi_template[SECTOR_SIZE];
extern const uint8_t f32_br_template[SECTOR_SIZE];
extern __FILE fat32_fdesc[];
extern __RAW_SECTOR f32_sector;


extern int8_t FAT32_Dev_Init (void);
extern int8_t FAT32_Dev_Read_Sector (__SECTOR sc, char* buf);
extern int8_t FAT32_Dev_Write_Sector (__SECTOR sc, char* buf);
extern int8_t FAT32_Dev_Multi_Read_Stop();
extern int8_t FAT32_Dev_Multi_Read_Sector(char* buf);
extern int8_t FAT32_Dev_Multi_Read_Start(__SECTOR sc);
extern int8_t FAT32_Put_Char (char ch);


int8_t FAT32_Init (void);
int8_t FAT32_Format (char *devLabel);
int8_t FAT32_ScanDisk (uint32_t *totClust, uint32_t *freeClust, uint32_t *badClust);
int8_t FAT32_GetFreeSpace(uint32_t *freeClusts, uint16_t *bytesPerClust);

int8_t FAT32_ChangeDir (char *dname);
int8_t FAT32_MakeDir (char *dname);
int8_t FAT32_Dir (void);
int8_t FAT32_FindFirst (__DIR *pDE);
int8_t FAT32_FindNext (__DIR *pDE);
int8_t FAT32_Delete (char *fn);
int8_t FAT32_DeleteRec (char *fn);
int8_t FAT32_Exists (char *name);
int8_t FAT32_Rename (char *oldName, char *newName);
int8_t FAT32_Open (char *fn, uint8_t mode);
int8_t FAT32_Eof (__HANDLE fHandle);
int8_t FAT32_Read (__HANDLE fHandle, char* rdBuf, uint16_t len);
int8_t FAT32_Write (__HANDLE fHandle, char* wrBuf, uint16_t len);
int8_t FAT32_Seek (__HANDLE fHandle, uint32_t pos);
int8_t FAT32_Tell (__HANDLE fHandle, uint32_t *pPos);
int8_t FAT32_Close (__HANDLE fHandle);
int8_t FAT32_Size (char *fname, uint32_t *pSize);
int8_t FAT32_GetFileHandle(char *fname, __HANDLE *handle);

int8_t FAT32_SetTime (__TIME *pTM);
int8_t FAT32_IncTime (uint32_t Sec);

int8_t FAT32_GetCTime (char *fname, __TIME *pTM);
int8_t FAT32_GetMTime (char *fname, __TIME *pTM);

int8_t FAT32_SetAttr (char *fname, uint8_t attr);
int8_t FAT32_GetAttr (char *fname, uint8_t* attr);

int8_t FAT32_GetError (void);

int8_t FAT32_MakeSwap (char *name, __SECTOR nSc, __CLUSTER *pCl);
int8_t FAT32_ReadSwap (__HANDLE fHandle, char* rdBuf, uint16_t len);
int8_t FAT32_WriteSwap (__HANDLE fHandle, char* wrBuf, uint16_t len);
int8_t FAT32_SeekSwap (__HANDLE fHandle, uint32_t pos);

const char* FAT32_getVersion();
uint8_t* FAT32_GetCurrentPath( void );

__CLUSTER FAT32_SectToClust(__SECTOR sc);
__SECTOR FAT32_ClustToSect(__CLUSTER cl);
#line 1 "c:/mikroe/mikroc pro for arm/uses/st m4/__lib_mmc.h"

typedef struct
{
 unsigned long cmd_timeout;
 unsigned long spi_timeout;
 unsigned long init_timeout;
} Mmc_Timeout_Values;
#line 28 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Bootloader/Bootloader_STM32.c"
sbit Mmc_Chip_Select at GPIOA_ODR.B8;

__HANDLE fileHandle;




sbit LED at ODR13_GPIOC_ODR_bit;


void Start_Program() org  0x60000 
{

}


void Mmc_TimeoutCallback(char errorCode) {

 if (errorCode == _MMC_INIT_TIMEOUT) {
 UART2_Write_Text("INIT TIMEOUT!!!\r\n");
 }


 if (errorCode == _MMC_CMD_TIMEOUT) {
 UART2_Write_Text("READ TIMEOUT!!!\r\n");
 }


 if (errorCode == _MMC_SPI_TIMEOUT) {
 UART2_Write_Text("SPI TIMEOUT!!!\r\n");
 }
}



void SD_Card_FW_Update( void )
{
 uint32_t size;
 char str[10] = {0};
 uint32_t temp_size = 0;
 uint32_t read_size = 0;
 int del_file = 0;

 UART2_Write_Text("Ok\r\nFiles available in the SD Card:");


 UART_Set_Active(&UART2_Read, &UART2_Write, &UART2_Data_Ready, &UART2_Tx_Idle);
 FAT32_Dir();
 UART_Write( 0x0D );


 UART2_Write_Text("Open Firmware file... ");
 fileHandle = FAT32_Open( "Application_STM32.bin" , FILE_READ);
 if(fileHandle != 0) {
 UART2_Write_Text("No Firmware File Found!!!\r\n");
 }
 else {
 UART2_Write_Text("OK\r\n");
 FAT32_Size( "Application_STM32.bin" , &size);
 IntToStr(size, str);
 UART2_Write_Text("Firmware File Size = ");
 UART2_Write_Text(str);
 UART2_Write_Text("\r\n");
 if( size <=  ( 262144 )  ) {
 if( size > 0 ) {
 while( temp_size < size ) {
 if( ( size - temp_size ) >  ( 1024 )  ) {
 read_size =  ( 1024 ) ;
 }
 else {
 read_size = ( size - temp_size );
 }

 IntToStr(read_size, str);
 UART2_Write_Text("Read Block Size = ");
 UART2_Write_Text(str);
 UART2_Write_Text("\r\n");

 FAT32_Read(fileHandle, block, read_size);

 if( temp_size == 0 ) {

 Write_Begin();
 }
 if(temp_size <  0x40000 ) {
 FLASH_EraseWrite(temp_size);
 }

 temp_size += read_size;


 memset( block, 0,  ( 1024 )  );
 }
 UART2_Write_Text("SD Card Firmware Update Done!!!\r\n");

 del_file = 1;
 }
 }
 else {
 UART2_Write_Text("App size is maximum, Can't Process...\r\n");
 }

 FAT32_Close(fileHandle);

 if( del_file == 1 ) {
 UART2_Write_Text("Deleting the Firmware File!!!\r\n");

 FAT32_Delete( "Application_STM32.bin" );
 }
 }
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
 {
 UART2_Write_Text("No data received from UART!!!\r\n");
 return 0;
 }
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
 UART2_Write_Text("UART Firmware Update Done!!!\r\n");
 UART2_Write_Text("Jumping to Application!!!\r\n");
 Delay_ms(2000);
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

 Mmc_Timeout_Values timeout;



 GPIO_Digital_Output(&GPIOC_BASE,_GPIO_PINMASK_13);
 UART2_Init(115200);


 GPIO_Digital_Output(&GPIOA_BASE,_GPIO_PINMASK_8);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_13);
 GPIO_Digital_Input(&GPIOB_BASE, _GPIO_PINMASK_14);
 GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_15);

 UART2_Write_Text("!------Firmware Update using SD Card------!\r\n");
 UART2_Write_Text("Initialize SPI...\r\n");






 SPI2_Init_Advanced(_SPI_FPCLK_DIV2, _SPI_MASTER | _SPI_8_BIT | _SPI_CLK_IDLE_LOW | _SPI_FIRST_CLK_EDGE_TRANSITION | _SPI_MSB_FIRST | _SPI_SS_DISABLE | _SPI_SSM_ENABLE | _SPI_SSI_1, &_GPIO_MODULE_SPI2_PB13_14_15);


 timeout.cmd_timeout = 2000;
 timeout.spi_timeout = 2000;
 timeout.init_timeout = 2000;


 Mmc_SetTimeoutCallback(&timeout, &Mmc_TimeoutCallback);


 UART2_Write_Text("Initialize FAT library...");

 i = FAT32_Init();
 if(i != 0)
 {
 char str[10] = {0};
 IntToStr(i, str);

 UART2_Write_Text("Error! Err = ");
 UART2_Write_Text(str);
 UART2_Write_Text("\r\n");
 }
 else
 {
 SD_Card_FW_Update();
 }



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
