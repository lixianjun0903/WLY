//
//  ActivityFirstView.m
//  WeiLuYan
//
//  Created by guoxiuyuan on 15/3/20.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "ActivityFirstView.h"
#import "FirstCell.h"
#import "UserInfoRequest.h"

@interface ActivityFirstView()

@property (nonatomic,strong) NSArray * dataArray;
@property (nonatomic,strong) NSMutableArray * attentionArray;
@property (nonatomic,assign) BOOL attention;
@property (nonatomic,strong) NSMutableArray * stateArray;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@end

@implementation ActivityFirstView
alloc_with_xib(FirstView)

-(void)awakeFromNib
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    _viewBG.layer.masksToBounds = YES;
    _viewBG.layer.cornerRadius = 12;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    _attentionArray = [NSMutableArray arrayWithCapacity:0];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _stateArray = [NSMutableArray arrayWithCapacity:0];
    
    return self;
}

-(void)setRecommendData:(NSArray *)data
{
    self.dataArray = data;
    for(int i = 0; i < self.dataArray.count; i++){
        [self.stateArray addObject:[NSNumber numberWithInt:0]];
    }
}
- (IBAction)allSelectClick {
    [self.attentionArray removeAllObjects];
    for(int i = 0; i < self.dataArray.count; i++){
        [self.stateArray replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:1]];
        attentionObject * obj = self.dataArray[i];
        [self.attentionArray addObject:[NSNumber numberWithInt:obj.member_id]];
    }
    [_tableview reloadData];
}

- (IBAction)attentionClick {
    
    [UserInfoRequest Attention:^(NSDictionary *userDic) {
        self.ensureAttention();
    } data:self.attentionArray isAttention:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCell * cell = [[[NSBundle mainBundle]loadNibNamed:@"FirstCell" owner:self options:nil]firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(_stateArray.count){
       [cell setCellData:self.dataArray[indexPath.row] attention:[_stateArray[indexPath.row] intValue]];
    }
    else{
        [cell setCellData:self.dataArray[indexPath.row] attention:NO];
    }
    


    cell.attention = ^(int member_id){
        [self.attentionArray addObject:[NSNumber numberWithInt:member_id]];
        [self.stateArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:1]];
    };
    cell.cancleAttention = ^(int member_id){
        [self.attentionArray removeObject:[NSNumber numberWithInt:member_id]];
        [self.stateArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithInt:0]];
    };
    
    return cell;
}
@end
