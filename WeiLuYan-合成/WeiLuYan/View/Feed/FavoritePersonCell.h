//
//  SWTableViewCell.h
//  SWTableViewCell
//
//  Created by Chris Wendel on 9/10/13.
//  Copyright (c) 2013 Chris Wendel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "FavouritePerson.h"
#import "attentionObject.h"
@class FavoritePersonCell;

typedef enum {
    kCellStateCenter,
    kCellStateLeft,
    kCellStateRight
} SWCellState;

@protocol FavoritePersonDelegate <NSObject>

@optional
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index;
- (void)swippableTableViewCell:(FavoritePersonCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index;
- (void)swippableTableViewCell:(FavoritePersonCell *)cell scrollingToState:(SWCellState)state;

@end

@interface FavoritePersonCell : UITableViewCell

@property (nonatomic, strong) NSArray *leftUtilityButtons;
@property (nonatomic, strong) NSArray *rightUtilityButtons;
@property (nonatomic) id <FavoritePersonDelegate> delegate;
@property (nonatomic, copy) attentionObject * attentionObject;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier containingTableView:(UITableView *)containingTableView leftUtilityButtons:(NSArray *)leftUtilityButtons rightUtilityButtons:(NSArray *)rightUtilityButtons;

- (void)setBackgroundColor:(UIColor *)backgroundColor;
- (void)hideUtilityButtonsAnimated:(BOOL)animated;
- (CGFloat)getCellHeight;

@end

@interface NSMutableArray (SWUtilityButtons)

- (void)addUtilityButtonWithColor:(UIColor *)color title:(NSString *)title;
- (void)addUtilityButtonWithColor:(UIColor *)color icon:(UIImage *)icon;

@end
