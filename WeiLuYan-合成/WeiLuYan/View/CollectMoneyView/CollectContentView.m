//
//  CollectContentView.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectContentView.h"
#import "UIImageView+WebCache.h"

@implementation CollectContentView
alloc_with_xib(ColContentView)
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
    
    
    _progressView.transform = CGAffineTransformMakeScale(1.0f,1.5f);
    _progressView.layer.cornerRadius = 4;
    _progressView.layer.masksToBounds = YES;
}
-(void)setContentData:(CollectMoneyObject *)model
{
    _timeLabel.text = [NSString stringWithFormat:@"剩余%@天",model.finance_info.have_days];
    
    _moneyLabel.text = [NSString stringWithFormat:@"已筹集¥%@万",model.finance_info.vote_money];
    float a = [model.finance_info.vote_money floatValue];
    float b = [model.finance_info.finance_money floatValue];
    int item = a / b * 100;
    _precentLabel.text = [NSString stringWithFormat:@"以达到%d％",item];
    float proValue = item / 100.0;
    _progressView.progress = proValue;
    
    _titleLabel.text = model.project_name;
    _descLabel.text = model.project_desc;
    
    [_projectImg sd_setImageWithURL:[NSURL URLWithString:model.project_product_img]];
    
}

@end
