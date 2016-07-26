//
//  LoadData.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^Complete)(id data ,BOOL isSuccess);

@interface LoadData : NSObject

+(LoadData*)singleLoadData;

-(void)requsetWithString:(NSString *)strUrl isPost:(BOOL)isPost andPara:(NSDictionary*)para andComplete:(Complete)complete;


@end
