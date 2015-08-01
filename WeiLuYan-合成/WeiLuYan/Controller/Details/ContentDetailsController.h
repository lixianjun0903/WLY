//
//  ContentDetailsController.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/30.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentDetailsController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *contentDetails;
@property(nonatomic,strong)NSString * content;

@end
