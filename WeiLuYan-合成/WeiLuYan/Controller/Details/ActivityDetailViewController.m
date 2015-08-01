//
//  ActivityDetailViewController.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityForHeader.h"
#import "ActivityDetailsCell.h"
#import "sectionCommentView.h"
#import "sectionPeopleView.h"
#import "AFAppRequest.h"
#import "FeedRequest.h"
#import "CollectMoneyRequest.h"
#import "ActivityDetailInfo.h"
#import "commentObject.h"
#import "commentPersonObject.h"
#import "PersonDetailObject.h"

@interface ActivityDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)ActivityForHeader * headData;
@property(nonatomic, strong)AFRequestState * state;
@property(nonatomic,strong)NSArray * dataComArray;
@property(nonatomic,strong)NSArray * dataPerArray;
@property(nonatomic,strong) ActivityDetailInfo * actModel;

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTableView];
    
    _dataComArray = [[NSArray alloc]init];
    _dataPerArray = [[NSArray alloc]init];
    
   [self loadData];
    
}

-(void)loadData
{
        _state = [FeedRequest getActivityDetailRequest:^(ActivityDetailInfo * ActModel) {
        
        _actModel = ActModel;
        _dataPerArray = _actModel.approval_user_arr;
        _dataComArray = _actModel.feed_comment_arr;
        
        [self loadHeaderData:ActModel];
        
        [_tableView reloadData];
        }:self.mid];
    
    
}


-(void)loadHeaderData:(ActivityDetailInfo * )model
{
    [_headData setDetailData:model];
}
-(void)createTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //tableview的header
    
    _headData = [[ActivityForHeader alloc]initWithFrame:CGRectZero];
    __weak ActivityDetailViewController * ac = self;
    _headData.block = ^{
        ac.tableView.tableHeaderView = ac.headData;
        [ac.tableView reloadData];
    };
    _tableView.tableHeaderView = _headData;

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0)
    {
        return _dataPerArray.count;
        
    }
    else
    {
        return _dataComArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (cell == nil) {
        cell  = [[[NSBundle mainBundle]loadNibNamed:@"ActivityDetailsCell" owner:self options:nil] firstObject];
        cell.controlller = self;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    if(indexPath.section == 0)
    {
        PersonDetailObject * obj = _dataPerArray[indexPath.row];
        [cell setCellPersonData:obj];
        
    }
    else
    {
        commentObject * obj = _dataComArray[indexPath.row];
        [cell setCellCommentData:obj];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        if(_dataPerArray.count>0){
            sectionPeopleView * secPer = [sectionPeopleView new];
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
        if(_dataComArray.count>0){
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
