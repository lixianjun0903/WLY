//
//  WFavoriteController.m
//  WeiLuYan
//
//  Created by gaob on 15/1/15.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "WFavoriteController.h"
#import "MJRefresh.h"
#import "CollectMoneyRequest.h"

@interface WFavoriteController ()

{
    UITableView * _tableView;
    int page;
    
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
    
}

@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation WFavoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    page = 1;
    
    [self createTableView];
    
    [self createRefresh];
}

-(void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    //添加协议跟datasource
    
    [self.view addSubview:_tableView];
    
    
}

-(void)createRefresh
{
    _header = [MJRefreshHeaderView header];
    _footer = [MJRefreshFooterView footer];
    
    _header.scrollView = _tableView;
    _footer.scrollView = _tableView;
    
    __weak WFavoriteController * wf = self;
    
    _header.beginRefreshingBlock = ^(MJRefreshBaseView * refresh)
    {
        [wf loadData:refresh];
    };
    [_header beginRefreshing];
}

-(void)loadData:(MJRefreshBaseView *)refresh
{
    if (refresh == _header) {
        page = 1;
        self.dataArray = nil;
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
        
    }
    else
    {
        page ++;
    }
    
    [[CollectMoneyRequest collectFavoriteListsWithPage:page with:^(NSDictionary *result) {
        //成功
        NSLog(@"result = %@",result);
//        [self.dataArray addObjectsFromArray:.......];
        
    }] addNotifaction:refresh];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
