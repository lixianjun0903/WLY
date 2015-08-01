//
//  UIPlaceHolderTextViewForLength.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@interface UIPlaceHolderTextViewForLength : UIPlaceHolderTextView<UITextViewDelegate>

@property( nonatomic, strong)UILabel*textLengthLable;


-(void)addShowTextLegnthView:(NSInteger)maxTextLength :(NSString*)placherText;
@end
