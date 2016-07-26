//
//  ModRootVCQueue.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "ModRootVCQueue.h"

@implementation ModRootVCQueue
-(instancetype)initWithDic:(NSDictionary *)dic{

    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }

    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{


}
@end
