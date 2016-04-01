//
//  BCMDefineFile.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMToolLib.h"
#import "BCMURLDefineFile.h"

//#import "MBProgressHUD.h"
#import <CommonCrypto/CommonDigest.h>

#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
#define IS_SCREEN_HEIGH_568 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//设备屏幕高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//static inline void dialogBox(NSString *messageAle)
//{
//    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    
//    MBProgressHUD  *HUDs = [[MBProgressHUD alloc] initWithWindow:window];
//    
//    UIWindow *currentWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
//    
//    [currentWindow addSubview:HUDs];
//    
//    [HUDs setBackgroundColor:RGBA(0, 0, 0, 0.6)];
//    
//    HUDs.mode = MBProgressHUDModeCustomView;
//    
//    HUDs.detailsLabelText = messageAle;
//    
//    [HUDs show:YES];
//    
//    [HUDs hide:YES afterDelay:1];
//    
//}

static inline NSString *md5(NSString *str) {
    const char *original_str = [str UTF8String];
    unsigned char result[16];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

/**
 *  判断一个对象是否为空
 *
 *  @param thing 对象
 *
 *  @return 返回结果
 */
static inline BOOL isObjectEmpty(id thing){
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

/**
 *  判断一个字符串是否为空
 *
 *  @param string 字符串
 *
 *  @return 返回结果
 */
static inline BOOL isStringEmpty(NSString *string){
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
enum settingsEnum
{
    SETTINGS_TIME_SEGMENT       =0,              //
    SETTINGS_RECEIVES_PUSH_MESSAGE,         //
    
    
};



/**
 *  获取一个POST的URLRequest
 *
 *  @param NSDictionary 请求体    urlString 请求URL
 *
 *  @return 返回结果
 */
//static inline NSMutableURLRequest* postURLRequest(NSDictionary *contentDic,NSString *urlString){
//    NSString *httpURL = urlString;
//    if(contentDic.count > 0)
//    {
//        httpURL = [httpURL stringByAppendingString:@"?"];
//        NSArray *keyArray = contentDic.allKeys;
//        for(int i = 0;i < keyArray.count;i++)
//        {
//            NSString *stringWithKey = [keyArray objectAtIndex:i];
//            NSString *valueString = [contentDic objectForKey:stringWithKey];
//            if(i > 0)
//            {
//                httpURL = [httpURL stringByAppendingFormat:@"%@",@"&",nil];
//            }
//            httpURL = [httpURL stringByAppendingFormat:@"%@%@%@",stringWithKey,@"=",valueString,nil];
//        }
//    }
//    httpURL = [httpURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:httpURL];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.timeoutInterval = 30;
//    [request setHTTPMethod: @"POST"];
//    return request;
//}
//
//static inline NSMutableURLRequest* getURLRequest(NSDictionary *contentDic,NSString *urlString){
//    NSString *httpURL = urlString;
//    if(contentDic.count > 0)
//    {
//        httpURL = [httpURL stringByAppendingString:@"?"];
//        NSArray *keyArray = contentDic.allKeys;
//        for(int i = 0;i < keyArray.count;i++)
//        {
//            NSString *stringWithKey = [keyArray objectAtIndex:i];
//            NSString *valueString = [contentDic objectForKey:stringWithKey];
//            if(i > 0)
//            {
//                httpURL = [httpURL stringByAppendingFormat:@"%@",@"&",nil];
//            }
//            httpURL = [httpURL stringByAppendingFormat:@"%@%@%@",stringWithKey,@"=",valueString,nil];
//        }
//    }
//    httpURL = [httpURL stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:httpURL];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    request.timeoutInterval = 30;
//    [request setHTTPMethod: @"GET"];
//    return request;
//}
//
//static inline AFHTTPRequestOperationManager* getOperationManager(){
//    AFHTTPRequestOperationManager *wd_reqManager = [AFHTTPRequestOperationManager manager];
//    wd_reqManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    wd_reqManager.requestSerializer = [AFJSONRequestSerializer serializer];
//    wd_reqManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [wd_reqManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [wd_reqManager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    return wd_reqManager;
//}

static inline NSString *getTimeFromDate(NSTimeInterval time)
{
    NSString *timeString = [[NSNumber numberWithDouble:time] stringValue];
    if(timeString.length > 10)
    {
        timeString = [timeString substringToIndex:10];
    }
    NSDate* compareDate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:compareDate];
    long month = [components month];
    long year = [components year];
    long day = [components day];
    long hour = [components hour];
    long minute = [components minute];
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    long month1 = [components1 month];
    long year1 = [components1 year];
    long day1 = [components1 day];
    //    long hour1 = [components1 hour];
    //    long minute1 = [components1 minute];
    
    NSString *result;
    
    if(year1 == year)
    {
        if(month1 == month)
        {
            if(day1 == day)
            {
                if (minute < 10) {
                    result = [NSString stringWithFormat:@"今天 %ld:0%ld",hour,minute];
                }
                else{
                    result = [NSString stringWithFormat:@"今天 %ld:%ld",hour,minute];
                }
            }
            else
            {
                if(day1 - day == 1)
                {
                    if (minute < 10) {
                        result = [NSString stringWithFormat:@"昨天 %ld:0%ld",hour,minute];
                    }
                    else{
                        result = [NSString stringWithFormat:@"昨天 %ld:%ld",hour,minute];
                    }
                }
                else
                {
                    result = [NSString stringWithFormat:@"%ld-%ld %ld:%ld",month,day,hour,minute];
                }
            }
        }
        else
        {
            result = [NSString stringWithFormat:@"%ld-%ld %ld:%ld",month,day,hour,minute];
        }
    }
    else
    {
        result = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",year,month,day,hour,minute];
    }
    return  result;
}
static inline NSString *getDayFromDate(NSTimeInterval time)
{
    NSString *timeString = [[NSNumber numberWithDouble:time] stringValue];
    if(timeString.length > 10)
    {
        timeString = [timeString substringToIndex:10];
    }
    NSDate* compareDate = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:compareDate];
    NSInteger month = [components month];
    NSInteger year = [components year];
    NSInteger day = [components day];
    NSInteger minute = [components minute];
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:[NSDate date]];
    NSInteger month1 = [components1 month];
    NSInteger year1 = [components1 year];
    NSInteger day1 = [components1 day];
    //    long hour1 = [components1 hour];
    //    long minute1 = [components1 minute];
    
    NSString *result;
    
    if(year1 == year)
    {
        if(month1 == month)
        {
            if(day1 == day)
            {
                if (minute < 10) {
                    result = @"今天";
                }
                else{
                    result = @"今天";
                }
            }
            else
            {
                if(day1 - day == 1)
                {
                    if (minute < 10) {
                        result = @"昨天";
                    }
                    else{
                        result = @"昨天";
                    }
                }
                else
                {
                    result = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
                }
            }
        }
        else
        {
            result = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
        }
    }
    else
    {
        result = [NSString stringWithFormat:@"%ld-%ld",(long)month,(long)day];
    }
    return  result;
}

