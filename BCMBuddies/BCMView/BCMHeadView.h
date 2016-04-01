//
//  BCMHeadView.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/25.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMHeadView;

@protocol BCMHeadViewDelegate <NSObject>

@optional

- (void)headViewSelected:(BCMHeadView *)headView didSelectIndex:(NSInteger)index;

@end

@interface BCMHeadView : UIView

@property (nonatomic, unsafe_unretained) id<BCMHeadViewDelegate> m_delegate;
@property (nonatomic,strong) UIScrollView *m_scrollView;
@property (nonatomic,assign) int m_selectedIndex;
@property (nonatomic,assign) int m_count;

- (void)initViewWithTitleArray:(NSArray *)titleArray selected:(int)selectedIndex;

@end
