//
//  MyCollectMoneyViewController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WCollectMoneyViewController.h"
#import "GeneralizedProcessor.h"
#import "FeedItemCell.h"
#import "FeedRequest.h"
#import "AppDelegate.h"
#import "PublishViewController.h"
#import "CollectMoneyRequest.h"
#import "NewPublishViewController.h"


@interface WCollectMoneyViewController ()

@property(nonatomic, strong)AFRequestState * state;
@end

@implementation WCollectMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AppDelegate instance].collectCon = self;
    
    [self initView];
    
    _dataSource = [FeedItemDataSource new];
    
    __weak WCollectMoneyViewController * wvc = self;
    _dataSource.reLoadBlock = ^
    {
        [wvc loadData:@{@"p":@1} Num:1];
    };
    
    _dataSource.controller = self;
    _dataSource.CellType = Project;
    _dataSource.TableView = _mainTableView;
    
    _mainTableView.dataSource = _dataSource;
    _mainTableView.delegate = _dataSource;
    [_mainTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [_header beginRefreshing];
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIPanGestureRecognizer * pan = _mainTableView.panGestureRecognizer;
    CGPoint point = [pan translationInView:pan.view];
    if(point.y < 0)
    {
        [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    }else
    {
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    }
}



- (void)initView
{
    _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, HEIGHT - 64)];
    [self.view addSubview:_mainTableView];
    _mainTableView.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle=NO;
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = self.mainTableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.mainTableView;
    _footer.delegate = self;
}

-(void)dealloc
{
    [_footer free];
    [_header free];
    [_mainTableView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        [self loadData:refreshView Num:1];
    }
    else{
        [self loadData:refreshView Num:_dataSource.Page + 1];
    }
}

- (void)loadData:(id)notify Num:(int)num
{
    if( _state.running ){
        return;
    }
    
    _state = [[CollectMoneyRequest collectFinanceLists:num succ:^(NSDictionary *dic)
    {
        NSArray * array = (NSArray *)dic;
        [self updateData:array Num:num];
    }]  addNotifaction:notify];
    
}

-(void)updateData:(NSArray *)data Num:(int)num
{
    if( num == 1){
        [_dataSource loadData:data];
    }
    else{
        [_dataSource loadMore:data];
    }
    
    [_mainTableView reloadData];
}

#pragma mark - Target & KVO

-(void)rightItem
{
    self.tabBarController.selectedIndex = 1;
}

-(void)publish:(UIButton*)btn
{
    NewPublishViewController * publish = [NewPublishViewController new];
    publish.delegate = self;
    [self.navigationController pushViewController:publish animated:YES];

}
-(void)finshPushState
{
    [_header beginRefreshing];
}


-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
