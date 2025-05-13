NAME	=	kernel

CC	=	riscv64-linux-gnu-gcc
LD	=	riscv64-linux-gnu-ld
AS	=	riscv64-linux-gnu-as

CFLAGS	=	-Og -ggdb3 -ffreestanding -Wall -Wextra -mcmodel=medany
ASFLAGS	=	-g

all: $(NAME)

$(NAME): kernel.o entry.o linker.ld
	$(LD) -T linker.ld -o $(NAME) kernel.o entry.o

clean:
	$(RM) kernel.o entry.o

fclean:
	$(MAKE) clean
	$(RM) $(NAME)

re:
	$(MAKE) fclean
	$(MAKE) all
