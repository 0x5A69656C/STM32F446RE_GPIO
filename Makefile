TARGET = STM32F446RE_GPIO

CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
SIZE    = arm-none-eabi-size

MCU = -mcpu=cortex-m4 \
      -mthumb \
      -mfpu=fpv4-sp-d16 \
      -mfloat-abi=hard

CFLAGS = $(MCU)
CFLAGS += -Wall
CFLAGS += -g3
CFLAGS += -O0
CFLAGS += --specs=nano.specs
CFLAGS += -ffunction-sections
CFLAGS += -fdata-sections

CFLAGS += -DSTM32F446xx

CFLAGS += -IInc
CFLAGS += -Ichip_headers/CMSIS/Include
CFLAGS += -Ichip_headers/CMSIS/Device/ST/STM32F4xx/Include

LDFLAGS = $(MCU)
LDFLAGS += -Tstm32_ls.ld
LDFLAGS += --specs=nano.specs
LDFLAGS += --specs=nosys.specs
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -Wl,-Map=$(TARGET).map

SRC_C = \
Src/main.c \
Src/gpio.c \
Startup/stm32f446_startup.c \

OBJ = $(SRC_C:.c=.o) $(SRC_S:.s=.o)

all: $(TARGET).elf $(TARGET).bin

$(TARGET).elf: $(OBJ)
	$(CC) $(OBJ) $(LDFLAGS) -o $@
	$(SIZE) $@

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


clean:
	rm -f $(OBJ)
	rm -f $(TARGET).elf
	rm -f $(TARGET).bin
	rm -f $(TARGET).map

.PHONY: all clean
