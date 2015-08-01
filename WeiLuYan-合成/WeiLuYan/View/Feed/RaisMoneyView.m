//
//  RaisMoneyView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "RaisMoneyView.h"
#import "UIImageView+WebCache.h"


@implementation RaisMoneyView

alloc_with_xib(MoneyView)
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

-(void)setData:(CollectMoneyObject *)data
{
    
    self.timeLabel.text = [NSString stringWithFormat:@"剩余%@天",data.finance_info.have_days];
    
    self.raiseMoneyLabel.text = [NSString stringWithFormat:@"已筹集¥%@万",data.finance_info.vote_money];
    float a = [data.finance_info.vote_money floatValue];
    float b = [data.finance_info.finance_money floatValue];
    int item = a / b * 100;
    self.percentLabel.text = [NSString stringWithFormat:@"以达到%d％",item];
    float proValue = item / 100.0;
    _progressView.progress = proValue;
    
    _describeLabel.text = data.project_name;
    _contentLabel.text = data.project_desc;
   
    [_mediaView sd_setImageWithURL:[NSURL URLWithString:data.project_product_img]];
}




@end


