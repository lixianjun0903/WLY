//
//  AddMediaView.h
//  WeiLuYan
//
//  Created by 张亮 on 14/10/27.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UIButtonIndexPath;
@interface AddMediaView : UIView
@property( nonatomic, strong) UIButtonIndexPath*addBton;
@property( nonatomic, strong) UILabel*addLable;

-(id)initWithFrame:(CGRect)frame andBtonAddText:(NSString*)btonText;
-(void)addMedia;
@end
