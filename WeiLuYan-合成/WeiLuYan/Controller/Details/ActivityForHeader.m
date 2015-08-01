//
//  ActivityForHeader.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/16.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityForHeader.h"
#import "VideoPlayController.h"
#import "commentObject.h"
#import "VideoPlayController.h"


@implementation ActivityForHeader
alloc_with_xib(ActivityHeader)
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    return self;
}

-(void)awakeFromNib
{
    
}
- (IBAction)playClick:(id)sender {
    
    if(self.videoUnique.length == 0)
    {
        UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该项目暂无视频" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [av show];
        return;
    }
    VideoPlayController * vc = [[VideoPlayController alloc] init];
    vc.videoUnique = self.videoUnique;
    vc.videoName = self.videoName;
    [self.adv.navigationController pushViewController:vc animated:YES];
    
}
-(void)setDetailData:(ActivityDetailInfo *)model
{
    _videoUnique = model.video_text;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:model.videoimg_text] placeholderImage:nil];
    
    _introLabel.text = [NSString stringWithFormat:@"%@",model.content];
    
    NSString * str = _introLabel.text;
    
    //根据字数来动态改变view高度
    CGSize size = [str boundingRectWithSize:CGSizeMake(260 , 220) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _introLabel.frame = CGRectMake(30, 180, [UIScreen mainScreen].bounds.size.width - 60, size.height + 20);
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180 + size.height + 20);
    self.block();
    
    
}
@end
