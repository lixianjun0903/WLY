//
//  ActivityContentView.m
//  WeiLuYan
//
//  Created by 郭秀媛 on 15/4/3.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityContentView.h"
#import "UIImageView+WebCache.h"

@implementation ActivityContentView
alloc_with_xib(ActContentView)
-(void)awakeFromNib
{
    _scrollViewH = self.scrollView.frame.size.height;
    _scrollViewW = self.scrollView.frame.size.width;
    self.scrollView.delegate = self;
    _scrollView.contentSize=CGSizeMake(3*_scrollViewW, _scrollViewH) ;
    [_scrollView setContentOffset:CGPointMake(_scrollViewW, 0) animated:NO];
    [self addImageViews];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    
    return self;
}

-(void)setContentData:(ActivityInfo *)model
{
    if (_pageControl) {
        [_pageControl removeFromSuperview];
    }
    _picArray = model.pic_content;
    if (_picArray.count == 1 || _picArray.count == 0) {
        self.scrollView.scrollEnabled = NO;
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_picArray firstObject]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    }else{
        self.scrollView.scrollEnabled = YES;
        [self addPageControl];
        [self setDefaultImage];
    }
    _introLabel.text = [NSString stringWithFormat:@"%@",model.content];
}

-(void)addPageControl{
    _pageControl=[[UIPageControl alloc]init];
    CGSize size= [_pageControl sizeForNumberOfPages:_picArray.count];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(_scrollViewW/2, _scrollViewH-10);
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    _pageControl.numberOfPages=_picArray.count;
    
    [self addSubview:_pageControl];
}

-(void)addImageViews{
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _scrollViewW, _scrollViewH)];
    _leftImageView.contentMode=UIViewContentModeScaleToFill;
    [_scrollView addSubview:_leftImageView];
    
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_scrollViewW, 0, _scrollViewW, _scrollViewH)];
    _centerImageView.contentMode = UIViewContentModeScaleToFill;
    [_scrollView addSubview:_centerImageView];
    
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*_scrollViewW, 0, _scrollViewW, _scrollViewH)];
    _rightImageView.contentMode=UIViewContentModeScaleToFill;
    [_scrollView addSubview:_rightImageView];
}

-(void)setDefaultImage{
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_picArray lastObject]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[0]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[1]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    _currentImageIndex=0;
    
    _pageControl.currentPage=_currentImageIndex;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    [_scrollView setContentOffset:CGPointMake(_scrollViewW, 0) animated:NO];
    _pageControl.currentPage=_currentImageIndex;
}

-(void)reloadImage{
    int leftImageIndex,rightImageIndex;
    CGPoint offset=[_scrollView contentOffset];
    if (offset.x>_scrollViewW) { //向右滑动
        _currentImageIndex=(_currentImageIndex+1)%[_picArray count];
    }else if(offset.x<_scrollViewW){ //向左滑动
        _currentImageIndex=(_currentImageIndex+[_picArray count]-1)%[_picArray count];
    }
    
    leftImageIndex=(_currentImageIndex+[_picArray count]-1)%[_picArray count];
    rightImageIndex=(_currentImageIndex+1)%[_picArray count];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[_currentImageIndex]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[leftImageIndex]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[rightImageIndex]] placeholderImage:[UIImage imageNamed:@"default_pic"]];
}

@end
