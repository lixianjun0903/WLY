
//
//  WFavoriteController.m
//  WeiLuYan
//
//  Created by gaob on 15/1/15.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "WFavoriteController.h"
#import "AppDelegate.h"

@interface WFavoriteController ()
@end

@implementation WFavoriteController
-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    if(_isAttentionPerson){
        _isAttentionPerson = NO;
        [self fPerson];
    }
    else{
        [self fProject];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _favourite = @"1";
    _dataArray = [NSMutableArray array];
    [AppDelegate instance].favoriteCon = self;
    [self initView];
    [self createNav];
    [_header beginRefreshing];
}

- (void)initView
{
    _favouriteScrollView  = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, HEIGHT-40)];
    _favouriteScrollView.contentSize = CGSizeMake(WIDTH*2, HEIGHT - 50);
    _favouriteScrollView.pagingEnabled = YES;
    _favouriteScrollView.showsHorizontalScrollIndicator = NO;
    _favouriteScrollView.showsVerticalScrollIndicator = NO;
    _favouriteScrollView.userInteractionEnabled = YES;
    _favouriteScrollView.delegate = self;
    [self.view addSubview:_favouriteScrollView];
    
    _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 40)];
    [self.view addSubview:_mainTableView];
     _mainTableView.tableFooterView = [[UIView alloc]init];
    _mainTableView.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1];
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.dataSource = self;
    _mainTableView.delegate = self;
    [_mainTableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    _welcomeView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, HEIGHT)];
    _welcomeView.backgroundColor = [UIColor clearColor];
    
    _welcomelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    _welcomelabel.center = CGPointMake(WIDTH/2, HEIGHT/2);
    [_welcomelabel setTextAlignment:NSTextAlignmentCenter];
    _welcomelabel.text = @"您关注的人";
    
    [_welcomeView addSubview:_welcomelabel];
    [_favouriteScrollView addSubview:_welcomeView];
    [_favouriteScrollView addSubview:_mainTableView];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _mainTableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _mainTableView;
    _footer.delegate = self;
}

-(void)createNav
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    UIButton *fProjectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fProjectBtn.frame = CGRectMake(0, 10, WIDTH/2, 30);
    [fProjectBtn setTitle:@"已关注的项目" forState:UIControlStateNormal];
    [fProjectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fProjectBtn addTarget:self action:@selector(fProject) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *fPersonBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    fPersonBtn.frame = CGRectMake(WIDTH/2, 10, WIDTH/2, 30);
    [fPersonBtn setTitle:@"已关注的人" forState:UIControlStateNormal];
    [fPersonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fPersonBtn addTarget:self action:@selector(fPerson) forControlEvents:UIControlEventTouchUpInside];
    
    _favouriteView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH/12, 46, WIDTH/3, 3)];
    _favouriteView.backgroundColor = [GeneralizedProcessor hexStringToColor:@"ea2a2a"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [label addSubview:fPersonBtn];
    [label addSubview:fProjectBtn];
    [label addSubview:_favouriteView];
    [label setUserInteractionEnabled:YES];
    [label addSubview:lineView];
    [self.view addSubview:label];
}

-(void)fProject{
    _favourite = @"1";
    _mainTableView.separatorStyle = NO;
    _favouriteScrollView.contentOffset = CGPointMake(0, 0);
    _favouriteView.frame = CGRectMake(WIDTH/12, 46, WIDTH/3, 3);
    _mainTableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 40);
    [self loadData:_header Num:1];
    [_mainTableView reloadData];
}

-(void)fPerson{
    _favourite = @"2";
     _mainTableView.separatorStyle = YES;
    _favouriteScrollView.contentOffset = CGPointMake(WIDTH, 0);
    _favouriteView.frame = CGRectMake(WIDTH*7/12, 46, WIDTH/3, 3);
    _mainTableView.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - 50);
    [self loadData:_header Num:1];
    [_mainTableView reloadData];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    CGPoint offset=[_favouriteScrollView contentOffset];
    if (offset.x == WIDTH) { //向右滑动
        _welcomeView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        _welcomelabel.text = @"您关注的项目";
        [self fPerson];
    }else if(offset.x == 0){ //向左滑动
        _welcomeView.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT);
        _welcomelabel.text = @"您关注的人";
        [self fProject];
    }
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        [self loadData:refreshView Num:1];
    }
    else{
        if ([_favourite isEqualToString:@"2"]) {
            [self loadData:refreshView Num:1];
            [MBProgressHUD creatembHub:@"亲,没有关注的人了"];
            return;
        }
        [self loadData:refreshView Num:_page + 1];
    }
}

- (void)loadData:(id)notify Num:(int)num
{
    if( _state.running ){
        return;
    }
    if (_noDataView != nil) {
        [_noDataView removeFromSuperview];
    }
    if ([_favourite isEqualToString:@"2"]) {
        _state = [[MyFavouriteRequest favoritePersonListsWithPage:num with:^(FavouritePerson *personDic) {
            if(personDic.attention_user_isnull == 0){
                NSArray * array = personDic.attention_user_arr;
                [self updateData:(NSArray *)array Num:num];
            }
            else{
                _noDataView = [[NoDataView alloc] initNoDataView:@"亲，你没有关注的人" andFrame:self.view.frame];
                [_mainTableView addSubview:_noDataView];
                [self updateData:nil Num:num];
            }
            
        } fail:^(int errCode, NSError *err) {
            if(errCode == 5520)
             {
                 if (num == 1) {
                     [self updateData:nil Num:1];
                 }else{
                     [MBProgressHUD creatembHub:@"亲,没有关注的人了"];
                 }
             }
        }] addNotifaction:notify];
    }else{
            _state = [[CollectMoneyRequest collectFavoriteListsWithPage:num with:^(NSDictionary *result) {
                [self updateData:(NSArray *)result Num:num];
            } fail:^(int errCode, NSError *err) {
                if(errCode == 5520)
                {
                    if (num == 1) {
                      _noDataView = [[NoDataView alloc] initNoDataView:@"亲，你没有关注的项目" andFrame:self.view.frame];
                        [_mainTableView addSubview:_noDataView];
                        [self updateData:nil Num:1];
                    }else{
                         [MBProgressHUD creatembHub:@"亲,没有关注的项目了"];
                    }
                }
            }] addNotifaction:notify];
        }
}

-(void)updateData:(NSArray *)data Num:(int)num
{
    if( num == 1){
        [self loadData:data];
    }
    else{
        [self loadMore:data];
    }
    
    [_mainTableView reloadData];
}

-(void)loadData:(NSArray *)data
{
    _page = 1;
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:data];
}

-(void)loadMore:(NSArray *)data
{
    _page++;
    [_dataArray addObjectsFromArray:data];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_favourite isEqualToString:@"2"]){
        static NSString *cellIdentifier = @"Cell";
        FavoritePersonCell *cell = (FavoritePersonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSMutableArray *leftUtilityButtons = [NSMutableArray new];
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
            
            [rightUtilityButtons addUtilityButtonWithColor:
             [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                     title:@"取消关注"];
            
            cell = [[FavoritePersonCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier
                                      containingTableView:_mainTableView
                                       leftUtilityButtons:leftUtilityButtons
                                      rightUtilityButtons:rightUtilityButtons];
            cell.delegate = self;
        }
        
        
        NSObject * obj = self.dataArray[indexPath.row];
        
        if([obj isKindOfClass:[attentionObject class]])
        {
            cell.attentionObject = _dataArray[indexPath.row];
        }
        return cell;
    }else{
        CollectMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectMoneyCell" owner:self options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Controller = self;
        }
        NSObject * obj = self.dataArray[indexPath.row];
        if([obj isKindOfClass:[CollectMoneyObject class]])
        {
            cell.Data = _dataArray[indexPath.row];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_favourite isEqualToString:@"2"]) {
        return [[FavoritePersonCell new] getCellHeight];
    }else{
        return 480;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if([_favourite isEqualToString:@"2"]){
        attentionObject *attentionObject = _dataArray[indexPath.row];
        int mId = attentionObject.member_id;
        _isAttentionPerson = YES;
        WMineViewController * mvc = [WMineViewController new];
        mvc.useridd = mId;
        [self.navigationController pushViewController:mvc animated:YES];
    }else if ([_favourite isEqualToString:@"1"]) {
        CollectMoneyDetailViewController * wd = [CollectMoneyDetailViewController new];
        CollectMoneyObject * model = self.dataArray[indexPath.row];
        wd.mid = model.project_id;
        [self.navigationController pushViewController:wd animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.tag = indexPath.row;
    
    [cell addObserver:self forKeyPath:@"Style" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell removeObserver:self forKeyPath:@"Style"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"Style"])
    {
        FeedItemCell * cell = object;
        NSUInteger index[] = {0, cell.tag};
        NSIndexPath * path = [[NSIndexPath alloc] initWithIndexes:index length:2];
        
        self.ReloadItemPath = path;
    }
    
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


-(void)setReloadItemPath:(NSIndexPath *)path
{
    [_mainTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

//左滑暂时不支持
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
}

//右滑
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            NSIndexPath *cellIndexPath = [_mainTableView indexPathForCell:cell];
            int row = cellIndexPath.row;
            attentionObject *attentionObject = _dataArray[row];
            NSArray * array = @[[NSNumber numberWithInt:attentionObject.member_id]];
            [MyFavouriteRequest cancelFavoriteWithId:array with:^(NSNumber *result) {
                if ([result intValue] == 1) {
                    [_dataArray removeObjectAtIndex:row];
                    [_mainTableView reloadData];
                }else{
                    [MBProgressHUD creatembHub:@"取消失败"];
                }
            }];
            break;
        }
        default:
            break;
    }
}

-(void)rightItem
{
    self.tabBarController.selectedIndex = 1;
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
}

-(void)dealloc
{
    [_footer free];
    [_header free];
    [_mainTableView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
