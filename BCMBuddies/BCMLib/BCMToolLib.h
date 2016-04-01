//
//  BCMToolLib.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "BCMContent.h"
#import "BCMFolder.h"
#import "BCMContentRes.h"
#import "AppDelegate.h"

@interface BCMToolLib : NSObject

+ (NSString *)getDocumentPath;
+ (NSString *)getMainFolderPath;
+ (NSString *)getCacheFolderPath:(NSString *)appId;
+ (NSString *)getAppDeptFolderPath:(NSString *)appId depdeptId:(NSString *)deptId;
+ (NSString *)getAppFolderPath:(NSString *)appId;
+ (NSString *)getDownloadPath:(NSString *)appId  depdeptId:(NSString *)deptId;
+ (NSString *)getAPPPicturePath:(NSString *)appId  depdeptId:(NSString *)deptId;
+ (NSString *)getResoucePath:(NSString *)appId  depdeptId:(NSString *)deptId contentId:(NSString *)contentId;
//+ (NSString *)getUserThumbnailPath;
//+ (NSString *)getUserPreViewPath;
//+ (NSString *)getVideoPath;
+ (NSString *)getSqlitePath;
+ (NSString *)getSendTime:(long long)timeString;
//+ (int)changePCMToAMR:(NSString *)stringPath;
//+ (int)changeAMRToPCM:(NSString *)stringPath;
+ (void)downloadFileWithOption:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress;
+ (void)showResouceInfoAction:(BCMContent *)content nav:(UINavigationController *)nav isShowServer:(BOOL)show;
+(BOOL)NativeCheckTSSID:(NSString *)Ssid MacID:(NSString *)Mac;

@end
