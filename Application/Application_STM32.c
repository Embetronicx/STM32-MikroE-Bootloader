#include <built_in.h>

#define LED_PIN (1<<13)

void main()
{
  GPIO_Digital_Output(&GPIOC_BASE, _GPIO_PINMASK_13); // Set PC13 as digital output

  while(1) {
    GPIOC_ODR |= LED_PIN; // ON PC13
    Delay_ms(1000);
    GPIOC_ODR &= (~LED_PIN); // OFF PC13
    Delay_ms(1000);
  }
}