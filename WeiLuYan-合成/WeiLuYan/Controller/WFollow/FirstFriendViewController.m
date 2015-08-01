//
//  FirstFriendViewController.m
//  WeiLuYan
//
//  Created by jikai on 14-12-10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FirstFriendViewController.h"
#import "FriendModel.h"
#import "MyFriend.h"
#import "WFriendTableViewCell.h"

@interface FirstFriendViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation FirstFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [self loadData];

}

#pragma mark 加载数据
-(void)loadData
{
    FriendModel * model = [[FriendModel alloc] init];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    [model loadFriendData:0 urlbool:YES controller:self finish:^(NSArray * array) {
        [self.dataArray addObjectsFromArray:array];
        [self.tableView reloadData];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WFriendTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WFriendTableViewCell" owner:self options:nil] firstObject];
    }
    MyFriend * friend = self.dataArray[indexPath.row];
    [cell configFriend:friend add:NO];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
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
