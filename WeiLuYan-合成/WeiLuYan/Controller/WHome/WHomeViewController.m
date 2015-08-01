 //
//  MyHomeViewController.m
//  WeiLuYan
//
//  Created by gaob on 14/12/9.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WHomeViewController.h"
#import "GeneralizedProcessor.h"
#import "FeedItemCell.h"
#import "FeedRequest.h"
#import "AppDelegate.h"
#import "PublishViewController.h"
#import "CollectMoneyRequest.h"
#import "NewPublishViewController.h"
#import "MyFavouriteRequest.h"
#import "ActivityFirstView.h"

#define appkey @"551f54a3fd98c5c8f3000d40"

@interface WHomeViewController ()

//状态控制器
@property(nonatomic, strong)AFRequestState * state;
@property (nonatomic,strong) FavouritePerson * attentionPerson;

@end

@implementation WHomeViewController


-(void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    [self createNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate instance].homeCon = self;
    [self initView];
    [self createNav];
    
    _dataSource = [FeedItemDataSource new];
    _dataSource.controller = self;
    [_header beginRefreshing];
    //[self loadRecommend];
    
    _dataSource.CellType = Home;
    _dataSource.TableView = _mainTableView;
    
    _mainTableView.dataSource = _dataSource;
    _mainTableView.delegate = _dataSource;

    
    //对tableview的contentOffset进行监视，如果改变了  ，出发下面的kvo方法。
    [_mainTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark 加载推荐关注人
-(void)loadRecommend
{
    //__weak WHomeViewController * wvc = self;
    
    if( _state.running ){
        return;
    }
    _state = [[MyFavouriteRequest favoritePersonListsWithPage:1 with:^(FavouritePerson *personDic) {
        if(personDic.attention_user_isnull == 1){
            [_header endRefreshing];
            ActivityFirstView * view = [[ActivityFirstView alloc] initWithFrame:self.view.window.frame];
            [view setRecommendData:personDic.attention_user_arr];
            __weak ActivityFirstView * v = view;
            view.ensureAttention = ^{
                [AppDelegate instance].MainBar.BarBtn.hidden = NO;
                [v removeFromSuperview];
                [self loadData:_header Num:1];
            };
            [AppDelegate instance].MainBar.BarBtn.hidden = YES;
            [self.view.window addSubview:view];
        }
        else{
            [self loadData:_header Num:1];
        }
        
    } fail:^(int errCode, NSError *err) {
        
    }] addNotifaction:@{@"p":@1}];

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


-(void)createNav
{
    UIButton * publish = [UIButton buttonWithType:UIButtonTypeCustom];
    publish.frame = CGRectMake(10, 20, 24, 22);
    
    [publish setBackgroundImage:[UIImage imageNamed:@"btn_edit_default"] forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(publish:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, 55)];
    [view addSubview:publish];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
  
}
- (void)initView
{
    _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64)];
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
        [self loadRecommend];
        
    }
    else{
        [self loadData:refreshView Num:_dataSource.Page + 1];
    }
}

- (void)loadData:(id)notify Num:(int)num
{
    if(self.industry_id <= 0)
    {
        _dataSource.CellType = Home;
        _state = [[FeedRequest getFeedRequest:^(NSArray * data) {
            
            [self updateData:data Num:num];
            
        } :num] addNotifaction:notify];
    }else
    {
        _dataSource.CellType = Project;
        _state = [[CollectMoneyRequest collectIndustry:self.industry_id withPage:num with:^(NSDictionary *result) {
            
            [self updateData:(NSArray *)result Num:num];
            
            
        }] addNotifaction:notify];
    }
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
    self.tabBarController.selectedIndex = 0;
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

//是否允许横屏
-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
