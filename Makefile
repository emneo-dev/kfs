NAME	=	kernel.elf

CROSS_COMPILE	?=	riscv64-linux-gnu-

BUILD_DIR	?=	build

CC	:=	$(CROSS_COMPILE)gcc
LD	:=	$(CROSS_COMPILE)ld
AS	:=	$(CROSS_COMPILE)as
CPP	:=	$(CC) -E
AR	:=	$(CROSS_COMPILE)ar
NM	:=	$(CROSS_COMPILE)nm
STRIP	:=	$(CROSS_COMPILE)strip
OBJCOPY	:=	$(CROSS_COMPILE)objcopy
OBJDUMP	:=	$(CROSS_COMPILE)objdump

CFLAGS	:=	-ffreestanding -Wall -Wextra -mcmodel=medany -std=c11 -Wundef \
			-Wstrict-prototypes -Wno-trigraphs \
			-fno-strict-aliasing -fno-common \
			-Werror-implicit-function-declaration
ASFLAGS	:=

ifeq ($(DEBUG), 1)
CFLAGS	+=	-ggdb3
ASFLAGS	+=	-g

ifeq ($(OPTIMIZATION), 1)
CFLAGS	+=	-Og
endif
else
ifeq ($(OPTIMIZATION), 1)
CFLAGS	+=	-O2
endif
endif

C_SRC	:=	kernel.c
AS_SRC	:=	entry.s utils.s
SRC	:=	$(C_SRC) $(AS_SRC)

OBJ	:=	$(patsubst %,build/%.o,$(SRC))

all: $(NAME)

$(NAME): $(BUILD_DIR)/$(NAME)
	cp $(BUILD_DIR)/$(NAME) $(NAME)

$(BUILD_DIR)/$(NAME): $(OBJ) linker.ld
	$(LD) -T linker.ld -o $(BUILD_DIR)/$(NAME) $(OBJ)

$(BUILD_DIR)/%.c.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.s.o: %.s
	@mkdir -p $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

clean:
	$(RM) -r $(BUILD_DIR)

fclean:
	$(MAKE) clean
	$(RM) $(NAME)

re:
	$(MAKE) fclean
	$(MAKE) all

run: $(NAME)
	qemu-system-riscv64 -machine virt -bios none -kernel $(NAME) -serial mon:stdio
