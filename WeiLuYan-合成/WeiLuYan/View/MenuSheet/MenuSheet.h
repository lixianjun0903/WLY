//
//  LXActionSheet.h
//  LXActionSheetDemo
//
//  Created by lixiang on 14-3-10.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSheet : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (nonatomic,strong)UIButton * navButn;
@property(nonatomic,strong)void(^dimissBlock)(void);
@property (nonatomic,strong)void(^cancelBlock)(void);
@property (nonatomic,strong) void(^finishBlock)(UIImage *);

- (id)initWithController:(UIViewController *)vc targetImage:(UIButton *)imageButton isID:(BOOL)flag;
- (void)show;

@end
