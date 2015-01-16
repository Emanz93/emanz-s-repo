#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

/*
* Test program for zombie.sh. It will create one zombie process.
* Author Emanz93 - Emanuele Lovera
*/

int main() { 
   	int i = 0, pid_son1 = 9, pid_son2 = 9, pid_son3 = 9;
   	pid_son1 = fork();
   	i++;
   	pid_son2 = fork();
   	i++;
   	pid_son3 = fork();
   	i++;
   	if(pid_son1 == 0){
   		_exit(EXIT_SUCCESS);
   	} else if(pid_son2 == 0){
   		printf("I'm son 2\n");
   		_exit(EXIT_SUCCESS);
   	} else if(pid_son3 == 0){
   		printf("I'm son 3\n");
   		_exit(EXIT_SUCCESS);
   	} else {
   		int status;
   		printf("I'm father!\n");
   		pid_son1 = waitpid(pid_son1, &status, WUNTRACED);
   		pid_son2 = waitpid(pid_son2, &status, WUNTRACED);
   		sleep(1);
   		exit(EXIT_SUCCESS);
   	}
   	return 0;
}
