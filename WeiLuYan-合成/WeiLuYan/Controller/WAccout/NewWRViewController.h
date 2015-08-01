//
//  NewWRViewController.h
//  WeiLuYan
//
//  Created by weiluyan on 15/3/12.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewWRViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *iPhoneTextField;

@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTwoTextField;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *wrBtn;

@property (weak, nonatomic) IBOutlet UIImageView *oneImage;
@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIImageView *fourImage;

@property (weak, nonatomic) IBOutlet UIImageView *fImage;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;

@property (weak, nonatomic) IBOutlet UIButton *nikeBtn;



@end
