//
//  UIPlaceHolderTextViewForLength.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "UIPlaceHolderTextViewForLength.h"

@implementation UIPlaceHolderTextViewForLength



-(void)addShowTextLegnthView:(NSInteger)maxTextLength :(NSString*)placherText
{
    self.delegate=self;
    _textLengthLable=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-100, 225, 100, 10)];
    [_textLengthLable setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
    [_textLengthLable setFont:[UIFont systemFontOfSize:12]];
    [_textLengthLable setTag:2001];
    [_textLengthLable setText:[NSString stringWithFormat:@"%d/%ld",0,(long)maxTextLength]];
    [self setPlaceholder:placherText];
    [self addSubview:_textLengthLable];
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
   [_textLengthLable setText:[NSString stringWithFormat:@"%ld/%d",textView.text.length,140]];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
