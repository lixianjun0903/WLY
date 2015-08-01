//
//  LineAndPlacherTextView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-15.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "LineAndPlacherTextView.h"

@implementation LineAndPlacherTextView

-(id)initWithFrame:(CGRect)frame :(NSString*)palcherText
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addLineAndPlacherText:palcherText];
        [self setLineAndPlacherTextViewNewFrame];
        
    }
    return self;
}

-(void)addLineAndPlacherText:(NSString*)text
{

    _placherText=[[UILabel alloc]initWithFrame:CGRectMake(LEFT_LINE, 23, 290,0)];
    [_placherText setText:text];
    [_placherText setNumberOfLines:0];
    _placherText.lineBreakMode = NSLineBreakByWordWrapping;
    [_placherText setTextColor:[UIColor lightGrayColor]];
    [_placherText setFont:[UIFont systemFontOfSize:14]];
    [self setNewFrame:text :_placherText];
    [self addSubview:_placherText];
    
    
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [LineAndPlacherTextView drawLineCode:187.0/255.0 :187.0/255.0 :187.0/255.0 :ctx :CGPointMake(LEFT_LINE, 10) :CGPointMake(self.frame.size.width-LEFT_LINE, 10)];
}
-(void)setNewFrame:(NSString*)text :(UILabel*)lable
{
    CGSize size=[GeneralizedProcessor lableHeightFromStr:text :290 :[UIFont systemFontOfSize:14]];
     CGRect  newRect=CGRectMake(lable.frame.origin.x,lable.frame.origin.y, size.width, size.height);
    [lable setFrame:newRect];
}

-(void)setLineAndPlacherTextViewNewFrame
{
    CGRect  newRect=CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,_placherText.frame.size.height+_placherText.frame.origin.y);
    [self setFrame:newRect];
}
+(void)drawLineCode:(CGFloat)red : (CGFloat)green :(CGFloat)blue :(CGContextRef)ctx :(CGPoint)startPostion :(CGPoint)endPoint
{
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(ctx, 1.0);  //线宽
    CGContextSetAllowsAntialiasing(ctx, YES);
    CGContextSetRGBStrokeColor(ctx, red,green, blue, 1.0);  //颜色
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, startPostion.x, startPostion.y);  //起点坐标
    CGContextAddLineToPoint(ctx,endPoint.x, endPoint.y);   //终点坐标
    CGContextStrokePath(ctx);
}

@end
