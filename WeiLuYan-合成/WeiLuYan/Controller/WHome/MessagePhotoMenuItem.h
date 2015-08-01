//
//  MessagePhotoMenuItem.h
//  testKeywordDemo
//
//  Created by mei on 14-7-26.
//  Copyright (c) 2014年 Bluewave. All rights reserved.
//



#import <UIKit/UIKit.h>

@class MessagePhotoMenuItem;
@protocol MessagePhotoItemDelegate <NSObject>

- (void)messagePhotoItemView:(MessagePhotoMenuItem *)messagePhotoItemView
didSelectDeleteButtonAtIndex:(NSInteger)index;

@end

@interface MessagePhotoMenuItem : UIView

@property(nonatomic,weak)id<MessagePhotoItemDelegate>delegate;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong) UIImage *contentImage;
@property(nonatomic,strong) UIImage *image;
@end
