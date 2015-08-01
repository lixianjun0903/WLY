//
//  ActivityForHeader.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityDetailInfo.h"
#import "UIImageView+WebCache.h"
#import "ActivityDetailViewController.h"

@interface ActivityForHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (nonatomic,strong)NSString * videoUnique;
@property (nonatomic,strong)NSString * videoName;
@property (nonatomic,weak) ActivityDetailViewController * adv;
@property (nonatomic,copy) void(^ block)();
-(void)setDetailData:(ActivityDetailInfo * )model;
@end
