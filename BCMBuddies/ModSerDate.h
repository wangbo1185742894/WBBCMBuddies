//
//  ModSerDate.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModSerDate : NSObject

@property(nonatomic,strong)NSString *resDate;
@property(nonatomic,strong)NSString *resTime;
@property(nonatomic,strong)NSString *status;

-(id)initWithDic:(NSDictionary *)dic;

@end
