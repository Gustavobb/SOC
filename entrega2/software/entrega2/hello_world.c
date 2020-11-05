#include <stdio.h>
#include "system.h"
#include <unistd.h>
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"

int n = 0, en, dir;
volatile int edge_capture;
unsigned int idx = 0;

int delay(int n) {
      unsigned int delay = 0 ;
      while(delay < n){
          delay++;
      }
}

void handle_button_interrupts(void* context, alt_u32 id)
{
    volatile int* edge_capture_ptr = (volatile int*) context;
    *edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);

    // 0001 = 1 0010 = 2 0100 = 4 1000 = 8
    n = IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);
    en = n & 0x01;  //ON OFF
    dir = n & 0x02 // DIR
    idx = (n & 0x0C >> 0x02); // VEL
 }

void init_pio()
{
     void* edge_capture_ptr = (void*) &edge_capture;
     IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0xf);
     IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
     alt_irq_register( PIO_1_IRQ, edge_capture_ptr, handle_button_interrupts );
}

//  0001 << 0: 0001
//  0001 << 1: 0010
//  0001 << 2: 0100
//  0001 << 3: 1000
//
//  1000 >> 0: 0001

//  0001 0011 0010

int main(void){
  unsigned int st = 0;
  unsigned int vel[4] = { 50000, 30000, 20000, 10000 };

  init_pio();
  n = 0;

  while(1) {
      
	  if (en) {
		  if (st <= 3){
			  if(dir) IOWR_32DIRECT(PIO_2_BASE, 0, 0x08 >> st++);
			  else IOWR_32DIRECT(PIO_2_BASE, 0, 0x01 << st++);
			  usleep(vel[idx]);
		  }
		  else st = 0;
	  }
   }

  return 0;
}
