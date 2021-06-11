section .text
  global _start
    _start:
      ; Store the argument string on stack
      xor  eax, eax
      push eax             ; Use 0 to terminate the string
      push 0x6c612d20      ; "-al"
      push 0x736c          ; "ls"
      mov  ecx, esp        ; Get the string address

      push eax             ; Use 0 to terminate the string
      push 0x632d          ; "-c"
      mov  edx, esp        ; Get the string address

      push eax             ; Use 0 to terminate the string
      push "//sh"
      push "/bin"
      mov  ebx, esp        ; Get the string address and the filename for execve function

      ; Construct the argument arrary argv[]
      push eax             ; argv[3] = 0
      push ecx             ; argv[2] points "ls -al"
      push edx             ; argv[1] points "-c"
      push ebx             ; argv[0] points "/bin//sh"
      mov  ecx, esp        ; Get the address of argv[]

      ; For environment variable
      xor  edx, edx        ; No env variables

      ; Invoke execve()
      xor  eax, eax        ; eax = 0x00000000
      mov   al, 0x0b       ; eax = 0x0000000b
      int  0x80