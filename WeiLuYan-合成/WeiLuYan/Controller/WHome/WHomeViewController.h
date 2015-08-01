//
//  MyHomeViewController.h
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "PublishViewController.h"
#import "FeedItemDataSource.h"
#import "NewPublishViewController.h"

@interface WHomeViewController : UIViewController<FinshPushState, MJRefreshBaseViewDelegate>

@property( nonatomic, strong)UITableView * mainTableView;
@property( nonatomic, strong) MJRefreshHeaderView * header;

@property( nonatomic, strong) MJRefreshFooterView * footer;

@property( nonatomic, strong) FeedItemDataSource * dataSource;//TableView的数据源

@property (assign) int industry_id;//分类ID


@end
