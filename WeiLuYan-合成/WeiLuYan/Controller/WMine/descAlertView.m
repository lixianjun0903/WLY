//
//  descAlertView.m
//  WeiLuYan
//
//  Created by jikai on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "descAlertView.h"

@interface descAlertView()<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextView *inputView;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;


@end

@implementation descAlertView

alloc_with_xib(desc);
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = 8;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordShow) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHide) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
}

-(void)setTitle:(NSString *)title buttonTitle:(NSString *)buttonTitle
{
    _titleLabel.text = title;
    [_button setTitle:buttonTitle forState:UIControlStateNormal];
}

-(void)setInfo:(NSString *)text
{
    _inputView.text = text;
}
-(void)keybordShow
{
    _alertView.frame = CGRectMake(20, 220, self.frame.size.width - 40, 200);
}

-(void)keybordHide
{
    _alertView.frame = CGRectMake(20, 150, self.frame.size.width, 200);
}

- (IBAction)cancleClick {
    [_inputView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self endEditing:YES];
    self.cancle();
}

- (IBAction)sureClick {
    [_inputView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self endEditing:YES];
    self.ensure(_inputView.text);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
