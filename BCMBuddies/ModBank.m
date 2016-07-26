//
//  ModBank.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ModBank.h"

@implementation ModBank

-(id)initWithDic:(NSDictionary *)dic{

    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;

}


-(id)initWithBankName:(NSString *)name andRemark:(NSString *)remark{

    if (self == [super init]) {
        self.name = name ;
        self.remark = remark;
    }
    return self;

}

@end
