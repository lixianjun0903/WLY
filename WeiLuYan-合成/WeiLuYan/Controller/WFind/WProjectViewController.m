//
//  WProjectViewController.m
//  WeiLuYan
//
//  Created by dev on 14/12/10.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WProjectViewController.h"
#import "WFindRequest.h"
#import "WTimeViewController.h"
#import "FoundProjectModel.h"
#import "WProjectCell.h"
#import "CollectMoneyViewController.h"
#import "AppDelegate.h"



@interface WProjectViewController ()

@property (weak, nonatomic) IBOutlet UITableView * _tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation WProjectViewController

@synthesize find;
//-(void)viewWillAppear:(BOOL)animated
//{
//    self.navigationController.navigationBarHidden = YES;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    
    [self loadProjectData];
    
    [self._tableView registerNib:[UINib nibWithNibName:@"WProjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(void)setFindViewController:(WFindViewController *)findVC
{
    self.find = findVC;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WProjectCell * cell = [self._tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    FoundProjectModel * model = self.dataArray[indexPath.row];
    [cell config:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CollectMoneyViewController * vc = [CollectMoneyViewController new];
    
    FoundProjectModel * model = self.dataArray[indexPath.row];
    
   vc.industry_id = [model.industry_id intValue];
    
    [[AppDelegate getNav] pushViewController:vc animated:YES];
}

#pragma mark 加载项目数据
-(void)loadProjectData
{
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [WFindRequest project:^(NSArray * userDic) {
        [self.dataArray addObjectsFromArray:userDic];
        [__tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
