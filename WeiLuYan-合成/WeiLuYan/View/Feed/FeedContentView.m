//
//  ContentView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedContentView.h"
#import "ActiveObject.h"
#import "UIImageView+WebCache.h"
#import "SJAvatarBrowser.h"
#import "AppDelegate.h"

@interface FeedContentView(){
    CGFloat _scrollViewH;
    CGFloat _scrollViewW;
    NSArray * _picArray;
    int _currentImageIndex;
   
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
}

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation FeedContentView

alloc_with_xib(ContentView)
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
    _scrollViewH = self.scrollView.frame.size.height;
    _scrollViewW = self.scrollView.frame.size.width;
    self.scrollView.delegate = self;
    _scrollView.contentSize=CGSizeMake(3*_scrollViewW, _scrollViewH) ;
    [_scrollView setContentOffset:CGPointMake(_scrollViewW, 0) animated:NO];
    [self addImageViews];    
}

-(void)setCollectPersonInfo:(NSDictionary *)data
{
    
}

//-(void)setData:(CollectMoneyObject *)data
//{
//    _Data = data;
//    
//    _titleLab.text = [NSString stringWithFormat:@" %@",_Data.project_name];
//    
//    
//    [_mediaView sd_setImageWithURL:[NSURL URLWithString:data.project_product_img]];
//    _mediaView.layer.borderWidth = 0.4;
//    _titleLab.layer.borderColor = [UIColor grayColor].CGColor;
//
//    [_contentLabel setText:data.project_desc];
//    _contentLabel.numberOfLines = 3;
//    
//}


-(void)setData:(CollectMoneyObject *)data
{
    _Data = data;
//    _titleLab.text = [NSString stringWithFormat:@" %@",_Data.project_name];
//    _titleLab.layer.borderColor = [UIColor grayColor].CGColor;
    [_contentLabel setText:data.project_desc];
    _contentLabel.numberOfLines = 3;
}


-(void)setActData:(ActivityInfo *)ActData
{
    _contentLabel.text = [NSString stringWithFormat:@"%@",ActData.content];
    _picArray = ActData.pic_content;
    if (_picArray.count == 1 || _picArray.count == 0) {
        self.scrollView.scrollEnabled = NO;
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:[_picArray firstObject]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    }else{
        self.scrollView.scrollEnabled = YES;
        [self setDefaultImage];
    }
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
    
    //NSLog(@"宽>>>>>>%f",_scrollViewW);
    NSLog(@"scrollow高>>>>>>%f",_scrollViewH);
    NSLog(@"imageView高>>>>>%f",_scrollViewH);
}


-(void)setDefaultImage{
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:[_picArray lastObject]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[0]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[1]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    _currentImageIndex=0;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    [_scrollView setContentOffset:CGPointMake(_scrollViewW, 0) animated:NO];
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
   
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[_currentImageIndex]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[leftImageIndex]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_picArray[rightImageIndex]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
}

@end
