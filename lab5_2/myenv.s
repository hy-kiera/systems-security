section .text
  global _start
    _start:
      ; For environment variable
      xor  eax, eax
      push eax             ; Use 0 to terminate the string
      push 0x34            ; "4"
      push 0x3332313d      ; "=123"
      push 0x63636363      ; "cccc"
      mov  ebx, esp        ; Get the string address

      push eax             ; Use 0 to terminate the string
      push 0x38373635      ; "5678"
      push 0x3d626262      ; "bbb="
      mov  ecx, esp        ; Get the string address

      push eax             ; Use 0 to terminate the string
      push 0x34333231      ; "1234"
      push 0x3d616161      ; "aaa="
      mov  edx, esp        ; Get the string address

      push eax
      push ebx
      push ecx
      push edx
      mov  edx, esp        ; The environment variables

      ; Store the argument string on stack
      push eax             ; Use 0 to terminate the string
      push "/env"
      push "/bin"
      push "/usr"
      mov  ebx, esp        ; Get the string address and the filename for execve function

      ; Construct the argument arrary argv[]
      push eax             ; argv[1] = 0
      push ebx             ; argv[0] points "/usr/bin/env"
      mov  ecx, esp        ; Get the address of argv[]

      ; Invoke execve()
      xor  eax, eax        ; eax = 0x00000000
      mov   al, 0x0b       ; eax = 0x0000000b
      int  0x80