//
//  Comment.m
//  WLY-TeamCommentView
//
//  Created by weiluyan on 14/12/30.
//  Copyright (c) 2014年 JX. All rights reserved.
//

#import "Comment.h"
#import "CommentTableViewCell.h"
#import "MJRefresh.h"
#import "CommentRequest.h"
#import "CollectMoneyRequest.h"
#import "MBProgressHUD+Show.h"
#import "PublishCommentViewController.h"
#import "AppDelegate.h"

@interface Comment ()<MJRefreshBaseViewDelegate,YcKeyBoardViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
//    MJRefreshHeaderView * header;
    MJRefreshFooterView * footer;
    AFRequestState * _state;
    int page;
}
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation Comment
@synthesize cell;
alloc_with_xib(CommentView)

-(void)awakeFromNib
{
    _myTabView.showsVerticalScrollIndicator = NO;
    [self createRefresh];
}

-(void)dealloc
{
    [footer free];
}

#pragma mark 创建刷新
-(void)createRefresh
{
    page = 1;    
    if( footer == nil )
    {
        footer = [MJRefreshFooterView footer];
        footer.scrollView = _myTabView;
        footer.delegate = self;
    }
}

-(void)initKyeBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, 220, 320, 44)];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    [self addSubview:self.key];
}

-(void)keyboardShow:(NSNotification *)notify
{
    CGRect keyBoardRect=[notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
    [UIView animateWithDuration:[notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}

-(void)keyboardHide:(NSNotification *)notify
{
    [UIView animateWithDuration:[notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.key.textView)
    {
        [self.key.textView endEditing:YES];
        [self.key removeFromSuperview];
    }
}

-(void)recoverKeybord
{
    [self.key.textView endEditing:YES];
    [self.key removeFromSuperview];
}

-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    if(contentView.text.length == 0)
    {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入评论内容" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        
        return;
    }
    
    [contentView resignFirstResponder];
    
    MBProgressHUD * mbHud = [MBProgressHUD mbHubShow];
    
    [CommentRequest sendComment:^(NSDictionary *commentDic) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        //评论次数加一
        self.Data.comment_count ++;
        self.listData.project_comment_count ++;
        [self loadData:nil Num:1];
        
        [mbHud removeFromSuperview];
        
        [MBProgressHUD creatembHub:@"评论成功"];
    } :[_Data.project_id intValue] :contentView.text];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self.key.textView endEditing:YES];
        
        //移除输入框
        [self.key removeFromSuperview];
        
    }
}


- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
        page ++;
        [self loadData:refreshView Num: page];
    
}

- (void)loadData:(id)notify Num:(int)num
{
    if( _state.running ){
        return;
    }
    if(notify == nil)
    {
        page = 1;
        _dataArray = [NSMutableArray arrayWithCapacity:0];
        _state=[CommentRequest getFeedRequest:^(NSArray *feedDic) {
            
            for (NSDictionary *dic  in feedDic) {
                
                [_dataArray addObject:dic];
            }
            [_myTabView reloadData];
            
        } :_project_id :num];
    }else
    {
        _state=[[CommentRequest getFeedRequest:^(NSArray *feedDic) {
        
            for (NSDictionary *dic  in feedDic) {
                
                [_dataArray addObject:dic];
            }
            [_myTabView reloadData];
            
        } :_project_id :num] addNotifaction:notify];
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 30, 30);
    [button setImage:[UIImage imageNamed:@"home_ic_edit"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 60, 30)];
    label.text = @"发表评论";
    label.textColor = [GeneralizedProcessor hexStringToColor:@"ea2a2a"];
    label.font = [UIFont systemFontOfSize:14];
    [view addSubview:label];
    
    UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 60, 20)];
    number.text = [NSString stringWithFormat:@"共%d条评论",_dataArray.count];
    number.font = [UIFont systemFontOfSize:11];
    [view addSubview:number];
    return view;
}

#pragma mark 发表评论
-(void)publishClick
{
    PublishCommentViewController * vc = [PublishCommentViewController new];
    [[AppDelegate getNav] pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 90;
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
    
    static NSString *ID = @"mainBreakCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"CommentTabViewCell"
                                            owner:self options:nil][0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //添加数据
    [cell config:self.dataArray[indexPath.row]];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSDictionary * dic = self.dataArray[indexPath.row];
    NSString * str = dic[@"content"];
    //CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(cell.frame.size.width, 500)];
    
    return cell.contentView.frame.size.height + size.height - 10;
}


@end
