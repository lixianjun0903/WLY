//
//  MessageViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-14.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MessageViewController.h"
#import "MainCell.h"
#import "AttachedCell.h"
#import "UIButtonIndexPath.h"
@interface MessageViewController ()

@end

@implementation MessageViewController
-(void)fanhui{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setNavarBar
{
    
    
    UIButton*leftBton = [[UIButton alloc]initWithFrame:CGRectMake(10,20,40,40)];
    [leftBton setImage:[UIImage imageNamed:@"Arrow"]forState:UIControlStateNormal];
    [leftBton addTarget:self action:@selector(fanhui)forControlEvents:UIControlEventTouchUpInside];
    //UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBton];
    
    
    
    
//    self.navigationController.navigationBarHidden=YES;
//    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [self.view addSubview:naview];
    [naview addSubview:leftBton];
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 30)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    t.text = @"消息";
    [naview addSubview:t];

    
    
    
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setNavarBar];
    NSDictionary *dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
    
    self.arr=[[NSMutableArray alloc]init];
    NSDictionary *mydic=[NSDictionary dictionaryWithObjectsAndKeys:@"欢饮光临为庐阳",@"text",@"10月11日",@"day",@"cacacacacacacac",@"str", nil];
    NSDictionary *mydictwo=[NSDictionary dictionaryWithObjectsAndKeys:@"欢饮光临为庐阳",@"text",@"11月11日",@"day",@"cacacacacacacac",@"str", nil];
    NSDictionary *mydicthrr=[NSDictionary dictionaryWithObjectsAndKeys:@"欢饮光临为庐阳",@"text",@"12月11日",@"day",@"cacacacacacacac",@"str", nil];
        NSDictionary *mydicfrou=[NSDictionary dictionaryWithObjectsAndKeys:@"欢饮光临为庐阳",@"text",@"12月11日",@"day",@"cacacacacacacac",@"str", nil];
        NSDictionary *mydictfivr=[NSDictionary dictionaryWithObjectsAndKeys:@"欢饮光临为庐阳",@"text",@"12月11日",@"day",@"cacacacacacacac",@"str", nil];
    self.arr=[NSMutableArray arrayWithObjects:mydic,mydictwo,mydicthrr,mydicfrou,mydictfivr, nil];

    
    self.arrAttachedCell=[[NSMutableArray alloc] init];

    NSDictionary *diccc=[NSDictionary dictionaryWithObjectsAndKeys:@"nidasndiahdaihdioahdoihdoiahdad",@"text", nil];
    NSDictionary *diccctwo=[NSDictionary dictionaryWithObjectsAndKeys:@"我打短而恒大uhdioeah 爱的平",@"text", nil];
    NSDictionary *diccctwofddd=[NSDictionary dictionaryWithObjectsAndKeys:@"yyyyuhdioeahfytfytfft 爱的平",@"text", nil];

    self.arrAttachedCell=[NSMutableArray arrayWithObjects:diccc,diccctwo,diccctwofddd, nil];
    
    
    
    
   NSMutableArray* array = [[NSMutableArray  alloc] init];
    

    for (int i =0; i<[self.arr count]; i++) {
        [array addObject:dic];
    }
    self.dataArray = [[NSMutableArray alloc]init];
    self.dataArray = [NSMutableArray arrayWithArray:array];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,44, 320, self.view.frame.size.height)];
    view.backgroundColor=[UIColor whiteColor];
    
    _Mytabview=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 320,self.view.frame.size.height-44) style:UITableViewStylePlain];
    _Mytabview.backgroundColor=[UIColor whiteColor];
    _Mytabview.tag=100;
    _Mytabview.delegate=self;
    
    _Mytabview.dataSource=self;
    [view addSubview:_Mytabview];
    [self.view addSubview:view];

    
    // Do any additional setup after loading the view.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(void)aaaaa:(UIButtonIndexPath*)btn
{

    [self tableView:_Mytabview didSelectRowAtIndexPath:btn.indexPath ];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        static NSString *CellIdentifier = @"MainCell";
        MainCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        [cell setMainCell: [self.arr objectAtIndex:indexPath.row]];
        [cell.btnJiantou setIndexPath:indexPath ];
        [cell.btnJiantou addTarget:self action:@selector(aaaaa:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
        
    }else if([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"AttachedCell"]){
        
        static NSString *CellIdentifier = @"AttachedCell";
        AttachedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AttachedCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell   setcell: [self.arrAttachedCell objectAtIndex:indexPath.row-1]];

        return cell;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
        NSIndexPath *path = nil;
        
        if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"]) {
            path = [NSIndexPath indexPathForItem:(indexPath.row+1) inSection:indexPath.section];
            NSLog(@"AAAAAA");
            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            
            MainCell *cell=(MainCell*)[_Mytabview cellForRowAtIndexPath:index];
            [cell.btnJiantou setImage:[UIImage imageNamed:@"arrow_R"] forState:UIControlStateNormal];
 
            
            
            
        }else
        {
            path = indexPath;

        }
        if ([[self.dataArray[indexPath.row] objectForKey:@"isAttached"] boolValue])
        {
            //根据indexPath获得当前的CELL
            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row-1 inSection:0];

            MainCell *cell=(MainCell*)[_Mytabview cellForRowAtIndexPath:index];
            [cell.btnJiantou setImage:[UIImage imageNamed:@"arrow_R"] forState:UIControlStateNormal];
            // 关闭附加cell
            NSLog(@"bbbbbb");
            NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(NO)};
            self.dataArray[(path.row-1)] = dic;
            [self.dataArray removeObjectAtIndex:path.row];
            [_Mytabview beginUpdates];
            [_Mytabview deleteRowsAtIndexPaths:@[path]  withRowAnimation:UITableViewRowAnimationMiddle];
            [_Mytabview endUpdates];
        }else{
            // 打开附加cell
            NSLog(@"aaaaaaaaa");
             MainCell *cell=(MainCell*)[tableView cellForRowAtIndexPath:indexPath];
             [cell.btnJiantou setImage:[UIImage imageNamed:@"arrow_D"] forState:UIControlStateNormal];
            NSDictionary * dic = @{@"Cell": @"MainCell",@"isAttached":@(YES)};
            self.dataArray[(path.row-1)] = dic;
            NSDictionary * addDic = @{@"Cell": @"AttachedCell",@"isAttached":@(YES)};
            [self.dataArray insertObject:addDic atIndex:path.row];
            [_Mytabview beginUpdates];
            [_Mytabview insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
            [_Mytabview endUpdates];
            
        }
   

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.dataArray[indexPath.row] objectForKey:@"Cell"] isEqualToString:@"MainCell"])
    {
        return 50;
    }else{

        
        return 120;
    }
    
}

- (void)didReceiveMemoryWarning
    {
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
