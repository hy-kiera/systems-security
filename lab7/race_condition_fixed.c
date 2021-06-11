#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main()
{
    char *fn = "/tmp/XYZ";
    char buffer[60];
    FILE *fp;

    scanf("%60s", buffer);

    uid_t euid = geteuid();
    uid_t ruid = getuid();
    seteuid(ruid); // disable the root privilege

    if (!access(fn, W_OK))
    {
        fp = fopen(fn, "a+");
        fwrite("\n", sizeof(char), 1, fp);
        fwrite(buffer, sizeof(char), strlen(buffer), fp);
        fclose(fp);
    }
    else
        printf("NoPermission\n");

    seteuid(euid); // restore the root privilege

    return 0;
}