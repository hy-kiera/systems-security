section .text
  global _start
    _start:
        BITS 32
        jmp  short two
    one:
        pop  ebx
        xor  eax,      eax
        mov  [ebx+12], al         ; save 0x00 (1 byte) to memory at address ebx+12
        mov  [ebx+25], al         ; save 0x00 (1 byte) to memory at address ebx+25
        mov  [ebx+30], al         ; save 0x00 (1 byte) to memory at address ebx+30

        mov  [ebx+13], ebx        ; save the address of filename
        mov  [ebx+17], eax        ; null terminator

        lea  ecx,      [ebx+21]   ; get the address of first env (a=11)
        mov  [ebx+31], ecx        ; save the address of first env

        lea  ecx,      [ebx+26]   ; get the address of second env (b=22)
        mov  [ebx+35], ecx        ; save the address of second env

        mov  [ebx+39], eax        ; null terminator

        xor  edx,      edx
        lea  ecx,      [ebx+13]
        lea  edx,      [ebx+31]
        mov  al,       0x0b
        int  0x80
    tow:
        call one
        db   '/usr/bin/env*AAAA****a=11*b=22*BBBBCCCC****'  ; a placeholder