//
//  FeedApproval.h
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"
#import "ApprovalObject.h"


@interface FeedApprovalView : UIScrollView<UIScrollViewDelegate>
@property (nonatomic,assign) int click_id;
-(void)setApproval:(ApprovalObject *)info;
@property(nonatomic,strong)UIViewController * Controller;

@end
