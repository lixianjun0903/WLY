//
//  WFriendViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WFriendViewController.h"
#import "WFriendCell.h"
#import "FoundFriendModel.h"
#import "FriendRequest.h"
#import "AccountModel.h"


@interface WFriendViewController ()
{
    __weak IBOutlet UITableView *_friendTableView;
    int _page;
}

@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) AFRequestState * state;
@property (nonatomic,strong) MJRefreshHeaderView * header;
@property (nonatomic,strong) MJRefreshFooterView * footer;

@end

@implementation WFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_friendTableView registerNib:[UINib nibWithNibName:@"WFriendCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    _header = [MJRefreshHeaderView header];
    _header.scrollView = _friendTableView;
    _header.delegate = self;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = _friendTableView;
    _footer.delegate = self;
    
    [_header beginRefreshing];
    
}

-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        [self loadData:refreshView num:1];
    }
    else{
        [self loadData:refreshView num:_page];
    }
}

-(void)loadData:(id)notify num:(int)num
{
    if(_state.running){
        return;
    }

    AccountModel * model = [AccountModel instance];
    int n = model.personInfoModel.job;
    _state = [[FriendRequest getFriendRequest:^(NSArray *feedDic) {
        if(num == 1){
            _page = 2;
            self.dataArray = [NSMutableArray arrayWithCapacity:0];
            [self.dataArray addObjectsFromArray:feedDic];            
        }
        else
        {
            _page++;
            [self.dataArray addObjectsFromArray:feedDic];
        }
        [_friendTableView reloadData];
    } :n :num] addNotifaction:notify];

}

-(void)dealloc
{
    [_header free];
    [_footer free];
}


#pragma mark tableView的代理函数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WFriendCell * cell = [_friendTableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    FoundFriendModel * model = self.dataArray[indexPath.row];
    [cell config:model];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
