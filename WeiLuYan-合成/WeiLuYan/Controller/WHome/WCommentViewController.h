//
//  WCommentViewController.h
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "FeedItemDataSource.h"
#import "ActiveObject.h"
#import "WContentView.h"
#import "YcKeyBoardView.h"
#define kWinSize [UIScreen mainScreen].bounds.size

@interface WCommentViewController : UIViewController<MJRefreshBaseViewDelegate>
@property( nonatomic, strong) MJRefreshHeaderView * header;
@property( nonatomic, strong) MJRefreshFooterView * footer;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property( nonatomic, strong) CollectMoneyObject * Data;
@property (nonatomic,strong) YcKeyBoardView * key;
@property (nonatomic,assign) CGFloat keyBoardHeight;
@property (nonatomic,assign) CGRect originalKey;
@property (nonatomic,assign) CGRect originalText;

@property (weak, nonatomic) IBOutlet WContentView *commentHeaderView;

-(void)loadHeaderViewData;




@end
