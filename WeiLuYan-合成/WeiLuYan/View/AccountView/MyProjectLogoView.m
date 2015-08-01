//
//  MyProjectLogoView.m
//  WeiLuYan
//
//  Created by 张亮 on 14/10/27.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MyProjectLogoView.h"
#define KEY_LABLE_LEFT 13
#define KEY_LABLE_TOP 13
#define KEY_LABLE_Height 15
@implementation MyProjectLogoView

-(id)initWithFrame:(CGRect)frame :(NSString*)addLogoText
{
    self=[super initWithFrame:frame];
    
    if (self) {
        _lableText=[self getLable:addLogoText];
        [self addSubview:_lableText];
        
        _addBtonView=[UIButtonIndexPath buttonWithType:UIButtonTypeCustom];
        [_addBtonView setImage:[UIImage imageNamed:@"myproject_add"] forState:UIControlStateNormal];
        [_addBtonView setFrame:CGRectMake(KEY_LABLE_LEFT+_lableText.frame.size.width, 7, 45, 45)];
        [self addSubview:_addBtonView];
        }
    return self;
}

-(UILabel*)getLable:(NSString*)text
{
    UILabel* keyLable=[[UILabel alloc]initWithFrame:CGRectMake(KEY_LABLE_LEFT, KEY_LABLE_TOP, self.frame.size.width-190-LEFT_LINE, KEY_LABLE_Height)];
    [keyLable setFont:[UIFont systemFontOfSize:15]];
    [keyLable setText:text];
    [keyLable setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
    return keyLable;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
