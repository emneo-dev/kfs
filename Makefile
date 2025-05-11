NAME	=	funny

LD	=	riscv64-linux-gnu-ld
AS	=	riscv64-linux-gnu-as

ASFLAGS	=	-g

all: $(NAME)

$(NAME): main.o
	$(LD) -o $(NAME) main.o

clean:
	$(RM) main.o

fclean:
	$(MAKE) clean
	$(RM) $(NAME)