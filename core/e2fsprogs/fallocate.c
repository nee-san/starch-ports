#include <sys/types.h>
#include <sys/syscall.h>

int fallocate (int fd, int mode, off_t offset, off_t length) {
	return syscall (SYS_fallocate, fd, mode, offset, length);
}
