#include <mach/mach_port.h>
#include "QiLin.h"
#include <mach/kern_return.h>

#include <stdio.h>

void doNothing(void ) {};
int main (int argc, char **argv)
{

void setDebugReporter (status_func *Func);

	setDebugReporter(doNothing);

	mach_port_t	kernel_task;

	kern_return_t host_get_special_port(task_t, int node, int which, mach_port_t *);
        kern_return_t kr=host_get_special_port(mach_host_self(), 0, 4, &kernel_task);

	if (argc < 2) {
		fprintf(stderr,"Usage: shaihulud _cmd_ [_args_]\n");
		fprintf(stderr,"Bestow the might of ShaiHulud (Sandbox escape + kernel credentials) on command\n");
		exit(1);

	}

	int slide = 0 ;
 	FILE *ss = fopen("/tmp/slide.txt","r");
        if (ss) { fscanf (ss, "0x%x", &slide);  fclose(ss); }


	int  rc = initQiLin (kernel_task,  0xfffffff007004000 + slide);

	if (rc) { fprintf(stderr,"Qilin Initialization failed!\n"); return rc;}

	int spawnAndShaiHulud (char *AmfidebPath, char *Arg1, char *Arg2, char *Arg3 , char *Arg4, char *Arg5);
	rc = spawnAndShaiHulud (argv[1], argv[2], NULL, NULL, NULL,NULL);


}
