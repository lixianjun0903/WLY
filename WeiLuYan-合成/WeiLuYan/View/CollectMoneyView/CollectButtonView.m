//
//  CollectButtonView.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectButtonView.h"
#import "ShareView.h"
#import "CollectMoneyRequest.h"
#import "MBProgressHUD+Show.h"
#import "MBProgressHUD.h"

@interface CollectButtonView ()
@property(nonatomic,assign) BOOL flag;


@end
@implementation CollectButtonView
alloc_with_xib(ColButtonView)
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
    
}

-(void)setButtonData:(CollectMoneyObject *)model
{
    _data = model;
    _ID = [model.project_id intValue];
    self.flag = [_data.favorite_status intValue];
    
    if(self.flag){
        
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_highlight"] forState:UIControlStateNormal];
    }
    else{
        
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"btn_attention_default"] forState:UIControlStateNormal];
        
    }

}

#pragma mark 点击关注
- (IBAction)collectClick:(id)sender {
    
    _collectBtn.selected = self.flag;
    if(!self.flag){
        //  int num = [self.Data.project_id intValue];
        [CollectMoneyRequest collectFinanceCollectWithId:[_data.project_id intValue] with:^(NSDictionary *result) {
            //成功
            self.flag = !self.flag;
            _collectBtn.selected = self.flag;
            [self refreshButton];
            [MBProgressHUD creatembHub:@"关注成功"];
            
        }];
    }
    else{
        [CollectMoneyRequest collectFinanceUnCollectWithId:[_data.project_id intValue] with:^(NSDictionary *result) {
            self.flag = !self.flag;
            _collectBtn.selected = self.flag;
            [self refreshButton];
            [MBProgressHUD creatembHub:@"已取消关注"];
            
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
    
    [CollectMoneyRequest collectFinanceUnCollectWithId:[_data.project_id intValue] with:^(NSDictionary *result) {
        self.flag = !self.flag;
        [self refreshButton];
        [MBProgressHUD creatembHub:@"已取消关注"];
        //上级页面重新获取数据，刷新页面。
        
    }];
}


-(void)collectBtnClick:(UIButton *)sender
{
    [_collectBtn removeTarget:self action:@selector(collectBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    
    [CollectMoneyRequest collectFinanceCollectWithId:[_data.project_id intValue] with:^(NSDictionary *result) {
        //成功
        self.flag = !self.flag;
        [self refreshButton];
        [MBProgressHUD creatembHub:@"关注成功"];
        //上级页面重新获取数据，刷新页面。
       
        
        
    }];
}


- (IBAction)shareClick:(id)sender {
    
    ShareView *pageOneView = [[ShareView alloc] initWithViewController:_Controller ID:_ID];
    [pageOneView show];
}

@end
