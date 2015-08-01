//
//  MainTabBarController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MainTabBarController.h"
#import "WCollectMoneyViewController.h"
#import "WFindViewController.h"
#import "WFollowViewController.h"
#import "WHomeViewController.h"
#import "WMineViewController.h"
#import "WCollectMoneyViewController.h"
#import "WFavoriteController.h"
#import "WProjectViewController.h"
#import "UserTableViewController.h"
#import "ActivityViewController.h"
#import "CollectMoneyViewController.h"

@interface MainTabBarController ()
@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBar.hidden = YES;
}

-(void)createViews
{
//    WHomeViewController * hvc = [WHomeViewController new];
    //NewWHomeViewControllerViewController * hvc = [NewWHomeViewControllerViewController new];
    ActivityViewController * avc = [ActivityViewController new];
    avc.tabBarItem.title = @"动态";
    
//    WCollectMoneyViewController * wcm = [WCollectMoneyViewController new];
    CollectMoneyViewController * wcm = [CollectMoneyViewController new];
    wcm.tabBarItem.title = @"众筹";
    
    WFavoriteController * vc3 = [WFavoriteController new];
    vc3.tabBarItem.title = @"关注";

    WMineViewController * vc4 = [WMineViewController new];
    
   // UserTableViewController* vc4 = [UserTableViewController new];
    vc4.tabBarItem.title = @"设置";

    WProjectViewController * vc5 = [WProjectViewController new];
    vc5.tabBarItem.title = @"发现";
    
    self.viewControllers = @[avc,wcm,vc3,vc5,vc4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
