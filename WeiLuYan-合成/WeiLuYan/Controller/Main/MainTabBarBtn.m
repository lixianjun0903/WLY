//
//  GBTabBarBtn.m
//  MyTabBarView
//
//  Created by gaob on 14/12/10.
//  Copyright (c) 2014年 gaob. All rights reserved.
//

#import "MainTabBarBtn.h"

@interface MainTabBarBtn ()
@end


@implementation MainTabBarBtn

-(id)initWithFrame:(CGRect)frame normalImage:(UIImage *)norImg selectImage:(UIImage *)selImg
{
    if (self = [super initWithFrame:frame])
    {
        if (norImg) {
            [self setBackgroundImage:norImg forState:UIControlStateNormal];
        }
        if (selImg) {
            [self setBackgroundImage:selImg forState:UIControlStateSelected];
        }
        
        self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        
        self.layer.cornerRadius = frame.size.width/2;

        self.layer.masksToBounds = YES;
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    return self;
}

@end
