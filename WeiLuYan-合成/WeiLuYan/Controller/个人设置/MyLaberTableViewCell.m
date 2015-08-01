//
//  MyLaberTableViewCell.m
//  tabviewcon
//
//  Created by weiluyan on 15/2/2.
//  Copyright (c) 2015年 JX. All rights reserved.
//

#import "MyLaberTableViewCell.h"
@implementation MyLaberTableViewCell

//xib用的方法
- (void)awakeFromNib {
    

    
    
    // Initialization code
}
-(void)setLabertext:(NSMutableArray*)laberArray
{

    NSLog(@"dadaad=%@",laberArray);


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    _userLaber=[[UILabel alloc]initWithFrame:CGRectMake(25,25, 200, 40)];
    _userLaber.text=@"标签";
    _userLaber.backgroundColor = [UIColor clearColor];
        _userLaber.font = [UIFont boldSystemFontOfSize:16];
    
    [self addSubview:_userLaber];
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(0,45 , self.frame.size.width, self.frame.size.height)];
    
    NSLog(@"myview.wid:%.0f",self.frame.size.width);
    
    _myView.opaque = YES;
    [self addSubview:_myView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.myView.bounds;
    //控制总列数
    int totalColumns = 3;
    
    CGFloat Y = 15;
    CGFloat W = 90;
    CGFloat H = 20;
    CGFloat X = (self.myView.frame.size.width - totalColumns * W) / (totalColumns + 1);
    
    for (int index = 0; index < _myArry.count; index++) {
        
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat viewX = X + col * (W + X);
        CGFloat viewY = 20 + row * (H + Y);
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(viewX, viewY, W, H)];
        label.textAlignment = UITextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.text=[[_myArry objectAtIndex:index] objectForKey:@"name"];
        label.backgroundColor=[GeneralizedProcessor hexStringToColor:@"e61300"];
        [self.myView addSubview:label];
        
    }
    

    
    // Configure the view for the selected state
}

@end
