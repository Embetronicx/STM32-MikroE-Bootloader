#line 1 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Application/Application_STM32.c"
#line 1 "c:/mikroe/mikroc pro for arm/include/built_in.h"
#line 5 "D:/EmbeTronicX/Git_Repo/STM32-MikroE-Bootloader/Application/Application_STM32.c"
void main()
{
 GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13);

 while(1) {
 GPIOC_ODR |=  (1<<13) ;
 Delay_ms(1000);
 GPIOC_ODR &= (~ (1<<13) );
 Delay_ms(1000);
 }
}
