#Paths

PPC = X:/SysGCC/powerpc-eabi
PRJTDIR = $(shell pwd)
SRC = $(PRJTDIR)/src
OUT = $(PRJTDIR)/output
BINUTILPREFIX = powerpc-eabi-

#Files
PROGRAM = staminaHP
LSCRIPT = setstart.x

#Bin-Utils
GCC = $(PPC)/bin/$(BINUTILPREFIX)gcc-4.9.0
AS = $(PPC)/bin/$(BINUTILPREFIX)as
LD = $(PPC)/bin/$(BINUTILPREFIX)ld
OBJCOPY = $(PPC)/bin/$(BINUTILPREFIX)objcopy
NM = $(PPC)/bin/$(BINUTILPREFIX)nm
OBJDUMP =  $(PPC)/bin/$(BINUTILPREFIX)objdump

#Flags
NMFLAGS =  -p -nSC
DISFLAGS = -d
ASFLAGS = -g 
CFLAGS = -Os -fno-exceptions -fomit-frame-pointer
LDFLAGS = -T $(LSCRIPT)

clean:
	-rm -f $(OUT)/$(PROGRAM).o
	-rm -f $(OUT)/$(PROGRAM).s
	-rm -f $(OUT)/$(PROGRAM).bin
	-rm -f $(OUT)/$(PROGRAM).elf
	-rm -f $(OUT)/$(PROGRAM).syms

disasm: $(OUT)/$(PROGRAM).o
	$(OBJDUMP) $(DISFLAGS) $(OUT)/$(PROGRAM).o

bin: link
	$(OBJCOPY) $(OUT)/$(PROGRAM).elf $(OUT)/$(PROGRAM).bin -O binary

link: obj
	$(LD) $(LDFLAGS) -o $(OUT)/$(PROGRAM).elf $(OUT)/$(PROGRAM).o
	$(NM) $(NMFLAGS)  $(OUT)/$(PROGRAM).elf > $(OUT)/$(PROGRAM).syms

obj: asm
	$(AS) $(ASFLAGS) $(OUT)/$(PROGRAM).s -o $(OUT)/$(PROGRAM).o 

asm: $(SRC)/$(PROGRAM).c
	$(GCC) $(CFLAGS) -S $(SRC)/$(PROGRAM).c -o $(OUT)/$(PROGRAM).s
