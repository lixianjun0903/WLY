//
//  MessagePhotoMenuItem.m
//  testKeywordDemo
//
//  Created by mei on 14-7-26.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//


#import "MessagePhotoMenuItem.h"

@implementation MessagePhotoMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setContentImage:(UIImage *)contentImage
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, self.frame.size.width - 10, self.frame.size.height - 20)];
    imageView.backgroundColor = [UIColor orangeColor];
    imageView.image = contentImage;
    [self addSubview:imageView];
    
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.frame = CGRectMake(self.frame.size.width - 20, 0, 15, 15);
    [btnDelete setImage:[UIImage imageNamed:@"delete-circular.png"] forState:UIControlStateNormal];
    btnDelete.tag = self.index;
    [btnDelete addTarget:self
                  action:@selector(deletePhotoItem:)
        forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnDelete];
}

/*
    删除图片
 */

-(void)deletePhotoItem:(UIButton *)sender{
    if([self.delegate respondsToSelector:@selector(messagePhotoItemView:didSelectDeleteButtonAtIndex:)]){
        [self.delegate messagePhotoItemView:self
               didSelectDeleteButtonAtIndex:sender.tag];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
