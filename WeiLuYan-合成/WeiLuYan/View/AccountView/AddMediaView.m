//
//  AddMediaView.m
//  WeiLuYan
//
//  Created by 张亮 on 14/10/27.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AddMediaView.h"
#import "UIButtonIndexPath.h"

#define ADD_BTON_LEFT 15
#define ADD_BTON_TOP 10
@implementation AddMediaView


-(id)initWithFrame:(CGRect)frame andBtonAddText:(NSString*)btonText
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        UIView* addBtonVieAndTextView =  [self addButonAndLableText:btonText];
        [addBtonVieAndTextView setTag:2014];
        [addBtonVieAndTextView setFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [self addSubview:addBtonVieAndTextView];
        
    }
    return self;
}
-(UIView*)addButonAndLableText:(NSString*)lableText
{
    UIView*addBtonVieAndTextView=[[UIView alloc]init];
    _addBton=[UIButtonIndexPath buttonWithType:UIButtonTypeCustom];
    [_addBton setImage:[UIImage imageNamed:@"Upload_add"] forState:UIControlStateNormal];
    [_addBton setFrame:CGRectMake(ADD_BTON_LEFT, ADD_BTON_TOP, 25, 25)];
    [addBtonVieAndTextView addSubview:_addBton];
    
    _addLable=[[UILabel alloc]initWithFrame:CGRectMake(_addBton.frame.origin.x+_addBton.frame.size.width+3, ADD_BTON_LEFT, 120, 18)];
    [_addLable setTextColor:[GeneralizedProcessor hexStringToColor:@"#ca2a2a"]];
    [_addLable setText:lableText];
    [addBtonVieAndTextView addSubview:_addLable];
    
    return addBtonVieAndTextView;
}

@end
