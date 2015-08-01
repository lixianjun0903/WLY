//
//  CollectMoneyViewController.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/5.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyViewController.h"
#import "CollectMoneyCell.h"
#import "AppDelegate.h"
#import "FeedRequest.h"
#import "CollectMoneyRequest.h"
#import "CollectMoneyDetailViewController.h"


@interface CollectMoneyViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)AFRequestState * state;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,strong)MJRefreshFooterView * footer;
@property(nonatomic,assign)int page;
@end

@implementation CollectMoneyViewController
-(void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _page = 1;
    
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    [self createTableView];
    [self createRrefresh];
    
    [_header beginRefreshing];

}

-(void)createTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle=NO;
    
    //对tableview的contentOffset进行监视，如果改变了  ，出发下面的kvo方法。
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark 创建刷新
-(void)createRrefresh
{
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = _tableView;
    
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) {
        [self loadData:refreshView Num:1];
    }
    else
    {
        [self loadData:refreshView Num:++_page];
    }
}

-(void)loadData:(id)notify Num:(int)num
{
    if(_industry_id <= 0){
        _state = [[CollectMoneyRequest collectFinanceLists:num succ:^(NSDictionary *dic)
                   {
                       
                       NSArray * array = (NSArray *)dic;
                       [self upData:array Num:num];
                       
                   }]  addNotifaction:notify];
    }
    else{
        _state = [[CollectMoneyRequest collectIndustry:self.industry_id withPage:num with:^(NSDictionary *result) {
            
            [self upData:(NSArray *)result Num:num];
            
        }] addNotifaction:notify];
    }
    
}
-(void)upData:(NSArray *)data Num:(int)num
{
    if (num == 1) {
        [_dataArray addObjectsFromArray:data];
    }
    else
    {
        [_dataArray addObjectsFromArray:data];
    }
    
    [_tableView reloadData];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"]){
        UIPanGestureRecognizer * pan = _tableView.panGestureRecognizer;
        CGPoint point = [pan translationInView:pan.view];
        if(point.y < 0)
        {
            [AppDelegate instance].MainBar.BarBtn.hidden = YES;
        }else
        {
            [AppDelegate instance].MainBar.BarBtn.hidden = NO;
        }
    }
}
-(void)dealloc
{
    [_header free];
    [_footer free];
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectMoneyCell" owner:self options:nil] firstObject];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Controller = self;
    }
    
    
    [cell setData:_dataArray[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectMoneyDetailViewController * wd = [CollectMoneyDetailViewController new];
    CollectMoneyObject * model = self.dataArray[indexPath.row];
    wd.mid = model.project_id;
    [self.navigationController pushViewController:wd animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
