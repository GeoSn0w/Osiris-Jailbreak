//
//  ViewController.m
//  Osiris-Jailbreak
//
//  Created by Ian Beer on 5/28/18.
//  Copyright © 2018 Ian Beer. All rights reserved.
//

#import "ViewController.h"
#include "sploit.h"
#include "QiLin.h"
#include "fuckDropbear.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    self.OSVER.text = [NSString stringWithFormat:@"iOS %@",currSysVer];
}
- (IBAction)jbMeNow:(UIButton *)sender {
    self.jailbreakMeNowBtn.enabled = NO;
   [self.jailbreakMeNowBtn setTitle:@"Running the Exploit" forState:UIControlStateDisabled];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            if (exploit() != 0){
                [self failure];
            } else {
                [self get_tfp0];
            }
            
    });
}
- (void) get_tfp0{
    unsigned int tfp0 = tfp0_printout();
    [self.jailbreakMeNowBtn setTitle:[NSString stringWithFormat:@"Got tfp0: %x",tfp0] forState:UIControlStateDisabled];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         [self getKASLR];
    });
}
// Fuck KASLR and get the slide.
- (void) getKASLR{
    uint64_t kaslr_slide = get_KASLR_Slide();
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
