//
//  LoadData.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "LoadData.h"
static LoadData *loadData = nil;

@interface LoadData ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;

@end

@implementation LoadData

+(LoadData*)singleLoadData{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadData = [[LoadData alloc]init];
        
    });
    return loadData;

}


-(AFHTTPRequestOperationManager*)manager{

    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return _manager;

}

-(void)requsetWithString:(NSString *)strUrl isPost:(BOOL)isPost andPara:(NSDictionary*)para andComplete:(Complete)complete{


    if (isPost) {
        
        [self.manager POST:strUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            complete(responseObject,YES);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            complete(nil,NO);
            
        }];
        
    }else{
    
        [self.manager GET:strUrl parameters:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            complete(responseObject,YES);
//            NSURL *url = [operation response].URL;
//            NSString *str = [NSString stringWithFormat:@"%@",url];
//            
//            
//            NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:str]];
//          [  operation setOutputStream:[NSOutputStream outputStreamWithURL:url append:NO]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            complete(nil,NO);
        }];
    }

}

@end
