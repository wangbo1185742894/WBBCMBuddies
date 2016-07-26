//
//  ModOrderList.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/22.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ModOrderList.h"

@implementation ModOrderList

-(id)initWithTitle:(NSString *)title andInfo:(NSString *)info{

    if (self == [super init]) {
        self.orderInfo = info;
        self.orderTitle = title;
    }
    return self;
}

@end
