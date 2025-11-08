// TODO use <sys/stat.h> to read and infer if file is regular file or dir

#include <sys/stat.h>

int is_file(char* path) {
	struct stat buff;

	stat(path, &buff);

	return S_ISDIR(buff.st_mode);
}
