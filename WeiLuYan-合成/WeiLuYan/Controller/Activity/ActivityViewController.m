//
//  ActivityViewController.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityViewController.h"
#import "ActivityCell.h"
#import "AppDelegate.h"
#import "FeedRequest.h"
#import "MyFavouriteRequest.h"
#import "MJRefreshBaseView.h"
#import "ActivityFirstView.h"
#import "ActivityDetailViewController.h"
#import "NewPublishViewController.h"

@interface ActivityViewController ()<UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate,FinshPushState>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)AFRequestState * state;
@property(nonatomic,strong)MJRefreshHeaderView * header;
@property(nonatomic,strong)MJRefreshFooterView * footer;
@property(nonatomic,assign)int page;
@property (nonatomic,assign) BOOL flag;
@property (nonatomic,strong) NSMutableDictionary * expand;
@end

@implementation ActivityViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    _flag = NO;
    [self createNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _page = 1;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    _expand = [NSMutableDictionary new];
    
    [self createNav];

    [self createTableView];
    
    [self createRrefresh];
    [_header beginRefreshing];
    
}

#pragma mark 创建刷新
-(void)createRrefresh
{
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _tablieView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.delegate = self;
    _footer.scrollView = _tablieView;
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _header) {
        [self  loadRecommend];
    }
    else
    {
        [self loadData:refreshView Num:++_page];
    }
    
}

#pragma mark 加载推荐关注人
-(void)loadRecommend
{
    
    if( _state.running ){
        return;
    }
    _state = [[MyFavouriteRequest favoritePersonListsWithPage:1 with:^(FavouritePerson *personDic) {
        if(personDic.attention_user_isnull == 1){
            [_header endRefreshing];
            ActivityFirstView * view = [[ActivityFirstView alloc] initWithFrame:self.view.frame];
            [view setRecommendData:personDic.attention_user_arr];
            __weak ActivityFirstView * v = view;
            view.ensureAttention = ^{
                [AppDelegate instance].MainBar.BarBtn.hidden = NO;
                [v removeFromSuperview];
                [self loadData:_header Num:1];
            };
            [AppDelegate instance].MainBar.BarBtn.hidden = YES;
            [self.view addSubview:view];
        }
        else{
            [self loadData:_header Num:1];
        }
        
    } fail:^(int errCode, NSError *err) {
        
    }] addNotifaction:@{@"p":@1}];
    
}

-(void)finshPushState
{
    [_header beginRefreshing];
}

#pragma mark 创建导航
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

-(void)publish:(UIButton *)button
{
    NewPublishViewController * publish = [NewPublishViewController new];
    publish.delegate = self;
    [self.navigationController pushViewController:publish animated:YES];
    
}

#pragma mark 加载数据
-(void)loadData:(id)notify Num:(int)num
{
    _state = [[FeedRequest getFeedRequest:^(NSArray * data) {
        
        [self updateData:data Num:num];
        
    } :num] addNotifaction:notify];
    
}

-(void)updateData:(NSArray *)data Num:(int)num
{
    if (num == 1) {
        [_dataArray removeAllObjects];
        [_expand removeAllObjects];
        [_dataArray addObjectsFromArray:data];
        
    }
    else
    {
        [_dataArray addObjectsFromArray:data];
    }
    
    [_tablieView reloadData];
}

#pragma mark 初始化tableView
-(void)createTableView
{
    _tablieView.showsVerticalScrollIndicator = NO;
    _tablieView.separatorStyle=NO;
    _tablieView.delegate =self;
    _tablieView.dataSource = self;
    
    //对tableview的contentOffset进行监视，如果改变了  ，出发下面的kvo方法。
    [_tablieView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"]){
        UIPanGestureRecognizer * pan = _tablieView.panGestureRecognizer;
        CGPoint point = [pan translationInView:pan.view];
        if(point.y < 0)
        {
            [AppDelegate instance].MainBar.BarBtn.hidden = YES;
        }else
        {
            [AppDelegate instance].MainBar.BarBtn.hidden = NO;
        }
    }
    
    if([keyPath isEqualToString:@"Style"]){
        ActivityCell * cell = object;
        _flag = !_flag;
        NSString * str;
        if(_flag){
            str = @"1";
        }
        else{
            str = @"0";
        }
        cell.type = YES;
        [_expand setValue:str forKey:[NSString stringWithFormat:@"%d",cell.tag]];
        
        NSUInteger index[] = {0, cell.tag};
        NSIndexPath * path = [[NSIndexPath alloc] initWithIndexes:index length:2];
        self.ReloadItemPath = path;
    }
}

-(void)setReloadItemPath:(NSIndexPath *)path
{
    [self.tablieView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark tableView的代理函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ActivityCell" owner:self options:nil] firstObject];
        
        cell.Controller = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    if([[_expand objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]] intValue]){
        cell.Style = YES;
    }
    else{
        cell.Style = NO;
    }
    
    [cell setData:_dataArray[indexPath.row]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [NSString stringWithFormat:@"%d",indexPath.row];
    if([[_expand objectForKey:str] intValue]){
        _flag = YES;
    }
    else{
        _flag = NO;
    }
    return [ActivityCell getCellHeight:_flag];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailViewController * adv = [ActivityDetailViewController new];
   
    ActivityInfo * model = self.dataArray[indexPath.row];
    adv.mid = model.feedcontent_id;
    
    [self.navigationController pushViewController:adv animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.tag = indexPath.row;
    [cell addObserver:self forKeyPath:@"Style" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell removeObserver:self forKeyPath:@"Style"];
}



-(void)dealloc
{
    [_header free];
    [_footer free];
    [_tablieView removeObserver:self forKeyPath:@"contentOffset"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
