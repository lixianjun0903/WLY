//
//  WLY_LoginViewController.h
//  WLY—-ONE
//
//  Created by weiluyan on 14-9-17.
//  Copyright (c) 2014年 weiluyan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"

@interface WLoginViewController : UIViewController<UITextFieldDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *xianTwo;
@property (weak, nonatomic) IBOutlet UIImageView *xianThree;

@property (weak, nonatomic) IBOutlet UIImageView *xianImageView;
@property(nonatomic,retain)UILabel *NEXTUSER;
@property(nonatomic,retain)UILabel *Forgotpassword;
@property (weak, nonatomic) IBOutlet UIView *userView;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
- (IBAction)loginClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIImageView *iphoneImage;
@end
