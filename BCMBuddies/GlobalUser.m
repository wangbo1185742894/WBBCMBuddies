//
//  GlobalUser.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "GlobalUser.h"

static GlobalUser *user = nil;

@implementation GlobalUser

+(id)globalUser{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        user = [[GlobalUser alloc]init];
       

        
    });

    return user;
}

-(id)init{

    if (self ==[super init]) {
        self.orderDateArray = [[NSMutableArray alloc]init];
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return self;

}


@end
