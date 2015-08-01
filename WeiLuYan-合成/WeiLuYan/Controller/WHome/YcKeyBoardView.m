//
//  YcKeyBoardView.m
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "YcKeyBoardView.h"

@interface YcKeyBoardView()<UITextViewDelegate>

@property (nonatomic,assign) CGFloat textViewWidth;
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL reduce;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;

@end

@implementation YcKeyBoardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        [self initTextView:frame];
    }
    return self;
}
-(void)initTextView:(CGRect)frame
{
    [self setBackgroundColor:[GeneralizedProcessor hexStringToColor:@"#F0F0F0"]];
    self.textView=[[UITextView alloc]init];
    self.textView.layer.cornerRadius = 6;
    self.textView.layer.masksToBounds = YES;
    self.textView.delegate=self;
    CGFloat textX=kStartLocation*0.5;
    self.textViewWidth=frame.size.width-2*textX;
    self.textView.frame=CGRectMake(textX, kStartLocation*0.2,self.textViewWidth , frame.size.height-2*kStartLocation*0.2);
    
    NSLog(@"%@",self.textView);
    self.textView.backgroundColor=[UIColor whiteColor];
    self.textView.font=[UIFont systemFontOfSize:20.0];
    [self addSubview:self.textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]){
        
        if([self.delegate respondsToSelector:@selector(keyBoardViewHide: textView:)]){
        
            [self.delegate keyBoardViewHide:self textView:self.textView];
        }
        return NO;
    }
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
      NSString *content=textView.text;
    
      CGSize contentSize=[content sizeWithFont:[UIFont systemFontOfSize:20.0]];
    
    if (textView.markedTextRange == nil && 140 > 0 && textView.text.length > 140) {
        textView.text = [textView.text substringToIndex:140];
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"您输入的字数已超限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
    }
    
      if(contentSize.width>self.textViewWidth){
          
          if(!self.isChange){
              
              CGRect keyFrame=self.frame;
              self.originalKey=keyFrame;
              keyFrame.size.height+=keyFrame.size.height;
              keyFrame.origin.y-=keyFrame.size.height*0.25;
              self.frame=keyFrame;
              
              CGRect textFrame=self.textView.frame;
              self.originalText=textFrame;
              textFrame.size.height+=textFrame.size.height*0.5+kStartLocation*0.2;
              self.textView.frame=textFrame;
              self.isChange=YES;
              self.reduce=YES;
            }
      }
    
    if(contentSize.width<=self.textViewWidth){
        
        if(self.reduce){
            
            self.frame=self.originalKey;
            self.textView.frame=self.originalText;
            self.isChange=NO;
            self.reduce=NO;
       }
    }
}
@end
