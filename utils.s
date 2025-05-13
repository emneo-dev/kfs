.global hang

hang:
    wfi
    ret

.set SYSCON_ADDR, 0x100000
.set SYSCON_REBOOT, 0x7777
.set SYSCON_POWEROFF, 0x5555

.global poweroff
.global reboot
poweroff:
    li t0, SYSCON_POWEROFF
    j syscon_final
reboot:
    li t0, SYSCON_REBOOT
syscon_final:
    li t1, SYSCON_ADDR
    sw t0, 0(t1)
