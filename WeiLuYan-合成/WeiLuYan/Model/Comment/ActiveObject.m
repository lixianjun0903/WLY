//
//  FeedExObject.m
//  WeiLuYan
//
//  Created by 锴 吉 on 14/12/3.
//  Copyright (c) 2014年 张亮. All rights reserved.
//

#import "ActiveObject.h"

@implementation ApprovalInfo

array_item_impl(new_user, PersonIcon);

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

@implementation FeedSimple
@end

@implementation ActiveObject

array_item_impl(pic_content, NSString)

-(void)didLoad
{
    AccountModel * model = [AccountModel instance];
    PersonalInfoModel * perModel = model.personInfoModel;
    
    [_data_approval clearMine:perModel.member_id];
}


@end
