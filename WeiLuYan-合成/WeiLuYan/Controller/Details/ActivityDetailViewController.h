//
//  ActivityDetailViewController.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshBaseView.h"
#import "FeedItemDataSource.h"


@interface ActivityDetailViewController : UIViewController<MJRefreshBaseViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)void(^reLoadBlock)(void);
@property(nonatomic)int mid;

@property( nonatomic, strong) FeedItemDataSource * dataSource;//TableView的数据源


@end
