//
//  AddPictureView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-15.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "AddPictureView.h"
#import "UIButtonIndexPath.h"
#import "LineAndPlacherTextView.h"

#define ADD_BTON_LEFT 15
#define ADD_BTON_TOP 10
@implementation AddPictureView


-(id)initWithFrame:(CGRect)frame andBtonAddText:(NSString*)btonText :(NSString*)placherText
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
   
    UIView* addBtonVieAndTextView=  [self addButonAndLableText:btonText];
        [addBtonVieAndTextView setTag:2014];
    [addBtonVieAndTextView setFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    [self addSubview:addBtonVieAndTextView];

    _lineAndPlacherTextView=[[LineAndPlacherTextView alloc]initWithFrame:CGRectMake(0, _addPicture.frame.size.height+addBtonVieAndTextView.frame.size.height, self.frame.size.width,10) :placherText];
     [self addSubview:_lineAndPlacherTextView];
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

-(void)addPicture:(UIImage*)image
{
    _addPicture=[[UIImageView alloc]initWithImage:image];
    UIView* addBtonVieAndTextView=[self viewWithTag:2014];
    [_addPicture setFrame:CGRectMake(LEFT_LINE, addBtonVieAndTextView.frame.size.height, 150, 75)];
    [self addSubview:_addPicture];
      NSLog(@"%@-------",_lineAndPlacherTextView);
    [self lineAndPlacherTextViewNewFrame];
}
-(void)lineAndPlacherTextViewNewFrame
{
    UIView* addBtonVieAndTextView=[self viewWithTag:2014];
    [_lineAndPlacherTextView setFrame:CGRectMake(0, _addPicture.frame.size.height+addBtonVieAndTextView.frame.size.height+10, self.frame.size.width,10)];
}
@end
