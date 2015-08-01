//
//  AppDelegate.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-18.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AppDelegate.h"
#import "GeneralizedProcessor.h"
#import "WLoginViewController.h"
#import "UMSocialSinaHandler.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "PeopleAddress_machine.h"
#import "UserInfoRequest.h"
#import <objc/runtime.h>
#import "MainNaviBar.h"
#import "UMSocialQQHandler.h"
#import "WZGuideViewController.h"
#define appkey @"551f54a3fd98c5c8f3000d40"
#import "NewWRViewController.h"

@interface AppDelegate () <UIAlertViewDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    //    消除登录记录
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLaunched"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        NSLog(@"走判断");
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        NSLog(@"第一次调用");
        WZGuideViewController *wd=[[WZGuideViewController alloc]init];
        self.window.rootViewController=wd;
    }
    else{
        [self createMainNavBar:YES];
    }
    
    [self.window makeKeyAndVisible];
    [_MainBar createWithWindow:self.window];
    return YES;
}

//创建主界面
-(void)createMainNavBar:(BOOL)login
{
    _MainBar = [MainBar new];
    
    //Navigation
    _MainNavi = [[UINavigationController alloc]initWithRootViewController:nil];
    _MainNavi.navigationBar.layer.masksToBounds = YES;
    _MainNavi.navigationBar.translucent = NO;
    _MainNavi.delegate = _MainBar;
    
    self.window.rootViewController = _MainNavi;
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       // _MainBar.BarBtn.hidden = YES;
        if(login){
            [self createLogin];
        }
        else{
            [self createRegister];
        }
    }
    else{
        //验证登录身份
        if (![[AccountModel instance] hasToken]) {
            [self createLogin];
        }
        else{
            [self createMain];
        }
    }
    
    [_MainBar createWithWindow:self.window];
    
    [self createUM];

}


//进入登陆页面，本地没有获取到用户登录信息
-(void)createLogin
{
    WLoginViewController * lvc = [WLoginViewController new];
    [_MainNavi setViewControllers:@[lvc]];
}

-(void)createRegister
{
    NewWRViewController *reg = [[NewWRViewController alloc]init];
    [_MainNavi setViewControllers:@[reg]];
    //[self.navigationController pushViewController:reg animated:YES];
}

//进入主界面，获取到了用户信息
-(void)createMain
{
    MainTabBarController * mtc = [MainTabBarController new];
    mtc.delegate = _MainBar;
    [[AccountModel instance] getUserInfoAndToken];
    
    [_MainNavi setViewControllers:@[mtc]];
}

-(void)appLogout
{
    [[AccountModel instance] clearTokenAndInfo];
    [self createLogin];
}

#pragma mark 登录时效重新登录

+(void)errorAndRelogin
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"您的登陆已经失效，请重新登录" delegate:self cancelButtonTitle:@"重新登录" otherButtonTitles:nil];
    alert.delegate = [AppDelegate instance];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self appLogout];                           
}

-(void)createUM
{
    [UMSocialData setAppKey:@"551f54a3fd98c5c8f3000d40"];
    
    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
    //wx981bb3803ff0c270  aa6be96c60382e6723e6c35a6a43b8ff
    
    [UMSocialWechatHandler setWXAppId:@"wxd67d380f266769e2" appSecret:@"146e1b3119ebfaa6bc429f80e429ed1c" url:@"http://www.umeng.com/social"];

    [UMSocialQQHandler setQQWithAppId:@"1104451983" appKey:@"cwtGukJMHbbHa9hO" url:@"auth://tauth.qq.com/"];

//    UMSocialQQData
//    NSMutableArray *ARR = [NSMutableArray array];
//    PeopleAddress_machine *PE=[PeopleAddress_machine shareAddress];
//    ARR = [PE ReadAllPeoples];
    
//    [UserInfoRequest uploadContact:^(NSDictionary *userDic,NSError *error) {}:ARR];
}

+(UINavigationController *)getNav
{
 
    NSLog(@"dasdasdad第一次大大大");
    return [AppDelegate instance]->_MainNavi;
}

+(AppDelegate*)instance
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if( self.ori_flag == 1){
        return UIInterfaceOrientationMaskAll;
    }
    else{
        return UIInterfaceOrientationMaskPortrait;
    }
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
