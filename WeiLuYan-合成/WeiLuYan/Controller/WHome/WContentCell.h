//
//  WContentCell.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiveObject.h"

@interface WContentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

-(void)loadData:(NSDictionary *)data;
-(void)setCollectDetail:(NSDictionary *)data;
@end
