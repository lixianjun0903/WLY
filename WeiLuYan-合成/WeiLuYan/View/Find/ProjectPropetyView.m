//
//  ProjectPropetyView.m
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ProjectPropetyView.h"
#import "UIImageView+WebCache.h"
#define LINE 15
#define LABLE_TO_LABLE 10
@implementation ProjectPropetyView


- (id)initWithFrame:(CGRect)frame :(NSArray*)projectTagArray
{
    
    self = [super initWithFrame:frame];
    
    if (self)
    {
    _projectTagArray=projectTagArray;
     _projectName=[[UILabel alloc]initWithFrame:CGRectMake(LINE, 10, 150, 13)];
    [_projectName setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
 
    [_projectName setFont:[UIFont systemFontOfSize:12]];
    [self addSubview:_projectName];
        
    _proejectImageView=[[UIImageView alloc]initWithFrame:CGRectMake(245, 5, 40, 40)];
//    [_proejectImageView setImage:[UIImage imageNamed:@"hh"]];
    [self addSubview:_proejectImageView];
    
    [self addProjectTagView];
        
    }
    return self;
}
-(void)setProjectName:(NSString*)projectName AndProjectImage :(NSString*)URLStr;
{
    [_projectName setText:projectName];
    [_proejectImageView sd_setImageWithURL:[NSURL URLWithString:URLStr] placeholderImage:[UIImage imageNamed:@"hh"]];
    
}

- (id)initWithFrame:(CGRect)frame :(NSArray*)projectTagArray :(BOOL)isShowProjectICON
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _projectTagArray=projectTagArray;
        _projectName=[[UILabel alloc]initWithFrame:CGRectMake(LINE, 10, 150, 13)];
        [_projectName setTextColor:[GeneralizedProcessor hexStringToColor:@"#212121"]];
        [_projectName setText:@"项目名字项目名字项目名字"];
        [_projectName setFont:[UIFont systemFontOfSize:12]];
        [self addSubview:_projectName];
        
        if (isShowProjectICON)
        {
         _proejectImageView=[[UIImageView alloc]initWithFrame:CGRectMake(245, 5, 40, 40)];
        [_proejectImageView setImage:[UIImage imageNamed:@"hh"]];
        [self addSubview:_proejectImageView];
       
        }
      
        [self addProjectTagView];
        
    }
    return self;
}



-(void)addProjectTagView
{
    NSArray*colorValueArray=[NSArray arrayWithObjects:@"#ca4c2a",@"#cac42a",@"#ca722a", nil];
   
    int x=0;
    for (int i=0; i<[_projectTagArray count]; i++)
    {
        if (i!=0) {//20
              x+=12*[[_projectTagArray objectAtIndex:i-1] length];
        }
        UILabel*lableTag=[[UILabel alloc]init];
        [lableTag setBackgroundColor:[GeneralizedProcessor hexStringToColor:[colorValueArray objectAtIndex:i]]];
        [lableTag setFont:[UIFont systemFontOfSize:9]];
        [lableTag setText:[_projectTagArray objectAtIndex:i]];
        [lableTag setFrame:CGRectMake(i==0?LINE:LINE+i*LABLE_TO_LABLE+x, _projectName.frame.size.height+_projectName.frame.origin.y+5, 13*[[_projectTagArray objectAtIndex:i] length] , 14)];
        lableTag.layer.cornerRadius = 7;
        [lableTag setTextColor:[UIColor whiteColor]];
        lableTag.layer.masksToBounds = YES;
        [lableTag setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:lableTag];
    }
    
}

@end
