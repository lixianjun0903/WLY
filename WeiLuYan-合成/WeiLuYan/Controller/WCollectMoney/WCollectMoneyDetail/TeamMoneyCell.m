//
//  TableViewCell.m
//  WeiLuYan
//
//  Created by mac on 14/12/30.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "TeamMoneyCell.h"
#import "MBProgressHUD+Show.h"


@implementation TeamMoneyCell

- (void)awakeFromNib {
    
    
}

-(void)setExpand:(int)Style
{
    _lsexpand = Style;
    if(_lsexpand)
    {
        self.detailView.hidden = NO;
    }else
    {
        self.detailView.hidden = YES;
    }
}

-(void)config:(MoneyParks *)data
{
    
    self.detail.text = data.parks_desc;
    
    self.peopleCount.text = [NSString stringWithFormat:@"¥%d万(已有%d人投资)",data.parks_price,data.park_claimed];
    self.limit.text = [NSString stringWithFormat:@"限额份数：%d",data.pakes_count];
    self.left.text = [NSString stringWithFormat:@"剩余份数：%d",data.parks_last];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
        [super setSelected:selected animated:animated];
   

    // Configure the view for the selected state
}

- (IBAction)expandClick:(UIButton *)sender {
  
    self.lsexpand = !self.lsexpand;
    
}

- (IBAction)agreeClick:(UIButton *)sender {
    
    [MBProgressHUD creatembHub:@"认证投资人身份"];
    
    
}
@end
