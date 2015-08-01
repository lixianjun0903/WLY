//
//  WBindAndQuit.h
//  WeiLuYan
//
//  Created by dev on 14/12/12.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSetViewController.h"
#import "AccountRequest.h"

@interface WBindAndQuit : NSObject

//跳转到 修改密码，反馈，关于 页面
+(void)ControllersForPush:(UINavigationController *)con :(NSIndexPath *)indexPath;

//绑定 QQ，微博
+(void)BindForQQ:(NSIndexPath *)indexPath :(WSetViewController *)ViewCon;
+(void)bindForWeibo:(NSIndexPath *)indexPath :(WSetViewController *)ViewCon;

//退出登录
+(void)Quit:(BOOL)BindToWeibo;

@end
