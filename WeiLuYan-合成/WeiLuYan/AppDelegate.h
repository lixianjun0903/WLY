//
//  AppDelegate.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-18.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalInfoModel.h"
#import "MainTabBarBtn.h"
#import "MainTabBarController.h"
#import "MainBar.h"
#import "WHomeViewController.h"
#import "WCollectMoneyViewController.h"
#import "WFollowViewController.h"
#import "WFavoriteController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController * _MainNavi;
//    MainBar * _MainBar;
}
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) MainBar * MainBar;

@property (nonatomic, strong) WHomeViewController * homeCon;

@property (nonatomic, strong) WCollectMoneyViewController * collectCon;

@property (nonatomic, strong) WFollowViewController * followCon;

@property (nonatomic, strong) WFavoriteController *favoriteCon;

@property (assign)int ori_flag;



+(AppDelegate*)instance;

+(UINavigationController *)getNav;

-(void)createMain;

-(void)appLogout;

+(void)errorAndRelogin;
-(void)createMainNavBar:(BOOL)login;
@end
