//
//  shareDesc.m
//  WeiLuYan
//
//  Created by jikai on 15/3/25.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "shareDesc.h"
#import "UIImageView+WebCache.h"

@implementation shareDesc
alloc_with_xib(shareDescView)
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.frame = frame;
    }
    return self;
}
-(void)awakeFromNib
{
    _contentTextView.delegate = self;
}

-(void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = _contentTextView.frame;
    CGSize size = [_contentTextView.text boundingRectWithSize:CGSizeMake(frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentTextView.frame = CGRectMake(frame.origin.x, 60, size.width, size.height);
    _sendView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y + _contentTextView.frame.size.height + 10, _sendView.frame.size.width, _sendView.frame.size.height);
    frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _sendView.frame.origin.y + _sendView.frame.size.height);
}


-(void)setData:(ShareObject *)data
{
    _contentTextView.text = [NSString stringWithFormat:@"我在牛投发现了一个好项目，推荐给大家，小伙伴们快来看！%@",data.share_url];
    [_projectImg sd_setImageWithURL:[NSURL URLWithString:data.product_img]placeholderImage:[UIImage imageNamed:@"touxiang"]];
    _url = data.share_url;
}

- (IBAction)cancleClick {
    
    self.cancle();
}

#pragma mark 删除项目图片
- (IBAction)deleteClick {
    //删除图片
    [_projectImg removeFromSuperview];
    [_deleteButton removeFromSuperview];
    
    //修改控件的坐标
    CGRect frame = _contentTextView.frame;
    CGSize size = [_contentTextView.text boundingRectWithSize:CGSizeMake(frame.size.width + 80, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _contentTextView.frame = CGRectMake(frame.origin.x, 60, size.width, size.height);
    _sendView.frame = CGRectMake(_contentTextView.frame.origin.x, _contentTextView.frame.origin.y + _contentTextView.frame.size.height + 10, _sendView.frame.size.width, _sendView.frame.size.height);
    frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, _sendView.frame.origin.y + _sendView.frame.size.height);
}
- (IBAction)sendClick {
    
    self.send();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
