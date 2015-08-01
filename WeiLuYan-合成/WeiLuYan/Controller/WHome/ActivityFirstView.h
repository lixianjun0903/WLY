//
//  ActivityFirstView.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/20.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ActivityFirstView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *allChooseBtn;
@property (weak, nonatomic) IBOutlet UIView *viewBG;

@property (nonatomic,copy) void(^ ensureAttention)();

-(void)setRecommendData:(NSArray *)data;

@end
