//
//  NoDataView.m
//  WeiLuYan
//
//  Created by wly on 15/3/25.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView
-(UIView *)initNoDataView:(NSString *)msg andFrame:(CGRect)frame{
    self = [super init];
    _noDataView = [[UIView alloc] init];
    _noDataView.frame = frame;
    _noDataLabel = [[UILabel alloc] init];
    _noDataLabel.frame = CGRectMake(0, 0, 200,50);
    _noDataLabel.center = CGPointMake(frame.size.width/2,frame.size.height/2);
    _noDataLabel.text = msg;
    [_noDataLabel setTextAlignment:NSTextAlignmentCenter];
    [_noDataView addSubview:_noDataLabel];
    [self addSubview:_noDataView];
    return self;
}

@end
