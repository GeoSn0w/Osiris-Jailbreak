//
//  ViewController.h
//  Osiris-Jailbreak
//
//  Created by Ian Beer on 5/28/18.
//  Copyright © 2018 Ian Beer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *OSVER;
@property (weak, nonatomic) IBOutlet UIButton *jailbreakMeNowBtn;
- (void) failure;
@end

