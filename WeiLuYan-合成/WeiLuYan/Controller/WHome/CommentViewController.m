//
//  CommentViewController.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-23.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "CommentViewController.h"
#import "WLY_CommentTableViewCell.h"
#import "FeedItemCell.h"
#import "CommentRequest.h"
#import "CommentObject.h"
#import "FeedRequest.h"
#import "GeneralizedProcessor.h"

#define kWinSize [UIScreen mainScreen].bounds.size

@interface CommentViewController ()
{
    MJRefreshHeaderView * _header;
    MJRefreshFooterView * _footer;
}
@property( nonatomic, strong)NSMutableArray*commentArray;
@property( nonatomic, strong)CommentObject1*addCommentObject;
@property( nonatomic, strong)CommentObject1*addReplyCommentObject;
@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTableView];
    
    _commentArray=[NSMutableArray array];
    [_commentArray insertObject:_forwardFeedObject atIndex:0];
  
    [_header beginRefreshing];
    _number=1;
  
    if (_isCommentBton==YES) {
        [self commentTimeline];
    }

    [self refreshViewBeginRefreshing:nil];
}
-(void)createTableView
{
    _mainTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    _mainTableView.delegate=self;
    _mainTableView.dataSource=self;
    [_mainTableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_mainTableView];

}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [CommentRequest getFeedCommentFromID:^(NSArray *commentDic)
    {
        __weak CommentViewController* weakSelf=self;
        [weakSelf getCommentArray:commentDic];
        [weakSelf.commentArray addObjectsFromArray:_refreshDataArray];
        [weakSelf.mainTableView reloadData];
    } : _forwardFeedObject.feedcontent_id:(int)_number];
}

-(void)getCommentArray:(NSArray*)dataArray
{
    _refreshDataArray=[NSMutableArray array];
    for ( int i=0; i<[dataArray count]; i++)
    {
        CommentObject1 *commentObject=[[CommentObject1  alloc]initWithValueDic:[dataArray objectAtIndex:i]];
        [_refreshDataArray addObject:commentObject];
    }
}

- (void)refreshViewEndRefreshing:(MJRefreshBaseView *)refreshView
{
    _number++;
}


//-(void)fanhui
//{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    [self.tabBarController.tabBar setHidden:YES];
//
//
//
//    UIButton*leftBton = [[UIButton alloc]initWithFrame:CGRectMake(10,20,50,40)];
//    [leftBton setImage:[UIImage imageNamed:@"Arrow"]forState:UIControlStateNormal];
//    [leftBton addTarget:self action:@selector(fanhui)forControlEvents:UIControlEventTouchUpInside];
//    //UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBton];
//    
////    self.navigationController.navigationBarHidden=YES;
////    [self.navigationController.navigationBar setBarTintColor:[GeneralizedProcessor hexStringToColor:colorRead]];
//    
//    UIView *naview=[[UIView alloc]initWithFrame:CGRectMake(0,0, 320, 64)];
//    naview.backgroundColor=[GeneralizedProcessor hexStringToColor:colorRead];
//    [self.view addSubview:naview];
//    [naview addSubview:leftBton];
//    
//    UILabel *t = [[UILabel alloc] initWithFrame:CGRectMake(110, 25, 100, 30)];
//    t.font = [UIFont systemFontOfSize:20];
//    t.textColor = [UIColor whiteColor];
//    t.backgroundColor = [UIColor clearColor];
//    t.textAlignment = NSTextAlignmentCenter;
//    t.font=[UIFont fontWithName:@"Helvetica-BoldOblique" size:20];
//    t.text = @"评论";
//    [naview addSubview:t];
//
//
//
//
//}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_commentArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL_CONTENT";
    
    if (indexPath.row==0)
    {
      FeedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil)
        {
              cell=[[FeedItemCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [cell setData:[_commentArray objectAtIndex:0]];
//        [cell.customerView.commentBton addTarget:self action:@selector(commentTimeline) forControlEvents:UIControlEventTouchUpInside];
//        [cell.customerView.emogLikeBton addTarget:self action:@selector(likeBton:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.customerView.goodBton setIndexPath:indexPath];
        
        return cell;
    }
    
     static NSString *CommentCellIdentifier = @"CELL_Comment";
    WLY_CommentTableViewCell*commentCell=[tableView dequeueReusableCellWithIdentifier:CommentCellIdentifier];
    
    if (commentCell==nil)
    {
        commentCell=[[WLY_CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CommentCellIdentifier];
        
    }
   [commentCell setCommentObjectValue:[_commentArray objectAtIndex:indexPath.row] ];
   return   commentCell;
}

//
//-(void)likeBton:(UIButton*)sender
//{
//    
//  
//    ForwardFeedObject*getForwardFeedObject=[_commentArray objectAtIndex:0];
//   [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"is_approval",[getForwardFeedObject.data_approval objectForKey:@"new_user"],@"new_user", nil];
//    
//    if ([[getForwardFeedObject.data_approval objectForKey:@"is_approval"] intValue]==1)
//    {
//        
//        getForwardFeedObject.data_approval= [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"is_approval",[getForwardFeedObject.data_approval objectForKey:@"new_user"],@"new_user", nil];
//        
//        [sender setImage:[UIImage imageNamed:@"home_emoji_G"] forState:UIControlStateNormal];
//        [FeedRequest dislikeFeed:^(NSDictionary *feedDicr) {
//                    NSLog(@"取消点赞成功");
//        } :getForwardFeedObject.feedcontent_id];
//        
//    }else
//    {
//        getForwardFeedObject.data_approval= [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"is_approval",[getForwardFeedObject.data_approval objectForKey:@"new_user"],@"new_user", nil];
//        [sender setImage:[UIImage imageNamed:@"home_emoji_R"] forState:UIControlStateNormal];
//        [FeedRequest likeFeed:^(NSDictionary *feedDic) {
//            NSLog(@"点赞成功");
//        } :getForwardFeedObject.feedcontent_id];
//    }
//}

-(void)commentTimeline
{
   [_mainTableView scrollToRowAtIndexPath:[GeneralizedProcessor getNewSection:0 :[_commentArray count]-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if(self.key==nil){
        self.key=[[YcKeyBoardView alloc]initWithFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
    }else{
        [self.key setFrame:CGRectMake(0, kWinSize.height-44, kWinSize.width, 44)];
        CGRect rect=CGRectMake(10 ,4, 300, 36);
        [self.key.textView setFrame:rect];
        }
    self.key.delegate=self;
    [self.key.textView becomeFirstResponder];
    self.key.textView.returnKeyType=UIReturnKeySend;
    [self.view addSubview:self.key];
    
}
-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    self.keyBoardHeight=deltaY;
   [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.key.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        self.key.textView.text=@"";
        [self.key removeFromSuperview];
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   
    [self.key.textView resignFirstResponder];
    
}
-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView
{
    [contentView resignFirstResponder];
    if (_addCommentObject)
    {
        int memberID=_addCommentObject.commentPersonModel.member_id;
        int feedContentID=_forwardFeedObject.feedcontent_id;
        NSString*content=contentView.text;
        _addCommentObject=nil;
        
        [CommentRequest addCommentRely:^(NSDictionary *commentDic)
         {
                __weak CommentViewController*weakSelf=self;

                   [weakSelf changeCommentCountValue];
                    _number=1;
                     [weakSelf.commentArray removeObjectsInRange: NSMakeRange(1, [self.commentArray count]-1)];
//                     [weakSelf refreshViewBeginRefreshing:_footer];
//                     [weakSelf refreshViewEndRefreshing:_footer];
            
        } :feedContentID  :memberID :content];
        
        
    }else
    {
            [CommentRequest sendComment:^(NSDictionary *commentDicerror)
    {
        __weak CommentViewController*weakSelf=self;
        
            [weakSelf changeCommentCountValue];
                   _number=1;
                [weakSelf.commentArray removeObjectsInRange: NSMakeRange(1, [self.commentArray count]-1)];
//            [weakSelf refreshViewBeginRefreshing:_footer];
//            [weakSelf refreshViewEndRefreshing:_footer];
    } :_forwardFeedObject.feedcontent_id :contentView.text];
    
    }
}

-(void)changeCommentCountValue
{
 _forwardFeedObject.comment_count++;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        FeedItemCell*cell=[[FeedItemCell alloc]init];
//        [getHeightCell setData:[_commentArray objectAtIndex:0]];
        return cell.CellHeight;
        //return cell.CellHeight;
    }
    
    WLY_CommentTableViewCell*getCellComment=[[ WLY_CommentTableViewCell alloc]init];
    return  [getCellComment getHeightFrom:[_commentArray objectAtIndex:indexPath.row]];

    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row!=0)
    {
        _addCommentObject=[self.commentArray objectAtIndex:indexPath.row];
        [self commentTimeline];
        
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
