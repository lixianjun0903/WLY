//
//  WLY_UserDateTableViewCell.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-18.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedItemCell.h"
#import "FeedButtonView.h"
#import "FeedContentView.h"
#import "AppDelegate.h"
#import "ActiveObject.h"
#import "UIButton+WebCache.h"
#import "GeneralizedProcessor.h"
#import "CommentViewController.h"
#import "ShareActivity.h"
#import "FeedApprovalView.h"
#import "FeedRequest.h"
#import "AccountModel.h"
#import "RaisMoneyView.h"
#import "WCommentViewController.h"
#import "WCollectMoneyViewController.h"
#import "CollectMoneyObject.h"
#import "WMineViewController.h"
#import "descAlertView.h"
#import "CommentRequest.h"
#import "MBProgressHUD+Show.h"
#import "MBProgressHUD.h"
#import "CollectMoneyRequest.h"
#import "new_userObject.h"
#import "ShareView.h"

#define CELL_ICON_WIDTH_HEIGHT 44
#define ICON_AND_WORD_LEFT_AND_RIGHT 15

@interface FeedItemCell()
{
    BOOL _approvalLoad;
    UILabel *_addLabel;
}

@property (weak, nonatomic) IBOutlet FeedContentView *allContentView;
@property (weak, nonatomic) IBOutlet FeedButtonView *buttonView;
@property (weak, nonatomic) IBOutlet RaisMoneyView *raiseMoneyView;

@property( nonatomic, strong) FeedApprovalView * approvalView;
@property (nonatomic,strong) descAlertView * alert;
@property(nonatomic,assign) BOOL flag;
@property(nonatomic,strong) UIButton * collectBtn;
@property (nonatomic, assign) int projectID;
@property(nonatomic,strong) UITableViewCell * cell;
@end

@implementation FeedItemCell

-(void)initView
{
     self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    _approvalView = [[FeedApprovalView alloc] initWithFrame:CGRectMake(10,450, CGRectGetWidth(_buttonView.frame), 55)];
    
    _approvalView.hidden = NO;
    _approvalView.backgroundColor = [UIColor whiteColor];
    _approvalView.Controller = _Controller;
    
    [self.contentView addSubview:_approvalView];
    self.contentView.userInteractionEnabled = YES;
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHide) name:UIKeyboardWillHideNotification object:nil];
    [self click];
}

-(void)keybordShow
{
    _Controller.view.frame = CGRectMake(0, -180, _Controller.view.frame.size.width,_Controller.view.frame.size.height);
}

-(void)keybordHide
{
    _Controller.view.frame = CGRectMake(0, 50, _Controller.view.frame.size.width, _Controller.view.frame.size.height);
}

-(void)setCellType:(FeedCellType)CellType
{
       _buttonView.emojiBtn.selected = _ActData.data_approval.is_approval;
    _CellType = CellType;
    
    if(self.CellType == Project)
    {
        _allContentView.hidden = YES;
        _raiseMoneyView.hidden = NO;
        
        _buttonView.emojiBtn.hidden = YES;
        _buttonView.commentBtn.hidden = YES;
        _headerView.collectBtn.hidden = YES;
        _buttonView.commentLabel.hidden = YES;
        [_buttonView.favoriteBtn setImage:[[UIImage alloc] init] forState:UIControlStateNormal];

        self.flag = [_Data.favorite_status intValue];
        if(self.flag){
            
            [_buttonView.bgBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_highlight"] forState:UIControlStateNormal];
        }
        else{
            
            [_buttonView.bgBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_default"] forState:UIControlStateNormal];

        }
    }
    else
    {

        
        _CellBG.frame = CGRectMake(10, 19, 300, 336);
        _buttonView.frame = CGRectMake(0, 294, 300, 42);
        _approvalView.frame = CGRectMake(10, 336, _approvalView.frame.size.width, _approvalView.frame.size.height);
        
        _allContentView.hidden = NO;
        _raiseMoneyView.hidden = YES;
        _raiseMoneyView.contentBgView.hidden = YES;
    }
}

-(void)click
{
    
    [_headerView.userIcon addTarget:self action:@selector(icon) forControlEvents:UIControlEventTouchUpInside];

    
    [_buttonView.UpCommentBtn addTarget:self action:@selector(comment) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView.UpUserBtn addTarget:self action:@selector(approvalList) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonView.UpFavoriteBtn addTarget:self action:@selector(favorite:) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView.bgBtn addTarget:self action:@selector(approvalList) forControlEvents:UIControlEventTouchUpInside];
    [_buttonView.UpShareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self approval_icon:((FeedApprovalView *)object).click_id];
}

#pragma mark property

-(void)setData:(CollectMoneyObject*)feedData
{

    _Data = feedData;
    _projectID = [_Data.project_id intValue];
    [_headerView setPersonInfo:_Data];
    
    [_raiseMoneyView setData:_Data];
    
    [_buttonView setData:_Data];
    
    _approvalLoad = NO;
}

-(void)setActData:(ActivityInfo *)actData
{
    _ActData = actData;
    _projectID = _ActData.feedcontent_id;
    [_headerView setActivityInfo:_ActData];
    
   [_allContentView setActData:_ActData];
    
    [_buttonView setActData:_ActData];

}
-(void)setStyle:(FeedCellType)Style
{
    _Style = Style;
    
    BOOL isExpand = [self isExpand];
    [_approvalView setApproval:_ActData.data_approval];
    if( ! _approvalLoad && isExpand )
    {
        _approvalLoad = YES;
    }
    
    if( isExpand || _approvalView == nil ){
        NSLog(@"");
    }
    
    _approvalView.hidden = ! isExpand;
}

-(CGFloat)getCellHeight
{
    return [FeedItemCell getCellHeight:_Style];
}

-(BOOL)isExpand
{
    return (_Style & Expand);
}


+(CGFloat)getCellHeight:(NSInteger)style
{
    float height = 450;
    
    if( (style & Expand) == Expand){
        
        height += 55;
    }
    
    return height;
}

#pragma mark - 四个button click

-(void)favorite:(UIButton *)sender
{
    [_addLabel removeFromSuperview];
    if(! _ActData.data_approval.is_approval ){
        [FeedRequest likeFeed:^(NSDictionary *feedDic) {
             _ActData.data_approval.is_approval = ! _ActData.data_approval.is_approval;
            NSArray *array = [feedDic objectForKey:@"approval_user_list"];
            NSMutableArray *mutableArray = [NSMutableArray array];
            for (NSDictionary *dic in array) {
                NSString *avatar = [dic objectForKey:@"U_User_Avatar"];
                NSString *member_id = [dic objectForKey:@"U_User_ID"];
                int int_id = [member_id intValue];
                NSNumber *number_id = [NSNumber numberWithInt:int_id];
                new_userObject *new_user = [new_userObject new];
                [new_user setValue:avatar forKey:@"avatar"];
                [new_user setValue:number_id forKey:@"member_id"];
                [mutableArray addObject:new_user];
            }
            _ActData.data_approval.new_user = mutableArray;
            
            [_buttonView updateApproval];
            _buttonView.emojiBtn.selected = _ActData.data_approval.is_approval;
             [_approvalView setApproval:_ActData.data_approval];
        } :_ActData.feedcontent_id];
        
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];

        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];

        _addLabel.text = @"+1";
        _addLabel.textColor = [UIColor redColor];
        [_buttonView.emojiBtn addSubview:_addLabel];
        [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            _addLabel.frame = CGRectMake(20, -10, 20, 20);
            _addLabel.frame = CGRectMake(30, -5, 20, 20);
        } completion:^(BOOL finished) {
            [_addLabel removeFromSuperview];
        }];
    }
    else{
        
        [FeedRequest dislikeFeed:^(NSDictionary *feedDic) {
             _ActData.data_approval.is_approval = ! _ActData.data_approval.is_approval;
            NSArray *resultArray = [feedDic objectForKey:@"approval_user_list"];
            NSNumber *approvalCount = [feedDic objectForKey:@"approval_num"];
            NSMutableArray *mutableArray = [NSMutableArray array];
            if ([approvalCount intValue] == 0) {
                _ActData.data_approval.new_user = mutableArray;
            }else{
                for (NSDictionary *dic in resultArray) {
                    NSString *avatar = [dic objectForKey:@"U_User_Avatar"];
                    NSString *member_id = [dic objectForKey:@"U_User_ID"];
                    int int_id = [member_id intValue];
                    NSNumber *number_id = [NSNumber numberWithInt:int_id];
                    new_userObject *new_user = [new_userObject new];
                    [new_user setValue:avatar forKey:@"avatar"];
                    [new_user setValue:number_id forKey:@"member_id"];
                    [mutableArray addObject:new_user];
                }
                _ActData.data_approval.new_user = mutableArray;
            }
            [_buttonView updateApproval];
            _buttonView.emojiBtn.selected = _ActData.data_approval.is_approval;
             [_approvalView setApproval:_ActData.data_approval];
        } :_ActData.feedcontent_id];
    }
    
    if( _Data.data_approval.isEmpty && self.isExpand ){
        self.Style ^= Expand;
    }
}


-(void)comment
{
    _alert = [[descAlertView alloc] initWithFrame:_Controller.view.frame];
    [_alert setTitle:@"评论" buttonTitle:@"发布"];
    __weak FeedItemCell * feed = self;
    _alert.cancle = ^{
        [feed.alert removeFromSuperview];
    };
    _alert.ensure = ^(NSString * str){
       
        if([str isEqualToString:@""]){
            UIAlertView * view = [[UIAlertView alloc] initWithTitle:nil message:@"请输入评论内容" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [view show];
            return ;
        }
        [CommentRequest sendComment:^(NSDictionary *commentDic) {
            
            [feed.alert removeFromSuperview];
            [MBProgressHUD creatembHub:@"评论成功"];
            
        } :feed.ActData.feedcontent_id :str];

    };
    [self.Controller.view addSubview:_alert];

}

-(void)share
{

    ShareView *pageOneView = [[ShareView alloc] initWithViewController:_Controller ID:_projectID];
    [pageOneView show];
    
//    pageOneView.tag = 11;
//    [self.window addSubview:pageOneView];

    
//    ShareActivity * share = [[ShareActivity alloc] initWithTitle:@"分享到..." cancelButtonTitle:@"取消" viewController:_Controller isTransfer:YES ID:_projectID];
//    share.cancelBlock = ^
//    {
//       
//    };
//    
//    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
//    
//    [share show];
}

#pragma mark 点击关注
-(void)collectClick
{
    _collectBtn.selected = self.flag;
    if(!self.flag){
      //  int num = [self.Data.project_id intValue];
        [CollectMoneyRequest collectFinanceCollectWithId:[self.Data.project_id intValue] with:^(NSDictionary *result) {
            //成功
            self.flag = !self.flag;
            _collectBtn.selected = self.flag;
            [self refreshButton];
            [MBProgressHUD creatembHub:@"关注成功"];
           
            self.reLoadBlock();
        }];
    }
    else{
        [CollectMoneyRequest collectFinanceUnCollectWithId:[self.Data.project_id intValue] with:^(NSDictionary *result) {
            self.flag = !self.flag;
            _collectBtn.selected = self.flag;
            [self refreshButton];
            [MBProgressHUD creatembHub:@"已取消关注"];
           
            self.reLoadBlock();
        }];
    }

}

-(void)refreshButton
{
    _collectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

    if (self.flag) {
        
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_highlight"] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(unCollectBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    else
    {
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_default"] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
}
#pragma mark 取消关注
-(void)unCollectBtnClick:(UIButton *)sender
{
    [_collectBtn removeTarget:self action:@selector(unCollectBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [CollectMoneyRequest collectFinanceUnCollectWithId:[self.Data.project_id intValue] with:^(NSDictionary *result) {
        self.flag = !self.flag;
        [self refreshButton];
        [MBProgressHUD creatembHub:@"已取消关注"];
        //上级页面重新获取数据，刷新页面。
        self.reLoadBlock();
        
    }];
}


-(void)collectBtnClick:(UIButton *)sender
{
    [_collectBtn removeTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    
    [CollectMoneyRequest collectFinanceCollectWithId:[self.Data.project_id intValue] with:^(NSDictionary *result) {
        //成功
        self.flag = !self.flag;
        [self refreshButton];
        [MBProgressHUD creatembHub:@"关注成功"];
        //上级页面重新获取数据，刷新页面。
        self.reLoadBlock();
        
        
    }];
}

#pragma mark - 点赞头像下拉展示
-(void)approvalList
{
    if(_CellType == Project){
        [self collectClick];
    }
    else{
        if( _Data.data_approval.isEmpty ){
            return;
        }
        
        self.Style ^= Expand;
    }
    
}

#pragma mark - 下拉头像点击函数
-(void)approval_icon:(int)member_id
{
    
    if(self.CellType == Home)
    {
        WMineViewController * vc = [[WMineViewController alloc] init];
        vc.useridd = _ActData.data_user.member_id;
        [_Controller.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
        WMineViewController * vc = [[WMineViewController alloc] init];
        vc.useridd = [_Data.project_user_id intValue];
        [_Controller.navigationController pushViewController:vc animated:YES];
    }

    
}

#pragma mark - 自己头像点击函数
-(void)icon
{
    if(self.CellType == Home)
    {
        WMineViewController * vc = [[WMineViewController alloc] init];
        vc.useridd = _ActData.data_user.member_id;
        [_Controller.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
        WMineViewController * vc = [[WMineViewController alloc] init];
        vc.useridd = [_Data.project_user_id intValue];
        [_Controller.navigationController pushViewController:vc animated:YES];
    }
}

@end
