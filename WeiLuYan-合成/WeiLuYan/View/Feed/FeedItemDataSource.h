//
//  FeedItemDataSource.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/7.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FeedItemCell.h"
#import "CollectMoneyObject.h"
#import "FavoritePersonCell.h"
#import "attentionObject.h"

@interface FeedItemDataSource : NSObject<UITableViewDataSource, UITableViewDelegate,FavoritePersonDelegate>

@property (nonatomic,assign) UITableView * TableView;
@property (nonatomic,assign) UIViewController * Controller;
@property (nonatomic) FeedCellType CellType;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic,strong)void(^reLoadBlock)(void);

@property (nonatomic, readonly) int Page;

-(void)loadData:(NSArray *)data;
-(void)loadMore:(NSArray *)data;

@end