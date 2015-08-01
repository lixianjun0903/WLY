//
//  LineAndPlacherTextView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-10-15.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineAndPlacherTextView : UIView

-(id)initWithFrame:(CGRect)frame :(NSString*)palcherText;
@property( nonatomic, strong)UILabel*placherText;
@end
