//
//  BCMZouShiView.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCMZouShiView;

@interface BCMZouShiView : UIView
{
    CALayer *linesLayer;
    UIView *popView;
    UILabel *disLabel;
}
@property (nonatomic, strong) NSArray *m_array;
@property (nonatomic, strong) NSMutableArray *m_buttonArray;
@property (nonatomic, strong) NSMutableArray *m_labelArray;

@end
