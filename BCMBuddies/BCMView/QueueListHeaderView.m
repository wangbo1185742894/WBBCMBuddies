
//
//  QueueListHeaderView.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "QueueListHeaderView.h"

@implementation QueueListHeaderView


-(id)init{

    if (self == [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"QueueListHeaderView" owner:nil options:nil] lastObject];
        return self;
    }
    return self;

}
@end
