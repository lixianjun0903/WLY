//
//  TableViewController.m
//  tabviewcon
//
//  Created by weiluyan on 15/2/2.
//  Copyright (c) 2015年 JX. All rights reserved.
//

#import "UserTableViewController.h"
#import "UserTableViewCell.h"
#import "MyLaberTableViewCell.h"
#import "WSetViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD+Show.h"
#import "UserInfoRequest.h"
#import "PersonJudge.h"

@interface UserTableViewController ()
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSDictionary *dicd;
@property(nonatomic,strong)NSMutableArray *laberArray;
@property (nonatomic,strong) AFRequestState * state;
@property(nonatomic,assign)int useridd;
@property (nonatomic,retain) PersonJudge * permod;

@end

@implementation UserTableViewController

+ (instancetype)loadBreakView{
    return [[[NSBundle mainBundle] loadNibNamed:@"TableViewController" owner:self options:nil] lastObject];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  
    
    if (indexPath.row==0) {
        UserTableViewCell *cell = [UserTableViewCell cellWithTableView:tableView];
        [cell setmod:_dicd];
        return cell;
    }else if (indexPath.row==4)
    {
    
        MyLaberTableViewCell* cell = nil;
        static NSString *CellIdentifier = @"Cell2";
        
        cell = (MyLaberTableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[MyLaberTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        }
      
        cell.myArry=_laberArray;
        [cell setLabertext:_laberArray ];
        return cell;

    }
    else
    {
    
        UITableViewCell* cell = nil;
        static NSString *CellIdentifier = @"Cell1";
        cell = (UITableViewCell*)[tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
        }

        UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_open_selecten"]];
        
        image.frame=CGRectMake(290, 15, 10, 10);
//        image.image=[UIImage imageNamed:@"btn_open_selecten"];
        [cell addSubview:image];
        
        if (indexPath.row==1) {
            cell.textLabel.text=@"发起项目";
        }if (indexPath.row==2) {
            cell.textLabel.text=@"投资记录";

        }if (indexPath.row==3) {
            cell.textLabel.text=@"关注的项目";

        }        
        return cell;
    
    
    }
   
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{


    if (indexPath.row==0) {
        return 140;
    }else if (indexPath.row==4)
    {
    
    
        return self.view.frame.size.height-140-120;
    
    }
    
    else
    {
        return 40;

    
    }
    
    

}
///////////////////////////////////////////原有方法////////////////////////
-(void)viewWillAppear:(BOOL)animated
{
    
    
    [self loadData];
    _laberArray=[NSMutableArray array];
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
}
-(void)createNav
{
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 60, 30);
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [rightButton setTitleColor:[GeneralizedProcessor hexStringToColor:@"e61300"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
}

-(void)buttonClick:(UIButton *)sender
{
    
    WSetViewController * set = [WSetViewController new];
    [self.navigationController pushViewController:set animated:YES];
    
}

-(void)loadData
{
   
    if(self.state.running){
        return;
    }
    
    MBProgressHUD * mbHud = [MBProgressHUD mbHubShow];
    
//    self.state = [[UserInfoRequest getUserInfoID:^(NSDictionary *userDic) {
//        
//        if (self.useridd == [[AccountModel instance] personInfoModel].member_id || self.useridd == nil) {
//            [self createNav];
//        }
//         _permod = [[PersonJudge alloc]init];
//       __weak UserTableViewController * weakSelf = self;
//        [weakSelf.permod  setValuesForKeysWithDictionary:userDic];
//         _laberArray = userDic[@"tag_arr"];
//          NSLog(@"aaaaaaaaaa=suedic=%@",userDic);
//        [self.tableView reloadData];
//        
//        _dicd=[NSDictionary dictionaryWithObjectsAndKeys:weakSelf.permod.nick_name,@"name",[userDic objectForKey:@"job_status"],@"job",[userDic objectForKey:@"avatar"],@"avatar", nil];
//  
//    } userid:_useridd] addNotifaction:mbHud];
//    
    
    
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
