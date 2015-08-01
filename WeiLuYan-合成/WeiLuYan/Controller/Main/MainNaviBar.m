//
//  MainNaviBar.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MainNaviBar.h"

@interface MainNaviBar()
{
    UINavigationItem * curr;
}
@end

@implementation MainNaviBar

+(UIBarButtonItem * )emptyItem
{
    static UIBarButtonItem * item = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        item = [[UIBarButtonItem alloc]init];
    });
    
    return item;
}

-(id)init
{
    self = [super init];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 62, [UIScreen mainScreen].bounds.size.width, 2)];
    view.backgroundColor = [GeneralizedProcessor hexStringToColor:@"ea2a2a"];
    [self addSubview:view];
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 25, 75, 29)];
    img.image = [UIImage imageNamed:@"project_logo_"];
    [self addSubview:img];
    
//    CGPoint po = self.center;
//    po.y += 10;
//    img.center = po;
    
    [self setItems:@[[UINavigationItem new]]];
    
    return self;
}

-(void)updateNaviItem:(UINavigationItem *)item
{
    if( curr != nil ){
        [curr removeObserver:self forKeyPath:@"rightBarButtonItem"];
    }

    curr = item;
    [curr addObserver:self forKeyPath:@"rightBarButtonItem" options:0 context:0];
    
    self.topItem.rightBarButtonItem = item.rightBarButtonItem;

    item.rightBarButtonItem = [MainNaviBar emptyItem];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UINavigationItem * item = ((UINavigationItem *)object);

    if( item.rightBarButtonItem == [MainNaviBar emptyItem] ){
        return;
    }
    
    self.topItem.rightBarButtonItem = item.rightBarButtonItem;

    item.rightBarButtonItem = [MainNaviBar emptyItem];
}

@end
