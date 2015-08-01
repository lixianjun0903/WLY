//
//  ActivityButtonView.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityButtonView.h"
#import "UIButton+WebCache.h"
#import "ShareActivity.h"
#import "AppDelegate.h"
#import "CommentRequest.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Show.h"
#import "FeedRequest.h"
#import "ShareView.h"

@implementation ActivityButtonView
alloc_with_xib(ActButtonView)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}

-(void)awakeFromNib
{
    _userApprovalBtn.layer.masksToBounds = YES;
    _userApprovalBtn.layer.cornerRadius = _userApprovalBtn.frame.size.width/2;
    _isExpand = NO;
}

#pragma mark button赋值
-(void)setButtonData:(ActivityInfo *)model

{

    if(_ActData != nil)
    {
        [_ActData.data_approval removeObserver:self forKeyPath:@"is_approval"];
        
        //评论数
        
        //[_ActData removeObserver:self forKeyPath:@"comment_count"];
        
        //        [_ActData removeObserver:self forKeyPath:@"comment_count"];
        
    }
   
    _ActData = model;
    
    _ID = _ActData.feedcontent_id;
    
    [model.data_approval addObserver:self forKeyPath:@"is_approval" options:NSKeyValueObservingOptionNew context:nil];

    _approvalBtn.selected = model.data_approval.is_approval;
    
    [self updateApproval];
    [self updateComment];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateApproval];
}

#pragma mark 更新评论
-(void) updateComment
{
    _commentCountLabel.text = [NSString stringWithFormat:@"%d", _ActData.comment_count];
    
}

#pragma mark 更新点赞头像
-(void)updateApproval
{
    NSLog(@"updateApproval>>>>%d",_ActData.data_approval.is_approval);
    
    _approvalCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_ActData.data_approval.new_user count]];
    
    if(_ActData.data_approval.is_approval)
    {
        AccountModel * model = [AccountModel instance];
        NSString * str = model.personInfoModel.avatar;
        if(str.length == 0)
        {
            [_userApprovalBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        }
        else
        {
            [_userApprovalBtn sd_setImageWithURL:[NSURL URLWithString:str] forState:UIControlStateNormal];
        }
    }
    else if(_ActData.data_approval.new_user.count > 0)
    {
        NSString * url = ((new_userObject *)_ActData.data_approval.new_user[0]).avatar;
        if([url isEqualToString:@""])
        {
            [_userApprovalBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
        }else
        {
            [_userApprovalBtn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
        }
        
    }
    else
    {
        [_userApprovalBtn setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    }
}

#pragma mark 点击点赞人头像
- (IBAction)UserApprovalClick:(id)sender {
    
    _isExpand = !_isExpand;
    self.click();
}

#pragma mark 点击点赞
- (IBAction)ApprovalClick:(id)sender {
    
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
            
            [self updateApproval];
            self.approvalBtn.selected = _ActData.data_approval.is_approval;
            self.approval(_ActData.data_approval);
//            [_approvalView setApproval:_ActData.data_approval];
        } :_ActData.feedcontent_id];
        
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 20, 20)];
        
        _addLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];
        
        _addLabel.text = @"+1";
        _addLabel.textColor = [UIColor redColor];
        [self.approvalBtn addSubview:_addLabel];
        [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:UIViewKeyframeAnimationOptionAllowUserInteraction animations:^{
            _addLabel.frame = CGRectMake(20, -10, 20, 20);
            _addLabel.frame = CGRectMake(35, 0, 20, 20);
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
            [self updateApproval];
            self.approvalBtn.selected = _ActData.data_approval.is_approval;
            self.approval(_ActData.data_approval);
            //[_approvalView setApproval:_ActData.data_approval];
        } :_ActData.feedcontent_id];
    }
    
//    if( _Data.data_approval.isEmpty && self.isExpand ){
//        self.Style ^= Expand;
//    }

    
}

#pragma mark 评论点击
- (IBAction)CommentClick:(id)sender {
    _alert = [[descAlertView alloc] initWithFrame:_Controller.view.frame];
    [_alert setTitle:@"评论" buttonTitle:@"发布"];
    __weak ActivityButtonView * btn = self;
    _alert.cancle = ^{
        [btn.alert removeFromSuperview];
    };
    _alert.ensure = ^(NSString * str){
        
        if([str isEqualToString:@""]){
            UIAlertView * view = [[UIAlertView alloc] initWithTitle:nil message:@"请输入评论内容" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [view show];
            return ;
        }
        [CommentRequest sendComment:^(NSDictionary *commentDic) {
            
            [btn.alert removeFromSuperview];
            [MBProgressHUD creatembHub:@"评论成功"];
            
        } :btn.ActData.feedcontent_id :str];
        
    };
    [self.Controller.view addSubview:_alert];
    
}

#pragma mark 分享点击
- (IBAction)ShareClick:(id)sender {
    
    ShareView *pageOneView = [[ShareView alloc] initWithViewController:_Controller ID:_ID];
    [pageOneView show];

    
}

@end
