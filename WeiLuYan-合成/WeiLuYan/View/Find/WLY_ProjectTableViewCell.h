//
//  WLY_ProjectTableViewCell.h
//  WeiLuYan
//
//  Created by 张亮 on 14/11/24.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedHeaderView.h"
#import "FeedContentView.h"
#import "ProjectPropetyView.h"
#import "CustomerView.h"
@class ProjectModel;
@interface WLY_ProjectTableViewCell : UITableViewCell

@property( nonatomic, strong)ProjectPropetyView*projectPropetyView;
@property( nonatomic, strong)FeedHeaderView*headerView;
@property( nonatomic, strong)FeedContentView*allContentView;
@property( nonatomic, strong)ProjectModel* projectModleObject;
@property( nonatomic, strong)CustomerView* customerView;
@property( nonatomic, strong)UIScrollView*scrollView;

-(void)setValue:(ProjectModel*)projectModelObject;
@end
