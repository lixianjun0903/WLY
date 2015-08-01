//
//  favoriteView.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-30.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "favoriteView.h"
#import "WContentCell.h"
#import "CollectMoneyRequest.h"
#import "MBProgressHUD+Show.h"
@interface favoriteView()
@property (nonatomic,strong)AFRequestState * state;
@property (nonatomic,strong)NSMutableArray * dataArray;
@end
@implementation favoriteView
alloc_with_xib(favorite)

-(void)awakeFromNib
{
    _favoriteView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void)setData:(MoneyDetailObject *)data
{
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    MBProgressHUD * mb = [MBProgressHUD mbHubShow];
    int proId = [data.project_id intValue];
    _state = [[CollectMoneyRequest getProjetApproval:proId succ:^(NSArray * array) {
        [_dataArray addObjectsFromArray:array];
        [_favoriteView reloadData];
    }] addNotifaction:mb];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"WContentCell" owner:self options:nil][0];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCollectDetail:_dataArray[indexPath.row]];
    return cell;
    
}


@end
