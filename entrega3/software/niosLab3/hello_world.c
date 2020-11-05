#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

//#define SIM

// LED Peripheral
#define REG_DATA_OFFSET 1

int delay(int n){
      unsigned int delay = 0 ;
      while(delay < n){
          delay++;
      }
}

int main(void){
  unsigned int led = 0;
  unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_0_BASE;

  printf("Embarcados++ \n");

  while(1){
      if (led < 4){
          *(p_led+REG_DATA_OFFSET) = (0x1 << led++);
          printf("Embarcados++ \n");

		printf('%x, *(p_led+REG_DATA_OFFSET)');

          delay(500000); // remover durante a simula����o
      }
      else{
          led = 0;
      }
  };

  return 0;
}
