//
//  WFavoriteController.h
//  WeiLuYan
//
//  Created by gaob on 15/1/15.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "MJRefresh.h"
#import "FavoritePersonCell.h"
#import "attentionObject.h"
#import "NoDataView.h"
#import "CollectMoneyRequest.h"
#import "MBProgressHUD+Show.h"
#import "MyFavouriteRequest.h"
#import "FavouritePerson.h"
#import "WMineViewController.h"
#import "CollectMoneyDetailViewController.h"
#import "CollectMoneyCell.h"

@interface WFavoriteController : UIViewController<MJRefreshBaseViewDelegate, UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,FavoritePersonDelegate>
{
    int _page;
    NSString *_favourite;
    BOOL _isAttentionPerson;
    UIView *_favouriteView;
    UIScrollView *_favouriteScrollView;
    UITableView *_mainTableView;
    UIView *_welcomeView;
    UILabel *_welcomelabel;
    NoDataView *_noDataView;
}
@property(nonatomic, strong) MJRefreshHeaderView * header;
@property(nonatomic, strong) MJRefreshFooterView * footer;
@property(nonatomic, strong)AFRequestState * state;
@property(nonatomic, strong) NSMutableArray * dataArray;
@end
