//
//  CollectButtonView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectMoneyObject.h"

@interface CollectButtonView : UIView
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property(nonatomic,weak)UIViewController * Controller;
@property(nonatomic,assign)int ID;
@property(nonatomic,strong)CollectMoneyObject * data;
@property (strong,nonatomic) void (^reLoadBlock)(void);

-(void)setButtonData:(CollectMoneyObject *)model;
@end
