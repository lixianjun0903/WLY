//
//  WContentView.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"

@interface WContentView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *mediaView;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (nonatomic,strong) void (^keboardBlock)(void);
-(void)loadData:(CollectMoneyObject *)data;

@end
