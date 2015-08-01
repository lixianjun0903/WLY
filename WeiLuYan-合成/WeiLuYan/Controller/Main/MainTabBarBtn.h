//
//  GBTabBarBtn.h
//  MyTabBarView
//
//  Created by gaob on 14/12/10.
//  Copyright (c) 2014年 gaob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarBtn : UIButton

@property (nonatomic, strong) UIViewController * viewController;

-(id)initWithFrame:(CGRect)frame normalImage:(UIImage *)norImg selectImage:(UIImage *)selImg;

@end
