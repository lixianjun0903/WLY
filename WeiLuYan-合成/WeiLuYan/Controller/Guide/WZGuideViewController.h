//
//  WZGuideViewController.h
//  WZGuideViewController
//
//  Created by Wei on 13-3-11.
//  Copyright (c) 2013年 ZhuoYun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface WZGuideViewController : UIViewController
{
    BOOL _animating;
    
    UIScrollView *_pageScroll;
}

@property (nonatomic, assign) BOOL animating;
@property (nonatomic, strong) MainBar * MainBar;
@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) UIScrollView *pageScroll;

+ (WZGuideViewController *)sharedGuide;

+ (void)show;
+ (void)hide;

@end
