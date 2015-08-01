//
//  ActivityContentView.h
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityInfo.h"

@interface ActivityContentView : UIView<UIScrollViewDelegate>
{
    CGFloat _scrollViewH;
    CGFloat _scrollViewW;
    NSArray * _picArray;
    int _currentImageIndex;
    
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    UIPageControl *_pageControl;
}
@property (weak, nonatomic) IBOutlet UILabel *introLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

-(void)setContentData:(ActivityInfo *)model;
@end
