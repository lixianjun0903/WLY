//
//  NewPublishViewController.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/13.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "NewPublishViewController.h"
#import  "UserInfoRequest.h"
#import  "MBProgressHUD+Show.h"
#import "TextLimitView.h"
#import "GeneralizedProcessor.h"
#import "AppDelegate.h"
#import "MenuSheet.h"
#import "MessagePhotoMenuItem.h"

@interface NewPublishViewController ()
{
    TextLimitView * _textView;
}

@end

@implementation NewPublishViewController

-(void)viewWillAppear:(BOOL)animated
{
    [AppDelegate instance].MainBar.NaveBar.hidden = NO;
    [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    [self createNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    self.MessagePhotoView.delegate = self;
    //观察键盘出现 消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)createNav
{
    UIButton * publish = [UIButton buttonWithType:UIButtonTypeCustom];
    publish.frame = CGRectMake(0, 10, 40, 40);
    [publish setTitle:@"发布" forState:UIControlStateNormal];
    [publish setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [publish addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 60)];
    [view addSubview:publish];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

-(void)createView
{
    _textBG.backgroundColor = [UIColor clearColor];
    _textView = [[TextLimitView alloc] initWithFrame:CGRectMake(0, 1, WIDTH,250)];
    _textView.LimitNumber = 140;
    [_textBG addSubview:_textView];
    
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:singleRecognizer];
    
}

//实现代理方法
-(void)addPicker:(UIImagePickerController *)picker{
    [AppDelegate instance]. MainBar.BarBtn.hidden = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)addUIImagePicker:(UIImagePickerController *)picker{
    [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)publishClick
{
    NSArray *imageArray = self.MessagePhotoView.itemArray;
    if ([_textView.textView.text isEqualToString:@""] ) {
        
        [MBProgressHUD creatembHub:@"请填写动态"];
        return;
    }else if(imageArray.count == 0)
    {
        [MBProgressHUD creatembHub:@"请选择一张图片"];
        return;
    }else{
        //压缩图片不能过大,封装参数到数组里
        NSMutableArray *photoItemArray = [NSMutableArray array];
        for (int i=0; i<imageArray.count; i++) {
            MessagePhotoMenuItem *phontoItem=imageArray[i];
            UIImage *tempImg = phontoItem.image;
            UIImage *image =  [GeneralizedProcessor imageWithImage:tempImg scaledToSize:CGSizeMake(200, 200)];
            NSString *feedKey;
            if (i == 0) {
                feedKey = @"feed_pic";
            }else{
                feedKey = [NSString stringWithFormat:@"feed_pic%d",i];
            }
            
            NSDictionary *dic = [NSDictionary dictionaryWithObject:image forKey:feedKey];
            [photoItemArray addObject:dic];
        }
        
        
        //批量上传图片
        [UserInfoRequest uploadImage:^(NSDictionary *dic) {
          NSArray *imgUrlArray = [dic objectForKey:@"imgUrlArr"];
            NSMutableDictionary *imageUrlDic = [NSMutableDictionary dictionary];
            for (int i = 0; i<imgUrlArray.count; i++) {
                NSString *imgUrl = imgUrlArray[i];
                [imageUrlDic setValue:imgUrl forKey:[NSString stringWithFormat:@"%d",i]];
            }
            
          NSData *jsonData = [NSJSONSerialization dataWithJSONObject:imageUrlDic options:NSJSONWritingPrettyPrinted error:nil];
            NSString *imgUrlStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
          imgUrlStr = [imgUrlStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            
          NSDictionary *publishDic = [NSDictionary dictionaryWithObjectsAndKeys:_textView.textView.text,@"feed_text",imgUrlStr,@"feed_pic_urls", nil];

            [UserInfoRequest publish:publishDic with:^(NSDictionary *result) {
                NSNumber *feedId = [result objectForKey:@"feedid"];
                NSLog(@"%d",[feedId intValue]);
                //页面跳转
                //self.tabBarController.selectedIndex = 0;
                [[AppDelegate instance].MainBar btnClick];
                [MBProgressHUD creatembHub:@"发布成功"];
            }];
    
        } data:photoItemArray fail:^(int errCode, NSError *err) {
            
        }];
    }
}

-(void)tapAction{
    [_textView.textView resignFirstResponder];
}


#pragma mark - 键盘出现 消失
-(void)keyboardShow:(NSNotification *)notification
{
    NSLog(@"keyboardShow");
    [UIView animateWithDuration:0.3 animations:^{
        
        self.view.frame = CGRectMake(0, -100, WIDTH, HEIGHT);
        
    }];
}

-(void)keyboardHide:(NSNotification *)notification
{
    NSLog(@"keyboardHide");
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(0, 80, WIDTH, HEIGHT);
    }];
}
@end
