#
TARGET = hps_gpio
ALT_DEVICE_FAMILY ?= soc_cv_av
SOCEDS_ROOT ?= $(SOCEDS_DEST_ROOT)
HWLIBS_ROOT = $(SOCEDS_ROOT)/ip/altera/hps/altera_hps/hwlib
CROSS_COMPILE = arm-linux-gnueabihf-
CFLAGS = -g -Wall   -D$(ALT_DEVICE_FAMILY) -I$(HWLIBS_ROOT)/include/$(ALT_DEVICE_FAMILY)   -I$(HWLIBS_ROOT)/include/
LDFLAGS =  -g -Wall 
CC = $(CROSS_COMPILE)gcc
ARCH= arm
IP_TARGET=192.168.0.114
IP_LOCAL=192.168.1.11

build: $(TARGET)

$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@ 

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: 
	ssh -t root@$(IP_TARGET) ./hps_gpio

debug:
	ssh -t root@$(IP_TARGET) gdbserver $(IP_LOCAL):100 hps_gpio
	echo target remote 192.168.0.164:100 | gdb -q hps_gpio

deploy:
	scp hps_gpio root@$(IP_TARGET):/home/root

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~