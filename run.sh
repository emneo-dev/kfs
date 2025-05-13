#!/usr/bin/env sh

make
qemu-system-riscv64 -machine virt -bios none -kernel kernel.elf -serial mon:stdio
