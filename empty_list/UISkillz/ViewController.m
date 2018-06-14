#import "ViewController.h"
#include "QiLin.h"
#include "sploit.h"
#include "fuckDropbear.h"
#include <unistd.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcntl.h>
#include <pthread.h>
#include <sys/stat.h>
#include <mach/mach.h>
#include <spawn.h>
int beginShit(void);
uint UItfp0;
uint64_t kaslr_slide;

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
     UItfp0 = tfp0_printout();
     kaslr_slide = get_KASLR_Slide();
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        self.OSVER.text = [NSString stringWithFormat:@"iOS %@",currSysVer];
    
    }
- (IBAction)jailbreakMeNowBtn:(id)sender {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.3) {
        UIAlertController * failure_alert = [UIAlertController
                                             alertControllerWithTitle:@"You are running iOS 11.3.x!"
                                             message:@"The remount doesn't currently work on iOS 11.3.x! Working on it!"
                                             preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Dismiss"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action) {
                                     exit(EXIT_FAILURE);
                                 }];
        
         [failure_alert addAction:cancel];
         [self presentViewController:failure_alert animated:YES completion:nil];
         [self failure];
    } else {
        self.jailbreakMeNowBtn.enabled = NO;
        [self.jailbreakMeNowBtn setTitle:@"Pwning the device..." forState:UIControlStateDisabled];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            runSploit();
            [self get_tfp0];
        });
    }
}

- (void) get_tfp0{
    [self.jailbreakMeNowBtn setTitle:[NSString stringWithFormat:@"Got tfp0: %x",UItfp0] forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self getKASLR];
    });
}
// Fuck KASLR and get the slide.
- (void) getKASLR{
    [self.jailbreakMeNowBtn setTitle:[NSString stringWithFormat:@"Got KASLR: 0x%llx",kaslr_slide] forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self NukeSandBox];
    });
}
// Nuke Codesign
- (void) nukeAMFI{
    [self.jailbreakMeNowBtn setTitle:@"Bitch-slapping AMFI" forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (nukeAMFI() != 0){
            [self failure];
        } else {
            [self remountFS];
        };
    });
    
}
// Nuke SandBox
- (void) NukeSandBox{
    [self.jailbreakMeNowBtn setTitle:@"Nuking the SandBox" forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        nukeSandBox();
        [self nukeAMFI];
    });
}
- (void) remountFS{ // iOS 11.0 all the way up to 11.2.6
    [self.jailbreakMeNowBtn setTitle:@"Remounting RootFS" forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (remountRootFS() == 0){
            [self.jailbreakMeNowBtn setTitle:@"Got ROOT!" forState:UIControlStateDisabled];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                [self doAuxStuff];
            });
        } else {
            
            [self failure];
        }
    });
}
-(void) doAuxStuff{
    [self.jailbreakMeNowBtn setTitle:@"Preparing File System" forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (yolo() == 0){
            [self nukeUpdates];
        } else {
            [self failure];
        }
    });
}
- (void) nukeUpdates{
    [self.jailbreakMeNowBtn setTitle:@"Nuking Apple Update" forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        disableAutoUpdates();
        [self popAShell];
    });
}
- (void) popAShell{
    [self.jailbreakMeNowBtn setTitle:@"Popping a shell..." forState:UIControlStateDisabled];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        if (beginShit() == 0){
            [self.jailbreakMeNowBtn setTitle:@"Got shell!" forState:UIControlStateDisabled];
            UIAlertController * failure_alert = [UIAlertController
                                                 alertControllerWithTitle:@"Jailbreak Successfull!"
                                                 message:@"You can connect via netcat! Run nc <YOUR IP> 69"
                                                 preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* cancel = [UIAlertAction
                                     actionWithTitle:@"Dismiss"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action) {
                                         exit(EXIT_FAILURE);
                                     }];
            
            
            [failure_alert addAction:cancel];
            
            [self presentViewController:failure_alert animated:YES completion:nil];
        } else {
            [self failure];
        }
    });
    
    [self done];
}
- (void) failure{
    [self.jailbreakMeNowBtn setTitle:@"Jailbreak Failed" forState:UIControlStateDisabled];
    UIAlertController * failure_alert = [UIAlertController
                                         alertControllerWithTitle:@"Jailbreak failed!"
                                         message:@"Please reboot your iPhone and try again!"
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Dismiss"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 exit(EXIT_FAILURE);
                             }];
    
    
    [failure_alert addAction:cancel];
    
    [self presentViewController:failure_alert animated:YES completion:nil];
    
}
- (void) done{
    [self.jailbreakMeNowBtn setTitle:@"Done!" forState:UIControlStateDisabled];
    
}
@end
