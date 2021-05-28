#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#ifndef BUF_SIZE
#define BUF_SIZE 12
#endif

int bof(char *str)
{
    char buf[BUF_SIZE];
    strcpy(buf, str);

    return 0;
}

int main(int agrc, char **argv)
{
    char str[517];
    FILE *badfile;
    char dummy[BUF_SIZE];
    memset(dummy, 0, BUF_SIZE);

    badfile = fopen("badfile", "r");
    fread(str, sizeof(char), 517, badfile);
    bof(str);
    printf("Returned Properly\n");

    return 0;
}