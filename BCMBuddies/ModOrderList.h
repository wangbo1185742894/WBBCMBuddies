//
//  ModOrderList.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/22.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModOrderList : NSObject

@property(nonatomic,strong)NSString *orderTitle;
@property(nonatomic,strong)NSString *orderInfo;

-(id)initWithTitle:(NSString *)title andInfo:(NSString *)info;

@end
