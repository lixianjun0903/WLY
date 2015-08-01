//
//  MainTabSel.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/20.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "MainTabSel.h"


#define ITEM_S_WIDTH 220
#define ITEM_S_HEIGHT 52

@interface MainTabSel()
{
    UIView * BGView;
    UITabBarController * TabBarC;
    UIButton * selectButton;

}

@end

@implementation MainTabSel

-(id)init
{
    self = [super init];
    
    self.frame = [UIScreen mainScreen].bounds;
    
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.barStyle = UIBarStyleDefault;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = [UIScreen mainScreen].bounds;
    }];
  
    UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];

    [self addGestureRecognizer:gr];

    BGView = [UIView new];
    BGView.frame = self.bounds;
    BGView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:BGView];
    
    self.hidden = YES;

    return self;
}



#pragma mark 背景手势

-(void)tap:(UIGestureRecognizer *)gr
{
    self.hidden = YES;
    [self itemClick:selectButton];
}

-(void)showWithTabBar:(UITabBarController *) tab
{
    for(UIView * child in BGView.subviews)
    {
        [child removeFromSuperview];
    }
    
    int i = 0;
    int count = (int)tab.viewControllers.count;
    for(UIViewController * vc in tab.viewControllers)
    {
        UIButton * items = [UIButton buttonWithType:UIButtonTypeCustom];
    
        items.frame = CGRectMake((self.bounds.size.width - ITEM_S_WIDTH) / 2, self.bounds.size.height - 70 - (count - i) * (ITEM_S_HEIGHT + 1), ITEM_S_WIDTH, ITEM_S_HEIGHT);
    
        if (i == tab.selectedIndex)
        {
            selectButton = items;
            items.backgroundColor = [UIColor redColor];
            [items setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else
        {
            items.backgroundColor = [UIColor whiteColor];
    
            [items setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }

        [items setTitle:vc.tabBarItem.title forState:UIControlStateNormal];
    
        [items addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        items.tag = 100 + i;
        
        [BGView addSubview:items];
        i++;
    }
    
    TabBarC = tab;
    self.hidden = NO;
}

-(void)itemClick:(UIButton *)sender
{
    int selectNumIndex = (int)sender.tag - 100;
    self.hidden = YES;
    
    TabBarC.selectedIndex = selectNumIndex;
    [TabBarC.delegate tabBarController:TabBarC didSelectViewController:TabBarC.viewControllers[selectNumIndex]];
}

@end
