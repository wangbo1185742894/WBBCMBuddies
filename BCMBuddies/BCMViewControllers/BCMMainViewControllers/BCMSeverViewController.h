//
//  BCMSeverViewController.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMSeverViewController;

@protocol BCMSeverViewControllerDelegate <NSObject>

@optional

- (void)severViewController:(BCMSeverViewController *)tabBar didSelectIndex:(NSInteger)index;

@end

@interface BCMSeverViewController : BaseViewController

@property (nonatomic, unsafe_unretained) id<BCMSeverViewControllerDelegate> m_delegate;

@end
