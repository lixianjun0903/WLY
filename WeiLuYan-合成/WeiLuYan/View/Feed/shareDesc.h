//
//  shareDesc.h
//  WeiLuYan
//
//  Created by jikai on 15/3/25.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareObject.h"

@interface shareDesc : UIView<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *sendView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *projectImg;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic,strong) NSString * url;
@property (nonatomic, copy) void(^ cancle)();
@property (nonatomic, copy) void(^ send)();

-(void)setData:(ShareObject *)data;

@end
