#include <dirent.h>
#include <string.h>
#include <sys/stat.h>

int is_dir(char *path) {
  struct stat buff;

  stat(path, &buff);

  return S_ISDIR(buff.st_mode);
}

void list_dir(char *path) {
  DIR *dir_ptr = opendir(path);

  int i = 0;

  while (dir_ptr) {
    struct dirent *dp = readdir(dir_ptr);

    if (dp == NULL) {
      return;
    }

    if (i > 1) {
      printf("%d\t %s\n", i - 1, dp->d_name);
    }

    i += 1;
  }

  printf("Reading %s\n", path);
}
