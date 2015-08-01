//
//  FeedApproval.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/5.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedApprovalView.h"

#import "UIButton+WebCache.h"
#import "new_userObject.h"
#import "WMineViewController.h"
#import "new_userObject.h"
#import "AccountModel.h"

@interface FeedApprovalView()
{
    int begin;
    int end;
    
    BOOL clearScroll;
    
     }
//前端显示字典
@property (nonatomic, strong) NSMutableDictionary * showBtn;
//复用数组
@property (nonatomic, strong) NSMutableArray * emptyBtn;
@property (nonatomic, strong) ApprovalObject * approval;
@property (nonatomic, strong) new_userObject* person;



- (void)updateData:(BOOL)clearScroll;

-(UIButton *)obtainBtn:(int)index;
-(void)removeBtn:(int)index;

@end

@implementation FeedApprovalView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    
    [self setShowsHorizontalScrollIndicator:NO];
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
 
    _showBtn = [NSMutableDictionary new];
    _emptyBtn = [NSMutableArray new];
    _person = [new_userObject new];
    
    return self;
}

-(void)setApproval:(ApprovalObject*)info
{
    [_approval removeObserver:self forKeyPath:@"is_approval"];
    
    if(info.is_approval)
    {
        AccountModel * model = [AccountModel instance];
        PersonalInfoModel * per_model = model.personInfoModel;
        _person.avatar = per_model.avatar;
    }
    
    _approval = info;
    
    [_approval addObserver:self forKeyPath:@"is_approval" options:0 context:nil];
    
    [self updateData:NO];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    ApprovalObject * info = (ApprovalObject *)object;
   // ApprovalMessage * info = (ApprovalMessage *)object;
    if(info.is_approval)
    {
        AccountModel * model = [AccountModel instance];
        PersonalInfoModel * per_model = model.personInfoModel;
        _person.avatar = per_model.avatar;
        
    }
    //[self updateData:YES];
}

-(void)dealloc
{
    [_approval removeObserver:self forKeyPath:@"is_approval"];
}

#pragma mark update icon

-(NSInteger)count
{
    if( _approval.is_approval ){
        return _approval.new_user.count;
    }
    else{
        return _approval.new_user.count;
    }
}

-(new_userObject *)user:(NSInteger)index
{
    if( _approval.is_approval ){
        if( index == 0 ){
            return _person;
        }
        
        return _approval.new_user[index];
    }
    else{
        return _approval.new_user[index];
    }
    
}
//更新页面展示的数据
- (void)updateData:(BOOL)clear
{
    NSUInteger len = [self count];
    [_emptyBtn addObjectsFromArray:_showBtn.allValues];
    [_showBtn removeAllObjects];
    
    for(UIButton * btn in _emptyBtn){
        btn.hidden = YES;
    }
    
    if( len == 0 ){
        return;
    }
    
    begin = 0;
    end = 0;
    
    for( int pos = 5; pos <= self.frame.size.width; pos += 55){
        [self obtainBtn:end];
        
        if( ++end >= len ){
            break;
        }
    }
    
    CGSize sz = self.frame.size;
    sz.width = 5 + 55 * len;
    
    clearScroll = YES;
    self.contentSize = sz;
    clearScroll = NO;
    
    if( YES ){
        self.contentOffset = CGPointZero;
    }
}
//如果页面展示的头像即将出现，调用该方法，将button加入展示数组
-(UIButton *)obtainBtn:(int)index
{
    UIButton * btn;

    
    if(_emptyBtn.count != 0 )
    {
        btn = _emptyBtn.lastObject;
        [_emptyBtn removeLastObject];
    }
    else
    {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
       [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn.layer setCornerRadius:40 / 2];
        btn.layer.masksToBounds = YES;

        [self addSubview:btn];
    }
    
    btn.hidden = NO;
    
    btn.frame = CGRectMake(5 + 55 * index,10, 40, 40);
    btn.tag = index;
    
    _showBtn[[NSNumber numberWithInt:index]] = btn;
    
    NSString * url = [self user:index].avatar;
    
    [btn sd_setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"touxiang"]];
   
    return btn;
}


//如果页面展示的头像消失，调用该方法，将button加入复用数组
-(void)removeBtn:(int)index
{
    NSNumber * num = [NSNumber numberWithInt:index];
    UIView * v = _showBtn[num];
    v.hidden = YES;
     
    [_emptyBtn addObject:v];
    [_showBtn removeObjectForKey:num];
}
//判断button的出现和消失
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if( clearScroll ){
        return;
    }
    
    int b = (int)MAX((self.contentOffset.x - 5 ) / 55, 0);
    
    int e = (self.contentOffset.x + self.frame.size.width - 5) / 55 + 1;
    e = (int)MIN(e, [self count]);
    
    while( begin < b ){
        [self removeBtn:begin++];
    }

    while( end > e ){
        [self removeBtn:--end];
    }

    while( begin > b ){
        [self obtainBtn:--begin];
    }
    
    while( end < e ){
        [self obtainBtn:end++];
    }
}

#pragma mark target
-(void)click:(UIButton *)sender
{
    self.click_id = [self user:sender.tag].member_id;
    WMineViewController * vc = [[WMineViewController alloc] init];
    vc.useridd = self.click_id ;
    [_Controller.navigationController pushViewController:vc animated:YES];

}
@end
