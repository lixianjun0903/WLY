//
//  FeedItemDataSource.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/7.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "FeedItemDataSource.h"

#import "FeedRequest.h"
#import "ActiveObject.h"
#import "WHomeViewController.h"
#import "WCollectMoneyViewController.h"
#import "ActivityDetailViewController.h"
#import "ActivityInfo.h"
#import "CollectMoneyDetailViewController.h"
#import "MyFavouriteRequest.h"
#import "MBProgressHUD+Show.h"
#import "FeedApprovalView.h"
#import "WMineViewController.h"
#import "WFavoriteController.h"

@interface FeedItemDataSource()
@property( nonatomic, strong) NSMutableDictionary * expand;
@property(nonatomic, strong)AFRequestState * state;
@property(nonatomic,strong)FeedApprovalView * approval;
@end

@implementation FeedItemDataSource

-(id)init
{
    self = [super init];
    
    _dataArray = [NSMutableArray new];
    _expand = [NSMutableDictionary new];
        
    return self;
}

-(void)loadData:(NSArray *)data
{
    _Page = 1;
    
    [_expand removeAllObjects];
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:data];
}

-(void)loadMore:(NSArray *)data
{
    _Page++;
    [_dataArray addObjectsFromArray:data];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.CellType == Fperson){
        static NSString *cellIdentifier = @"Cell";
        FavoritePersonCell *cell = (FavoritePersonCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSMutableArray *leftUtilityButtons = [NSMutableArray new];
            NSMutableArray *rightUtilityButtons = [NSMutableArray new];
            
            [rightUtilityButtons addUtilityButtonWithColor:
            [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                     title:@"取消关注"];
            
            cell = [[FavoritePersonCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:cellIdentifier
                                      containingTableView:self.TableView
                                       leftUtilityButtons:leftUtilityButtons
                                      rightUtilityButtons:rightUtilityButtons];
            cell.delegate = self;
        }

       
        NSObject * obj = self.dataArray[indexPath.row];
        
        if([obj isKindOfClass:[attentionObject class]])
         {
            cell.attentionObject = _dataArray[indexPath.row];
         }
        return cell;
    }else{
        FeedItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if( cell == nil )
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FeedItemCell" owner:self options:nil] firstObject];
        cell.Controller = _Controller;
        [cell initView];
    }
    cell.reLoadBlock = self.reLoadBlock;
    NSObject * obj = self.dataArray[indexPath.row];
    if([obj isKindOfClass:[CollectMoneyObject class]])
    {
        cell.Data = _dataArray[indexPath.row];
        cell.CellType = Project;

    }else if([obj isKindOfClass:[ActivityInfo class]]){
        cell.ActData = _dataArray[indexPath.row];
        cell.CellType = Home;
    }
    
    if(_expand[[NSNumber numberWithInteger:indexPath.row]] != nil){
        cell.Style = _CellType | Expand;
    }
    else{
        cell.Style = _CellType;
    }
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.CellType == Fperson) {
        return [[FavoritePersonCell new] getCellHeight];
    }
    else if(_expand[[NSNumber numberWithInteger:indexPath.row]] != nil){
        
        
        return [FeedItemCell getCellHeight:Separator | Expand ];
        
    }
    else{
        return [FeedItemCell getCellHeight:Separator ];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(_CellType == 0)
    {
        ActivityDetailViewController * adv = [ActivityDetailViewController new];
        adv.reLoadBlock = ^
        {
            self.reLoadBlock();
        
        };
        ActivityInfo * model = self.dataArray[indexPath.row];
        adv.mid = model.feedcontent_id;
        
        [self.Controller.navigationController pushViewController:adv animated:YES];
    }
    else if(_CellType == 2)
    {
        CollectMoneyDetailViewController * wd = [CollectMoneyDetailViewController new];
        CollectMoneyObject * model = self.dataArray[indexPath.row];
        
        wd.mid = model.project_id;
        
        [self.Controller.navigationController pushViewController:wd animated:YES];
    }
    else if(_CellType == 1){
        CollectMoneyDetailViewController * wd = [CollectMoneyDetailViewController new];
        CollectMoneyObject * model = self.dataArray[indexPath.row];
        
        wd.mid = model.project_id;
        
        [self.Controller.navigationController pushViewController:wd animated:YES];
    }
    
   else if(_CellType == Fperson){
       attentionObject *attentionObject = _dataArray[indexPath.row];
      int mId = attentionObject.member_id;
       WFavoriteController * fa = (WFavoriteController *)self.Controller;
       //fa.isAttentionPerson = YES;
       WMineViewController * mvc = [WMineViewController new];
       mvc.useridd = mId;
       [self.Controller.navigationController pushViewController:mvc animated:YES];
    }
    
   else if (_CellType ==  Fproject) {
       CollectMoneyDetailViewController * wd = [CollectMoneyDetailViewController new];
       CollectMoneyObject * model = self.dataArray[indexPath.row];
       wd.mid = model.project_id;
       [self.Controller.navigationController pushViewController:wd animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.tag = indexPath.row;
    
    [cell addObserver:self forKeyPath:@"Style" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell removeObserver:self forKeyPath:@"Style"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"Style"])
    {
        FeedItemCell * cell = object;
        
        if(cell.isExpand){
            _expand[[NSNumber numberWithInteger:cell.tag]] = [NSNull null];
        }
        else{
            [_expand removeObjectForKey:[NSNumber numberWithInteger:cell.tag]];
        }
        
        NSUInteger index[] = {0, cell.tag};
        NSIndexPath * path = [[NSIndexPath alloc] initWithIndexes:index length:2];
        
        self.ReloadItemPath = path;
    }
 
}


-(void)setReloadItemPath:(NSIndexPath *)path
{
    [self.TableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}

//左滑暂时不支持
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
}

//右滑
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
           NSIndexPath *cellIndexPath = [self.TableView indexPathForCell:cell];
           int row = cellIndexPath.row;
           attentionObject *attentionObject = _dataArray[row];
            NSArray * array = @[[NSNumber numberWithInt:attentionObject.member_id]];
           [MyFavouriteRequest cancelFavoriteWithId:array with:^(NSNumber *result) {
               if ([result intValue] == 1) {
                   [_dataArray removeObjectAtIndex:row];
                   //[MBProgressHUD creatembHub:@"取消成功"];
                   self.reLoadBlock();
               }else{
                   [MBProgressHUD creatembHub:@"取消失败"];
               }
            }];
            break;
        }
        default:
        break;
    }
}

@end