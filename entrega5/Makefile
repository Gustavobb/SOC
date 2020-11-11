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
IP_TARGET=192.168.0.135
IP_LOCAL=192.168.1.11
PASS=1234

build: $(TARGET)

$(TARGET): main.o 
	$(CC) $(LDFLAGS)   $^ -o $@ 

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

run: 
	@ssh -t root@$(IP_TARGET) "./hps_gpio & python3 server.py"

deploy:
	@sshpass -p $(PASS) scp -r main.c server.py Makefile hps_gpio templates/ root@$(IP_TARGET):/root 

.PHONY: clean
clean:
	rm -f $(TARGET) *.a *.o *~