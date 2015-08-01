//
//  ContentView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"
#import "WHomeViewController.h"
#import "ActivityInfo.h"

@class ActiveObject;

@interface FeedContentView : UIView<UIScrollViewDelegate>
@property( nonatomic, strong) CollectMoneyObject * Data;
@property(nonatomic,strong)ActivityInfo * ActData;
@property( nonatomic, strong) WHomeViewController * controller;
@end
