//
//  WDetailView.m
//  UIAlertController
//
//  Created by dev on 14/12/30.
//  Copyright (c) 2014年 dev. All rights reserved.
//

#import "CollectMoneyDetailView.h"
#import "DetailCell.h"
#import "CollectInfoDetailsController.h"
#import "AppDelegate.h"
#import "WMineViewController.h"
#import "ProjectDetailViewController.h"
#import "AppDelegate.h"

@interface CollectMoneyDetailView ()
{
    CGSize size;
}

@end

@implementation CollectMoneyDetailView
alloc_with_xib(detailView)
#pragma mark 加载xib
-(void)awakeFromNib
{
    [self._tableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    self._bottomLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 100)];
    
    self._bottomLab.font = [UIFont systemFontOfSize:11];
    self._bottomLab.numberOfLines = 0;
    self._bottomLab.textColor = [UIColor blackColor];
//    self._bottomLab.userInteractionEnabled = YES;
//    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//    [self._bottomLab addGestureRecognizer:gr];
}

#pragma mark 刷新高度
-(void)refreshHeight
{
    
    size = [self._bottomLab sizeThatFits:CGSizeMake(self.frame.size.width - 20, 100)];
    
    CGRect fra = self._bottomLab.frame;
    fra.size.height = size.height;
    self._bottomLab.frame = fra;
}

#pragma mark 详情点击
-(void)detailClick
{
    ProjectDetailViewController * vc = [ProjectDetailViewController new];
    [[AppDelegate getNav] pushViewController:vc animated:NO];
}

//#pragma mark 详情点击
//-(void)tap
//{
//    CollectInfoDetailsController * vc = [[CollectInfoDetailsController alloc]init];
//    
//    vc.str = self.strDetails;
//    
//    [[AppDelegate getNav] pushViewController:vc animated:YES];
//}

#pragma mark 创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"system"];
    
        [cell.contentView addSubview:self._bottomLab];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.frame.size.width - 70, self._bottomLab.frame.size.height, 60, 30);
        [button setTitle:@"查看详情>>" forState:UIControlStateNormal];
        [button setTitleColor:[GeneralizedProcessor hexStringToColor:@"ea2a2a"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(detailClick) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        [cell.contentView addSubview:button];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    DetailCell * cell = [self._tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    
    [cell config:self.dataArray[indexPath.row]];
    
    
    return cell;
}

#pragma mark 每个section cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    else{
        return self.dataArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark section的view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 1){
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        view.backgroundColor = [UIColor whiteColor];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        imageView.image = [UIImage imageNamed:@"btn_default_strip_02"];
        [view addSubview:imageView];
        return view;
    }
    else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        return view;
    }
}

#pragma mark cell的点击函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    
    Team * team = self.dataArray[indexPath.row];
    NSLog(@"%@",team.ref_id);
    
    WMineViewController * mvc = [WMineViewController new];
    mvc.useridd = [team.ref_id intValue];
    
    [[AppDelegate getNav] pushViewController:mvc animated:YES];
}

#pragma mark cell的高度
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 && size.height) {
        
        return size.height + 30;
    }
    return 80;
}


@end
