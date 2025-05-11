.global _start

# Linux syscalls map
# https://gpages.juszkiewicz.com.pl/syscalls-table/syscalls.html

# ISA
# https://msyksphinz-self.github.io/riscv-isadoc/html/index.html

.section .text
_start:
    li a0, 1
    la a1, msg
    li a2, 13
    li a7, 0x40
    ecall

    li a0, 0
    li a7, 0x5D
    ecall

.section .rodata
msg:
    .string "Hello, World\n"
