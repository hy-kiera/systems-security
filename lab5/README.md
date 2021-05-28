# LAB5 - Buffer Overflow Attack

## Environment
- Ubuntu 16.04 LTS server
- packages : gdb, libc6-dev-i386, dos2unix

## Turning Off Countermeasures
```
$ sudo rm /bin/sh
$ sudo ln -s /bin/zsh /bin/sh

$ sudo sysctl -w kernle.randoize_va_space=0  // ASLR Inactivate
```

### Task1
```
$ gcc -m32 -z execstack -o task1 task1.c  // executable stack
```
The program task1 copied shellcode which executes /bin/sh into the variable buf and run it.

### Task2
```
$ gcc -m32 -z execstack -g -fno-stack-protector -o task2_stack task2_stack.c  // SSP Inactivate
$ sudo chown root task2_stack
$ sudo chmod 4755 task2_stack
$ gdb task2_stack
$ gcc -m32 -o task2_exploit task2_exploit.c
$ ./task2_exploit
$ ./task2_stack
```
The task2_exploit create badfile which contains a new return address next to the ebp, a shellcode in the end, and NOPs in rest parts. In the task2_stack, the whole content of badfile is successfully copied using strcpy() which doesn't care the length of content to copy, so the original return address if overwritten and then the shellcode executed.

## Defeating dash's Countermeasure
```
$ sudo rm /bin/sh
$ sudo ln -s /bin/dash /bin/sh
```

### Task3
```
$ gcc -m32 -o task3_exploit task3_exploit.c
$ ./task3_exploit
$ ./task2_stack
```
The dash shell in Ubuntu 16.04 drops privileges when it detcts that the efective UID does not equal to the real UID. Dash can be defeated by calling setuid(0) before executing it.