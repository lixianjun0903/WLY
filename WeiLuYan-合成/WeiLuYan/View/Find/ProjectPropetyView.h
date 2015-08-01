//
//  ProjectPropetyView.h
//  WeiLuYan
//
//  Created by 张亮 on 14-9-29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectPropetyView : UIView

@property( nonatomic, strong) UILabel* projectName;
@property( nonatomic, strong) UIImageView* proejectImageView;
@property( nonatomic, strong) NSArray*projectTagArray;

- (id)initWithFrame:(CGRect)frame :(NSArray*)projectTagArray;

- (id)initWithFrame:(CGRect)frame :(NSArray*)projectTagArray :(BOOL)isShowProjectICON;

-(void)setProjectName:(NSString*)projectName AndProjectImage :(NSString*)URLStr;
@end
