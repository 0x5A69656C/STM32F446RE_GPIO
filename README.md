# STM32F446RE_GPIO
GPIO driver with a blinky test

To build run the command
```
make
```
To flash the program to your Nucleo-F446RE run
```
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg -c "program STM32F446RE_GPIO.elf verify reset exit"
```
Then in a seperate terminal you can step through the program with
```
arm-none-eabi-gdb STM32F446RE_GPIO.elf
```
Despite the name, this program can easily be made to run for STM32F4xx. However, check the .ld file and consult your microcontroller reference manual to see if your FLASH and SRAM have the same origin and length; if they differ just change this to the starting addresses and lengths of your microcontroller.
