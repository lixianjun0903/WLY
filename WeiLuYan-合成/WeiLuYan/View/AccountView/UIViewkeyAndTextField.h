//
//  UIViewkeyAndTextField.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButtonIndexPath.h"
@interface UIViewkeyAndTextField : UIView<UITextFieldDelegate>

@property( nonatomic, strong) UILabel*keyLable;
@property( nonatomic, strong) UITextField*valueTextField;
@property( nonatomic, strong) UIButtonIndexPath*valueButton;
@property( nonatomic) int flag;
@property (nonatomic,strong) UIButton * button;


@property (nonatomic,copy) void (^block)(BOOL b,CGFloat height);


-(id)initWithFrame:(CGRect)frame andTextFieldKey :(NSString*)key;

-(id)initWithFrame:(CGRect)frame andTextFieldKey :(NSString*)key :(NSString*)textFieldValue indexPath:(int)index;

-(id)initWithFrame:(CGRect)frame andBtonKey :(NSString*)key :(NSString*)btonText;

-(id)initWithFrame:(CGRect)frame andCenterTextFieldKey :(NSString*)key;



@end
