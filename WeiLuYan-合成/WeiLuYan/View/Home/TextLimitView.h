//
//  TextLimitView.h
//  LimitText
//
//  Created by mac on 14/12/1.
//  Copyright (c) 2014年 xll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextLimitView : UIView<UITextViewDelegate>
@property (strong,nonatomic)UITextView * textView;
@property (assign)int LimitNumber;
@end
