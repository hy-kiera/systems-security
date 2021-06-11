# LAB5.2 - Buffer Overflow Attack Shellcode

## Environment
- Ubuntu 16.04 LTS server
- packages : gdb, nasm


### Task1-b
```
$ nasm -f elf32 task1b.s -o task1b.o
$ ld -m elf_i386 -s -o task1b task1b.o
```
The string "/bin/bash" is not a multiple of 4, and a string over length 4 occurs segmentation fault. I seperated the string into three pieces and pushed them: "/bin", "/bas", and "h" that are interpreted "/bin/bash".

### Task1-c
```
$ nasm -f elf32 task1c.s -o task1c.o
$ ld -m elf_i386 -s -o task1c task1c.o
```
By saving “-c” and “ls -al” at respectively the edx and the ecx, I could push their address and make the ecx which is for 2nd argument of a function point the address of the argument array.

## Task1-d
```
$ nasm -f elf32 myenv.s -o myenv.o
$ ld -m elf_i386 -s -o myenv myenv.o
```
Because the environment variables I need to pass are three, I used the ebx, ecx, and edx. I pushed strings and save their stack points into the registers. The eax is for NULL. Then, I moved the stack point of the string addresses that points stacked string addresses to edx which is for 3rd argument of a function.

### Task2
```
$ nasm -f elf32 myenv2.s -o myenv2.o
$ ld -m elf_i386 -s -o myenv2 myenv2.o
```
As explained in the PDF, the ebx points the ‘/bin/sh*AAAABBBB’ address. According to the one function, the string was changed: ‘*’ into 0x00; ‘AAAA’ into the string address stored in the ebx; and ‘BBBB’ into 4 bytes zeros. The ecx points the address of the string which means the address of the argument array, and the edx for environment variable has no environment variable.