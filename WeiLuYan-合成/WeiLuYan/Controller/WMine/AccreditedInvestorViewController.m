//
//  AccreditedInvestorViewController.m
//  WeiLuYan
//
//  Created by jikai on 15/3/17.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "AccreditedInvestorViewController.h"
#import "AppDelegate.h"
#import "UserInfoRequest.h"

@interface AccreditedInvestorViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic,strong) AFRequestState * state;

@end

@implementation AccreditedInvestorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self loadTxt];
}
- (IBAction)buttonClick {
    if(self.state.running){
        return;
    }
    self.state = [UserInfoRequest agree:^(NSDictionary * dic) {
        
        UIAlertView * al = [[UIAlertView alloc] initWithTitle:nil message:dic[@"msg"] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [al show];
        [self.navigationController popViewControllerAnimated:YES];
        
    } fail:^(int errCode, NSError *err) {
        if(!errCode){
            UIAlertView * al = [[UIAlertView alloc] initWithTitle:nil message:@"您得申合格投资人认证申请我们已经受理，请耐心等待" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [al show];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)loadTxt
{
    NSString *txtPath=[[NSBundle mainBundle]pathForResource:@"investor_protocol" ofType:@"txt"];
    
    NSLog(@"txtPath:%@",txtPath);
    
    ///编码可以解决 .txt 中文显示乱码问题
    
    NSStringEncoding *useEncodeing = nil;
    
    //带编码头的如utf-8等，这里会识别出来
    
    NSString *body = [NSString stringWithContentsOfFile:txtPath usedEncoding:useEncodeing error:nil];
    
    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug。
    
//    if (!body) {
//        
//        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000632 error:nil];
//        
//        NSLog(@"%@",body);
//        
//    }
//    
//    //还是识别不到，按GB18030编码再解码一次.
//    
//    if (!body) {
//        
//        body = [NSString stringWithContentsOfFile:txtPath encoding:0x80000631 error:nil];
//        
//        NSLog(@"%@",body);
//        
//    }
//    
    //展现
    
    //0if (body) {
        
        NSLog(@"%@",body);
        
        CGSize size = [body boundingRectWithSize:CGSizeMake(_contentLabel.frame.size.width, 500000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
        _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, size.width, size.height);
        _contentLabel.text = body;
        _contentScrollView.contentSize= CGSizeMake(size.width, size.height + 10);

//    }else {
//        
//        NSString *urlString = [[NSBundle mainBundle] pathForAuxiliaryExecutable:txtPath];
//        
//        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        NSURL *requestUrl = [NSURL URLWithString:urlString];
//        
//        NSLog(@"%@",urlString);
//        
//        NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
//        
//       // [self.contentWebView loadRequest:request];
//        
//    }
    
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIPanGestureRecognizer * pan = _contentScrollView.panGestureRecognizer;
    CGPoint point = [pan translationInView:pan.view];
    if(point.y < 0)
    {
        [AppDelegate instance].MainBar.BarBtn.hidden = YES;
    }else
    {
        [AppDelegate instance].MainBar.BarBtn.hidden = NO;
    }
}

-(void)dealloc
{
    [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
