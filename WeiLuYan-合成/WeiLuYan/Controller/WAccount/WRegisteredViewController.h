//
//  WLY_RegisteredViewController.h
//  WLY—-ONE
//
//  Created by weiluyan on 14-9-22.
//  Copyright (c) 2014年 weiluyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRegisteredViewController : UIViewController<UITextFieldDelegate>


@property(nonatomic,retain)UITextField *iphoneTextFiled;
@property(nonatomic,retain)UITextField *VerificationCodeTextFiled;
@property(nonatomic,retain)UITextField *NetPassswordTextFiled;

@end
