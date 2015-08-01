//
//  WContentView.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 14-12-16.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WContentView.h"
#import "UIImageView+WebCache.h"
#import "YcKeyBoardView.h"
@interface WContentView()
@property (nonatomic,strong)CollectMoneyObject * headerData;
@end

@implementation WContentView

alloc_with_xib(WView)
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    return self;
}

-(void)loadData:(CollectMoneyObject *)data
{
    if(_headerData != nil)
    {
        [_headerData.data_approval removeObserver:self forKeyPath:@"is_approval"];
    }
    _headerData = data;
    [_headerData.data_approval addObserver:self forKeyPath:@"is_approval" options:NSKeyValueObservingOptionNew context:nil];
    
    NSString * url = data.project_product_img;
    
    
    [_mediaView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    _mediaView.userInteractionEnabled = YES;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [_mediaView addGestureRecognizer:tap];


    _commentLabel.text = [NSString stringWithFormat:@"%d",_headerData.project_comment_count];
    

    _likeBtn.userInteractionEnabled = NO;
    
    [self updateApproval];
    
}

-(void)tap
{
    YcKeyBoardView * yc = [[YcKeyBoardView alloc]init];
    [yc.textView resignFirstResponder];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateApproval];
}

-(void)updateApproval
{
    if(_headerData.data_approval.is_approval)
    {
        _likeLabel.text = [NSString stringWithFormat:@"+%lu",(unsigned long)_headerData.data_approval.new_user.count + 1];
    }
    else if(_headerData.data_approval.new_user > 0)
    {
         _likeLabel.text = [NSString stringWithFormat:@"+%lu", (unsigned long)[_headerData.data_approval.new_user count]];
    }
    else
    {
        
        _likeLabel.text = @"";
    }
}

- (IBAction)commentClick:(id)sender {
    if(_keboardBlock != NULL)
    {
        _keboardBlock();
    }
    
}

@end
