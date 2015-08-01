//
//  ShareView.h
//  YaWan
//
//  Created by WL-DZ-PGDN-007 on 15-3-31.
//  Copyright (c) 2015年 Mac-Xuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedItemCell.h"
#import "UMSocialShakeService.h"
#import "shareDesc.h"

@interface ShareView : UIView<UMSocialShakeDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UIImageView *sinaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *qqImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weixinImageView;

@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weixinBtn;

@property (nonatomic,assign) UIViewController * vc;
@property (nonatomic,strong) shareDesc * share;
@property (nonatomic,assign) int projectID;
@property (nonatomic,assign) int selectTag;

- (id)initWithViewController:(UIViewController *)vc ID:(int)projectID;

- (void)show;

@end
