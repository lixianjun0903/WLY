//
//  WProjectCell.h
//  WeiLuYan
//
//  Created by dev on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoundProjectModel.h"

@interface WProjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

-(void)config:(FoundProjectModel *)model;

@end
