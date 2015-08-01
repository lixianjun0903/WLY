//
//  MyProjectLogoView.h
//  WeiLuYan
//
//  Created by 张亮 on 14/10/27.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonIndexPath.h"
@interface MyProjectLogoView : UIView

@property( nonatomic, strong)UIButtonIndexPath*addBtonView;
@property( nonatomic, strong)UILabel*lableText;

-(id)initWithFrame:(CGRect)frame :(NSString*)addLogoText;
@end
