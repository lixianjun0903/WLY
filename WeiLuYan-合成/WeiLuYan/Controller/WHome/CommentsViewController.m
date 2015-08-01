//
//  CommentsViewController.m
//  WeiLuYan
//
//  Created by weiluyan on 14-10-13.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "CommentsViewController.h"


@interface CommentsViewController ()

@end

@implementation CommentsViewController
-(void)fanhuiBtn{
    [_textview resignFirstResponder];

}
-(void)setNavarBar
{

    
    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
    [self.view addSubview:naview];
    
    
    UIButton*leftBton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBton setFrame:CGRectMake(0, 20, 50, 40)];
    [leftBton setImage:[UIImage imageNamed:@"Arrow"] forState: UIControlStateNormal];
    [leftBton addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBton];
    
    
    UIButton*repeat_sent=[UIButton buttonWithType:UIButtonTypeCustom];
    [repeat_sent setFrame:CGRectMake(230,15,100,50)];
    [repeat_sent setImage:[UIImage imageNamed:@"repeat_sent"] forState: UIControlStateNormal];
    [repeat_sent addTarget:self action:@selector(fanhuiBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:repeat_sent];
    
    
    
    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 30)];
    t.font = [UIFont systemFontOfSize:20];
    t.textColor = [UIColor whiteColor];
    t.backgroundColor = [UIColor clearColor];
    t.textAlignment = NSTextAlignmentCenter;
    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
    t.text = @"评论";
    [naview addSubview:t];
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    [self setNavarBar];
    
}
-(void)BIAOQING
{

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[GeneralizedProcessor hexStringToColor:@"#eeeae7"];
    _mytabview=[[UITableView alloc]initWithFrame:CGRectMake(0,30
                                                            , 320, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _mytabview.backgroundColor=[UIColor clearColor];
    _mytabview.tag=100;
    _mytabview.delegate=self;
    _mytabview.dataSource=self;
    _mytabview.scrollEnabled = NO;
    [self.view addSubview:_mytabview];
    
//    UIButton *image=[[UIImageView alloc]initWithFrame:CGRectMake(10,270, 25, 25)];
//    image.image=[UIImage imageNamed:@"Comment_emoji"
//    
//    [self.view addSubview:image];
                 UIButton*nextButton=[UIButton  buttonWithType:UIButtonTypeCustom];
                 [nextButton addTarget:self action:@selector(BIAOQING) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"Comment_emoji"] forState:UIControlStateNormal];
                 nextButton.frame=CGRectMake(10, 270, 25, 25);
                 [self.view addSubview:nextButton];

    

    // Do any additional setup after loading the view.
}
#pragma MARK TAB-----
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    
    return 10;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    
    return 1;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    NSString *CellIdentifier=@"cellid";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        
    
        
    }
    
    _textview = [[TextLimitView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [cell addSubview:_textview];

    
    return cell;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textview resignFirstResponder];
    
    
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
