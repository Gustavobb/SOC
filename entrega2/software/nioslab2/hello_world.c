#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

int delay(int n){
      unsigned int delay = 0 ;
      while(delay < n){
          delay++;
      }
}

int main(void){
  unsigned int st = 0;

  printf("Embarcados++ \n");

  while(1){
      if (st <= 5){
          IOWR_32DIRECT(PIO_2_BASE, 0, 0x01 << st++);
          usleep(50000);
      }
      else{
          st = 0;
      }
  };

  return 0;
}
