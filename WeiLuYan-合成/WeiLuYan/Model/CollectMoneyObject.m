//
//  CollectMoneyObject.m
//  WeiLuYan
//
//  Created by mac on 15/1/14.
//  Copyright (c) 2015年 张亮. All rights reserved.
//

#import "CollectMoneyObject.h"

@implementation ApprovalMessage

array_item_impl(new_user,PersonIcon);

-(NSArray *) theNewTitle
{
    return _new_user;
}

-(BOOL) isEmpty
{
    return (_is_approval + _new_user.count) == 0;
}

-(void) clearMine:(int)mine
{
    if( _is_approval )
    {
        NSInteger index = [_new_user indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop)
                           {
                               return (((PersonIcon *)obj).user_id == mine);
                           }];
        
        if( index != NSNotFound ){
            [_new_user removeObjectAtIndex:index];
        }
    }
}



@end


@implementation CollectMoneyObject
//Gson数据检测（与点赞相关）
-(void)didLoad
{
    AccountModel * model = [AccountModel instance];
    PersonalInfoModel * perModel = model.personInfoModel;
    
    [_data_approval clearMine:perModel.member_id];
}



@end
