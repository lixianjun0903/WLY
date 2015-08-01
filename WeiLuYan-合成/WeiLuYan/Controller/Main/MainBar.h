//
//  MainBar.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainTabBarBtn.h"
#import "MainTabSel.h"
#import "MainNaviBar.h"

@interface MainBar : NSObject <UINavigationControllerDelegate, UITabBarControllerDelegate>

{
//    MainTabBarBtn * _BarBtn;
    MainNaviBar * _NaveBar;
    
    MainTabSel * _MainSel;
}
@property (nonatomic, strong) MainTabBarBtn * BarBtn;
@property (nonatomic, strong) MainNaviBar * NaveBar;

-(void)createWithWindow:(UIWindow *)window;
-(void)btnClick;
@end
