//
//  MainTabSel.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarBtn.h"

@interface MainTabSel : UIToolbar

@property (nonatomic,strong) MainTabBarBtn *  barBtn;
-(id)init;

-(void)showWithTabBar:(UITabBarController *) tab;



@end
