//
//  ActivityCell.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityCell.h"

@implementation ActivityCell

- (void)awakeFromNib {
    
    
    _activityContentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shadowBG"]];
        [self initView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


-(void)initView
{
    _approvalView = [[FeedApprovalView alloc] initWithFrame:CGRectMake(20,385, CGRectGetWidth(_buttonView.frame), 55)];
    _approvalView.hidden = NO;
    _approvalView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    _approvalView.Controller = _Controller;
    
    [self.contentView addSubview:_approvalView];
}

+(CGFloat)getCellHeight:(BOOL)flag
{
    CGFloat height = 390;
    if(flag){
        height += 55;
    }
    return height;
}

-(void)setData:(ActivityInfo *)data
{
    _data = data;
    _headerView.Controller = _Controller;
    _buttonView.Controller = _Controller;
    _approvalView.Controller = _Controller;
    [_headerView setHeaderData:data];
    [_activityContentView setContentData:data];
    [_buttonView setButtonData:data];
    [self setApprovalViewData:data.data_approval];
    _buttonView.approval = ^(ApprovalObject * data){
        [self setApprovalViewData:data];
    };
    _buttonView.click = ^{
        
        self.Style = !_Style;
        
    };
    
}

-(void)setApprovalViewData:(ApprovalObject *)data
{
    [_approvalView setApproval:data];

}

-(void)setStyle:(BOOL)Style
{
    _Style = Style;
    _approvalView.hidden = !(_Style);
    [_approvalView setApproval:_data.data_approval];
}

@end
