//
//  GlobalUser.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BCMDefineFile.h"
#import "ModBank.h"

@interface GlobalUser : NSObject

@property (nonatomic,strong)NSString *callMeinfo;
@property(nonatomic,strong)NSString *personNumber;
@property(nonatomic,strong)BCMContent *content;
@property(nonatomic,strong)NSString *strRemmber;

@property (nonatomic,strong)NSString *curBankUser;

@property(nonatomic,strong)NSString *strOrderInfo;
@property (nonatomic,strong)NSString *strOrderTime;
@property (nonatomic,strong)ModBank *curBank;
@property(nonatomic,strong)NSDictionary *waitDic;

@property(nonatomic,strong)NSMutableArray*dataArray;

@property(nonatomic,strong)NSMutableArray *orderDateArray;

@property(assign,nonatomic)NSInteger selectIndex;
@property (nonatomic,strong)NSDictionary *dic;

@property(nonatomic,assign)BOOL isOpenPhone;

@property (nonatomic,strong)NSString *curBankUrl;

+(id)globalUser;
@end
