//
//  LXActivity.h
//  LXActivityDemo
//
//  Created by lixiang on 14-3-17.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialShakeService.h"

@interface ShareActivity : UIView<UMSocialShakeDelegate,UMSocialUIDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)void(^cancelBlock)(void);
- (id)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle viewController:(UIViewController *)vc isTransfer:(BOOL)flag ID:(int)projectID;

- (void)show;

@end
