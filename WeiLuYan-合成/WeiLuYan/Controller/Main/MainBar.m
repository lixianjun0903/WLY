//
//  MainBar.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MainBar.h"

#import "AppDelegate.h"

@interface MainBar()
{
    BOOL fireAppear;
    BOOL home;
    UIWindow * _window;
}

@end

@implementation MainBar

-(void)createWithWindow:(UIWindow *)window;
{
    _window = window;
    //bar btn
    _BarBtn = [[MainTabBarBtn alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 25,[UIScreen mainScreen].bounds.size.height - 60, 50, 50) normalImage:[UIImage imageNamed:@"Back_03"] selectImage:[UIImage imageNamed:@"Back_03_21"]];
    
    [_BarBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //nave bar
    _NaveBar = [MainNaviBar new];
    
    [window addSubview:_NaveBar];
    [window bringSubviewToFront:_NaveBar];

    //main sel
    _MainSel = [MainTabSel new];

    [window addSubview:_MainSel];
    [window bringSubviewToFront:_MainSel];
    
    [window addSubview:_BarBtn];
    [window bringSubviewToFront:_BarBtn];
    
    fireAppear = NO;
}

-(void)btnClick
{

    if( [AppDelegate getNav].viewControllers.count > 1)
    {
        [[AppDelegate getNav] popViewControllerAnimated:YES];
        fireAppear = YES;
    }
    else
    {
        UIViewController * vc = [AppDelegate getNav].viewControllers[0];
        
        if( [vc isKindOfClass:[UITabBarController class]]){
            
            [_MainSel showWithTabBar:(UITabBarController *)vc];
            
            [_BarBtn setBackgroundImage:[UIImage imageNamed:@"Back_03_21"] forState:UIControlStateNormal];
            [_BarBtn removeTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
            [_BarBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

-(void)click
{
    _MainSel.hidden = YES;
    [_BarBtn setBackgroundImage:[UIImage imageNamed:@"Back_03"] forState:UIControlStateNormal];
    [_BarBtn removeTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [_BarBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 自定义navigationBar的协议

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.hidesBackButton = YES;
}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(navigationController.viewControllers.count == 1)
    {
        if( [viewController isKindOfClass:[UITabBarController class]] )
        {
            [_NaveBar updateNaviItem:((UITabBarController *)viewController).selectedViewController.navigationItem];

            _BarBtn.hidden = NO;
            [_BarBtn setBackgroundImage:[UIImage imageNamed:@"Back_03"] forState:UIControlStateNormal];
            _BarBtn.selected = NO;
        }
        else{
            [_NaveBar updateNaviItem:viewController.navigationItem];
           
            //_BarBtn.hidden = YES;
        }
    }
    else
    {
        [_NaveBar updateNaviItem:viewController.navigationItem];
    
        _BarBtn.hidden = NO;
        [_BarBtn setBackgroundImage:[UIImage imageNamed:@"Back_03_21"] forState:UIControlStateNormal];
        _BarBtn.selected = YES;
    }
    
    if( fireAppear )
    {
        UIViewController * vc = [[[AppDelegate getNav] viewControllers] lastObject];

        if( [vc isKindOfClass:[UITabBarController class]]){
            [((UITabBarController *)vc).selectedViewController viewWillAppear:YES];
        }
        else{
            [vc viewWillAppear:YES];
        }
    
        fireAppear = NO;
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self click];
    [_NaveBar updateNaviItem:viewController.navigationItem];
    
    UIViewController * vc = [[[AppDelegate getNav] viewControllers] lastObject];
    
    if( [vc isKindOfClass:[UITabBarController class]]){
        [((UITabBarController *)vc).selectedViewController viewWillAppear:YES];
    }
    else{
        [vc viewWillAppear:YES];
    }
    
}

@end
