//
//  ModBank.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModBank : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *logo;
@property(nonatomic,strong)NSString *packageurl;
@property(nonatomic,strong)NSString *deptid;
@property(nonatomic,strong)NSString *appid;
@property(nonatomic,strong)NSString *userid;
@property(nonatomic,strong)NSString *lon;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *tel;

-(id)initWithDic:(NSDictionary *)dic;


-(id)initWithBankName:(NSString *)name andRemark:(NSString *)remark;

@end
