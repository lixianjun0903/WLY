//
//  WLY_ProjectTableViewCell.m
//  WeiLuYan
//
//  Created by 张亮 on 14/11/24.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "WLY_ProjectTableViewCell.h"
#import "ProjectModel.h"
#import "PersonalInfoModel.h"

#define CELL_ICON_WIDTH_HEIGHT 44
#define ICON_AND_WORD_LEFT_AND_RIGHT 15

@implementation WLY_ProjectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self setBackgroundColor:[GeneralizedProcessor hexStringToColor:@"#ffffff"]];
    }
    return self;
}

-(void)setValue:(ProjectModel*)projectModelObject
{
    
    NSLog(@"%@++++++)))JJJKK",projectModelObject.data_user);
    
    [_headerView removeFromSuperview];
    [_projectPropetyView removeFromSuperview];
    [_allContentView removeFromSuperview];
    [_customerView removeFromSuperview];
    [_scrollView removeFromSuperview];
    
//     _headerView=[[FeedHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 69)];
//     [_headerView setPersonInfo:[self getPersonMoedel:projectModelObject.data_user] :[self getDateStr:projectModelObject.create_time]];
//
//    [self addSubview:_headerView];
    
    _projectPropetyView = [[ProjectPropetyView alloc]initWithFrame:CGRectMake(ICON_AND_WORD_LEFT_AND_RIGHT, _headerView.frame.size.height+_headerView.frame.origin.y, 320, 50) :projectModelObject.project_industry];
     
    [_projectPropetyView setProjectName:projectModelObject.project_name AndProjectImage:projectModelObject.project_logo];
    [self addSubview:_projectPropetyView];
    
   _allContentView=[[FeedContentView alloc]initWithFrame:CGRectMake(0,_headerView.frame.size.height+_projectPropetyView.frame.size.height, self.frame.size.width, 0)];
//    [_allContentView createMediaView:[NSURL URLWithString:@"a"] :nil];
    [self addSubview:_allContentView];
    
    _customerView=[[CustomerView alloc]initWithFrame:CGRectMake(0, _allContentView.frame.size.height+_headerView.frame.size.height+_projectPropetyView.frame.size.height, self.frame.size.width, 57) :2];
    
    
    [_customerView setUntiViewOneValue:CGRectMake(20, 5, CELL_ICON_WIDTH_HEIGHT, CELL_ICON_WIDTH_HEIGHT) :[[projectModelObject.data_approval objectForKey:@"is_approval"] intValue]==1?[UIImage imageNamed:@"home_emoji_R"]:[UIImage imageNamed:@"home_emoji_G"] :[UIImage imageNamed:@"home_emoji_R"]];
    
    [_customerView setUntiViewTwoValue:CGRectMake(20, 5, CELL_ICON_WIDTH_HEIGHT, CELL_ICON_WIDTH_HEIGHT) :CGRectMake(10+CELL_ICON_WIDTH_HEIGHT, 5, CELL_ICON_WIDTH_HEIGHT, CELL_ICON_WIDTH_HEIGHT) :[UIImage imageNamed:@"home_comment_G"] :[NSString stringWithFormat:@"%d",5]];
    
    [_customerView setUntiViewThreeValue:CGRectMake(20, 5, CELL_ICON_WIDTH_HEIGHT, CELL_ICON_WIDTH_HEIGHT) :[UIImage imageNamed:@"home_share_G"] :CGRectMake(20+CELL_ICON_WIDTH_HEIGHT+20, 13, CELL_ICON_WIDTH_HEIGHT-15, CELL_ICON_WIDTH_HEIGHT-15) :CGRectMake(20+CELL_ICON_WIDTH_HEIGHT*2+5, 5, CELL_ICON_WIDTH_HEIGHT, CELL_ICON_WIDTH_HEIGHT) :[UIImage imageNamed:@"touxiang"] :[NSString stringWithFormat:@"+%d",projectModelObject.project_approval_count]];
 
    [self addSubview:_customerView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [self addSubview:_scrollView];

}

-(PersonalInfoModel *)getPersonMoedel:(NSDictionary*)dic
{
    PersonalInfoModel *pp = [[PersonalInfoModel alloc]init];
    [pp setAvatar:[dic objectForKey:@"avatar"]];
    [pp setMember_id:[[dic objectForKey:@"member_id"] intValue]];
    [pp setNick_name:[dic objectForKey:@"nick_name"]];
    [pp setReal_name:[dic objectForKey:@"real_name"]];
    
    return pp;
}

-(NSString*)getDateStr:(int)createTime
{
    NSString* dateStr=[GeneralizedProcessor getDateString:createTime];
    return dateStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
