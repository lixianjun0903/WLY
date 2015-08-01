//
//  CollectMoneyForHeader.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyForHeader.h"
#import "UIButton+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "VideoPlayController.h"
#import "CollectParkObject.h"
#import "ContentDetailsController.h"


@implementation CollectMoneyForHeader
alloc_with_xib(CollectMoneyHeader)

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    return self;
}

-(void)awakeFromNib
{
    _progressView.transform = CGAffineTransformMakeScale(1.0f,1.5f);
    _progressView.layer.cornerRadius = 4;
    _progressView.layer.masksToBounds = YES;
    
}
-(void)setCollectMoneyHeader:(ProjectDetailObject *)model
{
    
    self.shortContent = model.C_Info.C_ShortDescrip;
    self.longContent = model.C_Info.C_LongDescrip;
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.C_Info.C_ImageURL] placeholderImage:nil];
    
    _projectIntro.text = [NSString stringWithFormat:@"%@",model.C_Info.C_ShortDescrip];
    
    _lastTimeLabel.text = [NSString stringWithFormat:@"剩余%d天",model.C_Info.C_LeftTime];
    
    
    int  a = model.C_Info.C_FundTarget;
    int  b = model.C_Info.C_Funded;
    int nowMoney = a * b/100;
    
    _collectMoneyLabel.text = [NSString stringWithFormat:@"已筹集%d万",nowMoney];
    
//    float a = [model.data_finance.vote_money floatValue];
//    float b = [model.data_finance.finance_money floatValue];
//    int item = a / b * 100;
    
    _percentLabel.text = [NSString stringWithFormat:@"已筹集%d%@",model.C_Info.C_Funded,@"%"];
    _progressView.progress = model.C_Info.C_Funded;
    _videoUnique = model.C_Info.C_VideoUnique;
    _videoName = model.C_Info.C_VideoName;
    
}
- (IBAction)playBtnClick:(id)sender {
    
    if(self.videoUnique.length == 0)
    {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该项目暂无视频" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        return;
    }
    VideoPlayController * vc = [[VideoPlayController alloc] init];
    vc.videoUnique = self.videoUnique;
    vc.videoName = self.videoName;
    [self.cdv.navigationController pushViewController:vc animated:YES];
}
- (IBAction)CheckDetailsClick:(id)sender {
    
    ContentDetailsController * cdc = [ContentDetailsController new];
    if (self.longContent == nil) {
        cdc.content = self.shortContent;
    }
    cdc.content = self.longContent;
    
    [self.cdv.navigationController pushViewController:cdc animated:YES];
    
    
}

@end
