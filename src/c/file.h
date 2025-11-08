
#include <sys/stat.h>

int is_dir(char *path) {
  struct stat buff;

  stat(path, &buff);

  return S_ISDIR(buff.st_mode);
}

// TODO: Implement read_dir:
// - list the root entries of a directory
void read_dir(char *path) { printf("Reading %s\n", path); }
