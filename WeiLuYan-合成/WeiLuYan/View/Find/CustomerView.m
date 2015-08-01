//
//  CustomerView.m
//  SM_Adv_system
//
//  Created by UC on 14-3-17.
//  Copyright (c) 2014年 UC. All rights reserved.
//

#import "CustomerView.h"
#import "UIButtonIndexPath.h"
#define UNTI_HEIGHT 57
#define UNINT_CENTER_WIDTH 100
#define UNINT_LEFT_AND_RIGHT 75
#define BTON_FRAME  CGRectMake(18, 25, 60, 27)
#define TITLE_FONT_SIZE 11

@implementation CustomerView

- (id)initWithFrame:(CGRect)frame :(int)shortLineCount
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        _shortLineCount=shortLineCount;
      
        _untilOne=[[UIView alloc]initWithFrame:CGRectMake(0, 0, UNINT_LEFT_AND_RIGHT, UNTI_HEIGHT)];
        [self addSubview:_untilOne];
        
        _untilTwo=[[UIView alloc]initWithFrame:CGRectMake(UNINT_LEFT_AND_RIGHT, 0,UNINT_LEFT_AND_RIGHT, UNTI_HEIGHT)];
        [self addSubview:_untilTwo];
        
        _untilThree=[[UIView alloc]initWithFrame:CGRectMake(UNINT_LEFT_AND_RIGHT*2,0, self.frame.size.width-UNINT_LEFT_AND_RIGHT*2, UNTI_HEIGHT)];
       [self addSubview:_untilThree];
      }
    return self;
}
-(void)setUntiViewOneValue:(CGRect)viewFrame :(UIImage*)normalImage :(UIImage*)selectImage
{
    _emogLikeBton=[CustomerView createButton:viewFrame :normalImage :selectImage];
    [_untilOne addSubview:_emogLikeBton];
}


-(void)setUntiViewTwoValue:(CGRect)viewFrame :(CGRect)lableFrame :(UIImage*)normalImage :(NSString*)commentText
{
         _commentLable=[CustomerView createLable:lableFrame :commentText];
        [_untilTwo addSubview:_commentLable];
         _commentBton=[CustomerView createButton:viewFrame :normalImage :nil];
        [_untilTwo addSubview:_commentBton];
}
-(void)setUntiViewThreeValue:(CGRect)shareViewFrame :(UIImage*)shareNormalImage :(CGRect)viewFrame :(CGRect)lableFrame :(UIImage*)normalImage :(NSString*)text
{
    _shareButon=[CustomerView createButton:shareViewFrame :shareNormalImage :nil];
    [_untilThree addSubview:_shareButon];
    _goodBton=[CustomerView createButton:viewFrame :normalImage :nil];
    [_goodBton.layer setCornerRadius:CGRectGetHeight([_goodBton bounds]) / 2];
    _goodBton.layer.masksToBounds = YES;
    [_untilThree addSubview:_goodBton];
    
    _likeCountLale=[CustomerView createLable:lableFrame :text];
    [_untilThree addSubview:_likeCountLale];
 
}

+(UILabel*)createLable:(CGRect)rect :(NSString*)text
{
    UILabel*lable=[[UILabel alloc]initWithFrame:rect];
    [lable setFont:[UIFont systemFontOfSize:TITLE_FONT_SIZE]];
    [lable setText:text];
    [lable setTextColor:[GeneralizedProcessor hexStringToColor:@"#787878"]];
    return lable;
}
+(UIButtonIndexPath*)createButton:(CGRect)rect :(UIImage*)nolmalImage :(UIImage*)selectImage
{
    UIButtonIndexPath*bton=[UIButtonIndexPath buttonWithType:UIButtonTypeCustom];
    [bton setImage:nolmalImage forState:UIControlStateNormal];
    [bton setImage:selectImage forState:UIControlStateSelected];
    [bton setFrame:rect];
    return bton;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
    [CustomerView drawLine:_shortLineCount:ctx];
    [CustomerView drawLineCode:200.0/255.0 :199.0/255.0 : 198.0/255.0 :ctx :CGPointMake(0, 5) :CGPointMake(320, 5)];
}

+(void)drawLine:(int)shortIneCount :(CGContextRef) ctx
{
    for (int i=0; i<shortIneCount; i++)
    {
        CGPoint StartPoint={UNINT_LEFT_AND_RIGHT+i*85, 15};
        CGPoint endPoint={UNINT_LEFT_AND_RIGHT+i*85, 40};
        [CustomerView drawLineCode:225.0/255.0 :225.0/255.0 : 225.0/255.0:ctx :StartPoint :endPoint];
    }
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
