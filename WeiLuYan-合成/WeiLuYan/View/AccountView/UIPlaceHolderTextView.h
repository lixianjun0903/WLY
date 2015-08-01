//
//  UIPlaceHolderTextView.h
//  QIQI_77
//
//  Created by Bill.Zhang on 14-7-28.
//  Copyright (c) 2014年 Bill.Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPlaceHolderTextView : UITextView {
    
    NSString *placeholder;
    
    UIColor *placeholderColor;
    
    
    
@private
    
    UILabel *placeHolderLabel;
    
}



@property(nonatomic, strong) UILabel *placeHolderLabel;

@property(nonatomic, strong) NSString *placeholder;

@property(nonatomic, strong) UIColor *placeholderColor;



-(void)textChanged:(NSNotification*)notification;



@end