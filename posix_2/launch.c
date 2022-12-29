#include <unistd.h>
#include <stdio.h>
#include <sys/wait.h>
#include <fcntl.h>

int main(int argc, char *argv[])
{
	pid_t pid = fork();
	if(pid == 0)
	{
		char *new_argv[] = { NULL };
		int file = open(argv[2], O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
		dup2(file, 1);
		execl(argv[1], "1", new_argv);
		// fflush(stdout);
		close(file);
	}
	int code;
	pid_t cpid = wait(&code);
	printf("child %d is done with code %d\n", cpid, code);
	return 0;
}
