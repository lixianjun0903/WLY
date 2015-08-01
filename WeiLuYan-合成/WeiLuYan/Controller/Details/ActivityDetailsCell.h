//
//  ActivityDetailsCell.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItemCell.h"
#import "peopleView.h"
#import "commentView.h"

@interface ActivityDetailsCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath * indexPath;

@property (weak, nonatomic) IBOutlet peopleView *peopleView;
@property (weak, nonatomic) IBOutlet commentView *commentView;

@property(nonatomic,weak)UIViewController * controlller;
-(void)setCellCommentData:(commentObject * )model;
-(void)setCellPersonData:(PersonDetailObject *)model;

@end
