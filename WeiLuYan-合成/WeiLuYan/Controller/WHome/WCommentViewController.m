//
//  WCommentViewController.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WCommentViewController.h"
#import "WContentCell.h"
#import "FeedRequest.h"
#import "CommentRequest.h"
#import "AccountModel.h"
#import "MBProgressHUD+Show.h"

@interface WCommentViewController ()<UITableViewDataSource,UITableViewDelegate,YcKeyBoardViewDelegate,UIAlertViewDelegate>

{
    NSMutableArray * _dataArray;
    AFRequestState * _state;
    int page;
    
}
@end

@implementation WCommentViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    page = 1;
    _dataArray = [NSMutableArray arrayWithCapacity:0];
    
    [self initView];
    [self loadHeaderViewData];
    [self loadData:nil Num:page];
    
}

-(void)loadHeaderViewData
{
    [_commentHeaderView loadData:_Data];
}

- (void)initView
{
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle = NO;
    
    _footer = [MJRefreshFooterView footer];
    _footer.scrollView = self.mainTableView;
    _footer.delegate = self;
    [self keyBoardBlock];
}

-(void)keyBoardBlock
{
    _commentHeaderView.keboardBlock = ^(void)
    {
        [self initKyeBoard];
    };
}
//初始化键盘
-(void)initKyeBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, 460, 320, 44)];
    }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    [self.view addSubview:self.key];
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
        _Data.project_comment_count++;
        [self loadData:nil Num:1];
        [self loadHeaderViewData];
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
-(void)dealloc
{
    [_footer free];
    [_header free];
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if( refreshView == _header ){
        
    }
    else{
        [self loadData:refreshView Num:page + 1];
    }
}
- (void)loadData:(id)notify Num:(int)num
{
    if( _state.running ){
        return;
    }
    if(notify == nil)
    {
        _state=[CommentRequest getFeedRequest:^(NSArray *feedDic) {
            
            for (NSDictionary *dic  in feedDic) {
                
                [_dataArray addObject:dic];
                
            }
            
            [_mainTableView reloadData];
            
            
        } :[_Data.project_id intValue] :num];
    }else
    {
        _state=[[CommentRequest getFeedRequest:^(NSArray *feedDic) {
            
            
            
            for (NSDictionary *dic  in feedDic) {
                
                [_dataArray addObject:dic];
                
            }
            
            [_mainTableView reloadData];
            
            
        } :[_Data.project_id intValue] :num] addNotifaction:notify];
    }
    
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if(cell == nil)
    {
        cell = [[NSBundle mainBundle]loadNibNamed:@"WContentCell" owner:nil options:nil][0];
    }
    
    [cell  loadData:[_dataArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
