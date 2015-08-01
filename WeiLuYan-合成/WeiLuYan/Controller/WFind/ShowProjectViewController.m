//
//  ShowProjectViewController.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/24.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ShowProjectViewController.h"
#import "ProjectRequest.h"
#import "ProjectModel.h"
#import "WLY_ProjectTableViewCell.h"


@interface ShowProjectViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * projectArray;
@property(nonatomic,strong) UITableView * projectTableView;

@end

@implementation ShowProjectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavarBar];
    
    [self createTableView];
    
    [self loadData];
}

-(void)setNavarBar
{
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [self.view addSubview:naview];
    
    
    //设置返回按钮
    UIButton *leftBton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBton setFrame:CGRectMake(15, 20, 40, 40)];
    [leftBton setImage:[UIImage imageNamed:@"Arrow"] forState: UIControlStateNormal];
    [leftBton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBton];
    
    
    //设置Navigation的title
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(90, 25, 140, 30)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    [naview addSubview:t];
}

-(void)createTableView
{
    _projectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    _projectTableView.dataSource = self;
    _projectTableView.delegate = self;
    [self.view addSubview:_projectTableView];
}

-(void)loadData
{
    _projectArray = [NSMutableArray arrayWithCapacity:0];
    
    __weak ShowProjectViewController * weakSelf = self;
    [ProjectRequest found:^(NSArray * result) {
        NSLog(@"%@ZZZZZZZZZZZZZZZZZZZZ",result);
        [weakSelf getProjectModelObject:result];
        [weakSelf.projectTableView reloadData];
    } : 1 : 1 :1];
}

#pragma mark - tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_projectArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString* CELL=@"CELL";
    WLY_ProjectTableViewCell * cell=(WLY_ProjectTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CELL];
    
    if (cell == nil)
    {
        cell = [[WLY_ProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:CELL];
    }
    
    if ([_projectArray count]>0)
    {
        [cell setValue:[_projectArray objectAtIndex:indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}

-(void)getProjectModelObject:(NSArray *)resultDic
{
    
    //NSLog(@"%@88888888888888888",resultDic);
    
    /************NULL值后台处理************/
    //NSArray * array = [resultDic objectForKey:@"data"];
    //NSLog(@"%@12345678",array);
    for (NSDictionary * projectDic in resultDic)
    {
        ProjectModel * projectModel = [[ProjectModel alloc]initWithValueDic:projectDic];
        [_projectArray addObject:projectModel];
    }
}

-(void)backClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
