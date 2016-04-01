//
//  BCMTabBarView.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMTabBarView;

@protocol BCMTabBarViewDelegate <NSObject>

@optional

- (void)tabBar:(BCMTabBarView *)tabBar didSelectIndex:(NSInteger)index;

@end


@interface BCMTabBarView : UIView

@property (nonatomic, unsafe_unretained) id<BCMTabBarViewDelegate> m_delegate;

@property (nonatomic,weak) IBOutlet UILabel *ui_label1;
@property (nonatomic,weak) IBOutlet UILabel *ui_label2;
@property (nonatomic,weak) IBOutlet UILabel *ui_label3;
@property (nonatomic,weak) IBOutlet UIButton *ui_button1;
@property (nonatomic,weak) IBOutlet UIButton *ui_button2;
@property (nonatomic,weak) IBOutlet UIButton *ui_button3;

- (IBAction)tabBarButtonClicked:(id)sender;
- (void)selectTabAtIndex:(NSInteger)index;

@end
