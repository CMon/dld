COMPILER_PATH=/usr/hitech/picc_9.50PL2
PK2=/usr/local/bin/pk2
CC=$(COMPILER_PATH)/bin/picc

CONFIG=0x3d4
CHIP=16F684
PROGNAME=firmware

SRCS=main.c timer.c nRF_CMD.c xxtea.c

PROG_EXTS=cof hxl map mum sym
PROG_FILES=$(patsubst %, obj/$(PROGNAME).%, $(PROG_EXTS))

OBJ_EXTS=d fi lst rlf sdb
OBJ_TMP=$(foreach T, $(OBJ_EXTS), $(patsubst %.c, obj/%.$(T), $(SRCS)))
OBJ_OUT=$(patsubst %.c, obj/%.obj, $(SRCS))

CLEANS=$(OBJ_OUT) $(OBJ_TMP) $(PROG_FILES)
CLEANS+=obj/startup.as obj/startup.lst obj/startup.rlf obj/$(PROGNAME).hex 

COMMON_FLAGS=--chip=$(CHIP) -g -m --asmlist --codeoffset=0 --warn=0 --errors=1- --char=signed --double=24
CFLAGS=--opt=none $(COMMON_FLAGS) --opt=+9 --opt=+asm --opt=+speed
LDFLAGS=--summary=mem,file $(COMMON_FLAGS) --output=+intel --output=+mcof --runtime=+init --runtime=+osccal --runtime=+clear --runtime=+clib --runtime=+keep

#bugfix for hitech PICC compiler copy protection
#export LC_ALL=C

all: $(PROGNAME).hex

obj/%.obj: src/%.c src/*.h
	$(CC) $(CFLAGS) -c -o$@ $(filter-out %.h,$^)

$(PROGNAME).hex: $(OBJ_OUT)
	$(CC) $(LDFLAGS) -oobj/$@ $^

clean:
	rm -f $(CLEANS)

install: $(PROGNAME).hex
	$(PK2) --device=$(CHIP) --write obj/$(PROGNAME).hex

publish: $(PROGNAME).hex
	cp obj/$(PROGNAME).hex /mnt/Henryk/

verify: $(PROGNAME).hex
	sudo $(PK2) --verify obj/$(PROGNAME).hex

on:
	sudo $(PK2) --on

off:
	sudo $(PK2) --off
