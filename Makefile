PPC = X:/SysGCC/powerpc-eabi
PRJTDIR = $(shell pwd)
SRC = $(PRJTDIR)/src

BINUTILPREFIX = powerpc-eabi-

PROGRAM = staminaHP
LSCRIPT = setstart.x

#binutils
GCC = $(PPC)/bin/$(BINUTILPREFIX)gcc-4.9.0.exe
AS = $(PPC)/bin/$(BINUTILPREFIX)as.exe
LD = $(PPC)/bin/$(BINUTILPREFIX)ld.exe
OBJCOPY = $(PPC)/bin/$(BINUTILPREFIX)objcopy.exe
NM = $(PPC)/bin/$(BINUTILPREFIX)nm.exe
OBJDUMP =  $(PPC)/bin/$(BINUTILPREFIX)objdump.exe

#Flags
NMFLAGS =  -p -nSC
DISFLAGS = -d
ASFLAGS = -g 
CFLAGS = -Os -fno-exceptions -fomit-frame-pointer
LDFLAGS = -T $(LSCRIPT)

clean:
	-rm -f $(SRC)/$(PROGRAM).o
	-rm -f $(SRC)/$(PROGRAM).s
	-rm -f $(SRC)/$(PROGRAM).bin
	-rm -f $(SRC)/$(PROGRAM).elf
	-rm -f $(SRC)/$(PROGRAM).syms

disasm: $(SRC)/$(PROGRAM).o
	$(OBJDUMP) $(DISFLAGS) $(SRC)/$(PROGRAM).o

bin: link
	$(OBJCOPY) $(SRC)/$(PROGRAM).elf $(SRC)/$(PROGRAM).bin -O binary

link: obj
	$(LD) $(LDFLAGS) -o $(SRC)/$(PROGRAM).elf $(SRC)/$(PROGRAM).o
	$(NM) $(NMFLAGS)  $(SRC)/$(PROGRAM).elf > $(SRC)/$(PROGRAM).syms

obj: asm
	$(AS) $(ASFLAGS) $(SRC)/$(PROGRAM).s -o $(SRC)/$(PROGRAM).o 

asm: $(SRC)/$(PROGRAM).c
	$(GCC) $(CFLAGS) -S $(SRC)/$(PROGRAM).c -o $(SRC)/$(PROGRAM).s
	
pwdd:
	echo $(SRC)
