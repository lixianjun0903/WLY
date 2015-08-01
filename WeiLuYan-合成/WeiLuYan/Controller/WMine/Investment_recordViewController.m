//
//  Investment_recordViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-17.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "Investment_recordViewController.h"
#import "investmentcellTableViewCell.h"
@interface Investment_recordViewController ()

@end

@implementation Investment_recordViewController
-(void)viewWillAppear:(BOOL)animated{
        _namearr=[NSArray arrayWithObjects:@"潘石屹",@"贝克汉姆",@"汤姆克鲁斯",@"亮亮",@"李雷",@"韩梅梅",@"周杰伦",@"小泽玛利亚",@"小泽玛利亚",@"奥特曼",@"悟空",@"二师兄",@"奥利弗", nil];
    [self setNavarBar];
}
-(void)setNavarBar
{
//    self.navigationController.navigationBarHidden=YES;
//    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [self.view addSubview:naview];
    
    
    UIButton*leftBton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBton setFrame:CGRectMake(15, 20, 40, 40)];
    [leftBton setImage:[UIImage imageNamed:@"Arrow"] forState: UIControlStateNormal];
    [leftBton addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBton];
    
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 30)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.text = @"投资记录";
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    [naview addSubview:t];
}
-(void)fanhuiBtn
{
    
}
#pragma MARK TAB-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    
    return 1;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [_namearr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *CellIdentifier=@"cellid";
    
    investmentcellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        cell=[[investmentcellTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.name.text=[_namearr objectAtIndex:indexPath.row];
        
    }
    cell.name.text=[_namearr objectAtIndex:indexPath.row];
    
    
    return cell;
    
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    _Mytabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    _Mytabview.tag=100;
        
    _Mytabview.delegate=self;
    
    _Mytabview.dataSource=self;
    [self.view addSubview:_Mytabview];

    
    // Do any additional setup after loading the view.
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
