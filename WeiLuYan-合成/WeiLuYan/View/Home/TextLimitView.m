//
//  TextLimitView.m
//  LimitText
//
//  Created by mac on 14/12/1.
//  Copyright (c) 2014年 xll. All rights reserved.
//

#import "TextLimitView.h"

@implementation TextLimitView
{
    
    UILabel * _residueLab;
    UILabel * _uilabel;
}

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        [self createUI];
    }
    return self;
}




-(void)createUI
{
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    _textView = [[UITextView alloc] initWithFrame:self.frame];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.textColor = [UIColor blackColor];
    
    [self addSubview:_textView];
    
    _residueLab = [[UILabel alloc] initWithFrame:CGRectMake(w - 70, h - 30 , 120, 30)];
    _residueLab.font = [UIFont systemFontOfSize:14];
    _residueLab.textColor = [UIColor blackColor];
    _residueLab.backgroundColor = [UIColor whiteColor];
    _residueLab.text = [NSString stringWithFormat:@"0/140"];
    [self addSubview:_residueLab];
    
    _uilabel=[[UILabel alloc]init];
    _uilabel.text = @"请输入内容...";
    _uilabel.frame =CGRectMake(10,0,200,40);
    _uilabel.font = [UIFont fontWithName:@"Arial"size:14];//设置字体名字和字体大小
    _uilabel.enabled = NO;//lable必须设置为不可用
    _uilabel.backgroundColor = [UIColor clearColor];
    [_textView addSubview:_uilabel];
    
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    NSString *temp = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    if(140 - (int)temp.length >= 0)
//    {
//        _residueLab.text = [NSString stringWithFormat:@"%d/140",(int)temp.length];
//    }
//    if(temp.length > 140)
//    {
//        
//        return NO;
//    }
//    return YES;
//}

//-(void)textViewDidChange:(UITextView *)textView
//{
//    if (textView.text.length > self.LimitNumber)
//    {
//        textView.text = [textView.text substringToIndex:140];
//        
//        
//        
//    }
//    _residueLab.text = [NSString stringWithFormat:@"%d/%d",(int)textView.text.length,self.LimitNumber];
//
//    
//    if (textView.text.length == 0) {
//        _uilabel.text = @"请输入内容...";
//    }else{
//        _uilabel.text = @"";
//    }
//    
////    if([self getTextHeight]>self.frame.size.height)
////    {
////        
////        textView.text = [textView.text substringToIndex:textView.text.length];
////        textView.text = [textView.text substringToIndex:140];
////    }
//    
//    
//}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView.text.length >= self.LimitNumber && text.length > range.length) {
        return NO;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    
    if (textView.markedTextRange == nil && self.LimitNumber > 0 && textView.text.length > self.LimitNumber) {
        textView.text = [textView.text substringToIndex:self.LimitNumber];
    }
    _residueLab.text = [NSString stringWithFormat:@"%d/%d",(int)textView.text.length,self.LimitNumber];
    
    if (textView.text.length == 0) {
                _uilabel.text = @"请输入内容...";
            }else{
                _uilabel.text = @"";
            }

    
}

-(float)getTextHeight
{
    float textHeight = [_textView.text boundingRectWithSize:CGSizeMake(400, 400) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    return textHeight;
}

-(void)createAlertView
{
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您输入的字数已超限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [av show];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}



@end
