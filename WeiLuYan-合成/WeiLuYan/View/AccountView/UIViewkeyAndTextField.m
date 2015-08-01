
//
//  UIViewkeyAndTextField.m
//  WeiLuYan
//
//  Created by 张亮 on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "UIViewkeyAndTextField.h"

#define KEY_LABLE_LEFT 13
#define KEY_LABLE_TOP 13
#define KEY_LABLE_Height 15

@implementation UIViewkeyAndTextField

-(id)initWithFrame:(CGRect)frame andTextFieldKey :(NSString*)key
{
    self = [super initWithFrame:frame];
    if (self)
        
    {
        _keyLable=[self getLable:key];
        [self addSubview:_keyLable];
        
        _valueTextField=[[UITextField alloc]initWithFrame:CGRectMake(KEY_LABLE_LEFT+_keyLable.frame.size.width,KEY_LABLE_TOP, self.frame.size.width-KEY_LABLE_LEFT-_keyLable.frame.size.width, KEY_LABLE_Height)];
        [_valueTextField setDelegate:self];
        [_valueTextField setReturnKeyType:UIReturnKeyDone];
        [_valueTextField setFont:[UIFont systemFontOfSize:15]];
        [_valueTextField setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
        
        [self addSubview:_valueTextField];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andTextFieldKey :(NSString*)key :(NSString*)textFieldValue indexPath:(int)index
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _keyLable=[self getLable:key];
        [self addSubview:_keyLable];
        
        _valueTextField=[[UITextField alloc]initWithFrame:CGRectMake(KEY_LABLE_LEFT+_keyLable.frame.size.width,KEY_LABLE_TOP, self.frame.size.width-KEY_LABLE_LEFT-_keyLable.frame.size.width, KEY_LABLE_Height)];
        [_valueTextField setDelegate:self];
        [_valueTextField setText:textFieldValue];
        [_valueTextField setReturnKeyType:UIReturnKeyDone];
        [_valueTextField setFont:[UIFont systemFontOfSize:15]];
        [_valueTextField setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
        
        _flag = index;
        
        [self addSubview:_valueTextField];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andBtonKey :(NSString*)key :(NSString*)btonText
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _keyLable=[self getLable:key];
        [self addSubview:_keyLable];
        
        _valueButton=[UIButtonIndexPath buttonWithType:UIButtonTypeSystem];
        [_valueButton setTintColor:[GeneralizedProcessor hexStringToColor:@"#8C8B89"]];
        [_valueButton setTitle:btonText forState:UIControlStateNormal];
        [_valueButton setFrame:CGRectMake(KEY_LABLE_LEFT+_keyLable.frame.size.width,KEY_LABLE_TOP, 150, KEY_LABLE_Height)];
        [self addSubview:_valueButton];
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andCenterTextFieldKey :(NSString*)key
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _keyLable=[self getLable:key];
        [_keyLable setFrame:frame];
        [_keyLable setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_keyLable];
    }
    return self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
 
        [textField resignFirstResponder];

    return YES;
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
 
    
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        
}

-(void)keyboardShow:(NSNotification *)notification
{
    CGFloat height = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    _button.userInteractionEnabled = NO;
    if(self.block)
    {
    self.block(YES,height);
    }
}

-(void)keyboardHide:(NSNotification *)notification
{
    CGFloat height = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    _button.userInteractionEnabled = YES;
    if(self.block)
    {
        self.block(NO,height);
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    switch (_flag) {
            //昵称
        case 0:
        
            if((string.length - range.length + textField.text.length) > 10)
            {
                
                  return NO;
            }
            break;
            
            //真实姓名
        case 1:
            if((string.length - range.length+textField.text.length) > 10)
            {
                return NO;
            }
            break;

        default:
            break;
    }
    
    
  
    return YES;
    
}
-(UILabel*)getLable:(NSString*)text
{
    UILabel* keyLable=[[UILabel alloc]initWithFrame:CGRectMake(KEY_LABLE_LEFT, KEY_LABLE_TOP, self.frame.size.width-190-LEFT_LINE, KEY_LABLE_Height)];
    [keyLable setFont:[UIFont systemFontOfSize:15]];
    [keyLable setText:text];
    [keyLable setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
    return keyLable;
}
@end
