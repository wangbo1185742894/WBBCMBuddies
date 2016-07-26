//
//  ModRootVCQueue.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModRootVCQueue : NSObject

@property(nonatomic,strong)NSArray *codeList;
@property(nonatomic,strong)NSString *codeType;
@property(nonatomic,strong)NSArray*counterList;
@property(nonatomic,strong)NSString *preServiceTime;
@property(nonatomic,strong)NSString*lastCodeNumber;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
