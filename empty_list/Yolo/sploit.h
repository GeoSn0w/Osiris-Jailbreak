#ifndef sploit_h
#define sploit_h

mach_port_t vfs_sploit(void);
int exploit(void);
int nukeAMFI(void);
void kill_backboardd(void);
uint64_t get_KASLR_Slide(void);
uint tfp0_printout(void);
int doAuxStuff(void);
int yolo(void);
int nukeSandBox(void);
int dropthebear(void);
int runSploit(void);

#endif
