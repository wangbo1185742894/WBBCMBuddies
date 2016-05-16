//
//  BusinessItemView.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BusinessItemDelegate <NSObject>

-(void)itemClick:(UIButton *)btn;

@end

@interface BusinessItemView : UIView
@property (strong, nonatomic)  UIImageView *imgIcon;
@property (strong, nonatomic)  UIButton *btnBackclick;
@property (strong, nonatomic)  UILabel *labTitle;

@property (strong,nonatomic)id<BusinessItemDelegate> delegate;
- (void)acitionItemClick:(UIButton *)sender;

@end
