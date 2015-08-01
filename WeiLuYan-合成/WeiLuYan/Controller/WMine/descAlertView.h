//
//  descAlertView.h
//  WeiLuYan
//
//  Created by jikai on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface descAlertView : UIView

@property (nonatomic,copy) void (^cancle)();
@property (nonatomic,copy) void (^ensure)(NSString *);

-(void)setTitle:(NSString *)title buttonTitle:(NSString *) buttonTitle;

-(void)setInfo:(NSString * )text;


@end
