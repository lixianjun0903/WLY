//
//  TeamCollectMoenyView.m
//  WeiLuYan
//
//  Created by mac on 14/12/29.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "TeamCollectMoenyView.h"
#import "TeamMoneyCell.h"
#import "GeneralizedProcessor.h"

@interface TeamCollectMoenyView ()
@property (nonatomic,strong)NSArray * dataArray;
@end

@implementation TeamCollectMoenyView
alloc_with_xib(TeamMoneyView)


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        
    }
    
    return self;
}

-(void)awakeFromNib
{
    _expand = [NSMutableDictionary new];
    self.Expands = 0;
    _moneyProgress.transform = CGAffineTransformMakeScale(1.0f,4.0f);
    _moneyProgress.layer.cornerRadius = 4;
    _moneyProgress.layer.masksToBounds = YES;
    _moneydetailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

-(void)setCollectPro:(MoneyDetailObject *)data
{
    
    self.leftTime.text = [NSString stringWithFormat:@"剩余%@天",data.data_finance.have_days];
    self.alreadyMoney.text = [NSString stringWithFormat:@"已筹集¥%@万",data.data_finance.vote_money];
    float a = [data.data_finance.vote_money floatValue];
    float b = [data.data_finance.finance_money floatValue];
    int item = a / b * 100;
    self.progressLab.text = [NSString stringWithFormat:@"以达到%d％",item];
    float proValue = item / 100.0;
    _moneyProgress.progress = proValue;
    [self loadData:data.data_parks];
}

-(void)loadData:(NSArray *)data
{
    self.dataArray = data;
    [_moneydetailTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TeamMoney"];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"TeamMoneyCell" owner:self options:nil][0];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lsexpand = self.Expands;
        
    }
    [cell config:self.dataArray[indexPath.row]];
    if(_expand[[NSNumber numberWithInteger:indexPath.row]] != nil){
        [cell setExpand:1];
    }
    else{
        [cell setExpand:0];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    cell.tag = indexPath.row;
    
    [cell addObserver:self forKeyPath:@"lsexpand" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell removeObserver:self forKeyPath:@"lsexpand"];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_expand[[NSNumber numberWithInteger:indexPath.row]] != nil)
    {
        return 186;
    }
    else
    {
        return 43;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"lsexpand"])
    {
        TeamMoneyCell * cell = object;
        
        if(cell.lsexpand){
            _expand[[NSNumber numberWithInteger:cell.tag]] = [NSNull null];
        }
        else{
            [_expand removeObjectForKey:[NSNumber numberWithInteger:cell.tag]];
        }

        NSIndexPath * path = [GeneralizedProcessor getNewSection:0 :cell.tag];
        self.ReloadItemPath = path;
    }
}

-(void)setReloadItemPath:(NSIndexPath *)path
{
    
    
    [self.moneydetailTableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    
    NSIndexPath * pa = [GeneralizedProcessor getNewSection:0 :1];

    UITableViewCell * cell = [self.moneydetailTableView cellForRowAtIndexPath:pa];
    NSLog(@"%f",cell.frame.size.height);
}



- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}



@end
