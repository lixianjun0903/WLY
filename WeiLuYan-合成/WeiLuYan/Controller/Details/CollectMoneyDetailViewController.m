//
//  CollectMoneyDetailViewController.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyDetailViewController.h"
#import "CollectMoneyForHeader.h"
#import "CollectDetailsCell.h"
#import "sectionCommentView.h"
#import "sectionPeopleView.h"
#import "AFAppRequest.h"
#import "FeedRequest.h"
#import "CollectMoneyRequest.h"
#import "ActivityDetailInfo.h"
#import "commentObject.h"
#import "commentPersonObject.h"
#import "sectionCommentView.h"
#import "sectionPeopleView.h"
#import "sectionForInvestView.h"
#import "CollectMoneyForHeader.h"
#import "TeamPeopleObject.h"
#import "NewCommentObject.h"
#import "InvestPeopleObject.h"
#import "CollectParkObject.h"


@interface CollectMoneyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)AFRequestState * state;

//投资档位
@property(nonatomic,strong)NSArray * investArray;
//团队成员
@property(nonatomic,strong)NSArray * projectPerArray;
//投资人
@property(nonatomic,strong)NSArray * investPerArray;
//评论
@property(nonatomic,strong)NSArray * commentPerArray;
@property(nonatomic,strong)ProjectDetailObject * collectData;
@property (nonatomic,strong) CollectMoneyForHeader * hea;
@property(nonatomic,strong)sectionPeopleView * pp;
@end

@implementation CollectMoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    _investPerArray = [[NSArray alloc]init];
    _projectPerArray = [[NSArray alloc]init];
    _investPerArray = [[NSArray alloc]init];
    _commentPerArray = [[NSArray alloc]init];
    
    [self loadData];
    
}
-(void)loadData
{
    if(self.state.running){
        return;
    }
    _state = [CollectMoneyRequest collectFinanceDetails:[self.mid intValue] succ:^(ProjectDetailObject *dic) {
        
        _collectData = dic;
        
        _investArray = _collectData.C_Parks;
        _projectPerArray = _collectData.P_TeamMembers;
        _commentPerArray = _collectData.C_Comments;
        _investPerArray = _collectData.C_Backers;
        [self loadHeaderData:dic];
        [_tableView reloadData];
        
    }];
}

-(void)loadHeaderData:(ProjectDetailObject *)model
{
    
    [_hea setCollectMoneyHeader:model];
    _hea.cdv = self;
    
}

-(void)createTableView
{
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _hea = [[CollectMoneyForHeader alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1000)];

    _tableView.tableHeaderView = _hea;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return _investArray.count;
    }
    else if(section == 1)
    {
        return _projectPerArray.count;
    }
    else if (section == 2)
    {
        return _investPerArray.count;
    }
    else
    {
        return _commentPerArray.count;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return 4;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CollectDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CollectDetailsCell" owner:self
                                          options:nil]firstObject];
        cell.controller = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.section == 0)
    {
        CollectParkObject * park = _investArray[indexPath.row];
        [cell setInvestParkData:park];
    }
    else if(indexPath.section == 1)
    {
       TeamPeopleObject * team = _projectPerArray[indexPath.row];
        [cell setPeopleData:team];
  
    }
    else if (indexPath.section == 2)
    {
       //投资人信息
        
        InvestPeopleObject * invest = _investPerArray[indexPath.row];
        [cell setInvestPeopleData:invest];
    }
    else
    {
        NewCommentObject * message = _commentPerArray[indexPath.row];
        [cell setCommentData:message];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        if (_investArray.count>0) {
            sectionForInvestView * secInv = [sectionForInvestView new];
            return secInv;
        }
        else
        {
            UIView * view = [[UIView alloc] init];
            view.frame = CGRectZero;
            return view;
        }
       
    }
     else if(section == 1)
    {
    
        if(_projectPerArray.count>0){
            sectionPeopleView * secPer = [sectionPeopleView new];
            secPer.title.text = @"项目成员";
            return secPer;
        }
        else{
            UIView * view = [[UIView alloc] init];
            view.frame = CGRectZero;
            return view;
        }
        
    }
    
    else if(section == 2)
    {

        if(_investPerArray.count>0){
            sectionPeopleView * secPer = [sectionPeopleView new];
            secPer.title.text = @"投资人";
            return secPer;
        }
        else{
            UIView * view = [[UIView alloc] init];
            view.frame = CGRectZero;
            return view;
        }
    }
    else
    {
        if(_commentPerArray.count>0){
            sectionCommentView * secCom = [sectionCommentView new];
            return secCom;
        }
        else{
            UIView * view = [[UIView alloc] init];
            view.frame = CGRectZero;
            return view;
        }
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 205;
    }
    else
    {
        return 80;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
