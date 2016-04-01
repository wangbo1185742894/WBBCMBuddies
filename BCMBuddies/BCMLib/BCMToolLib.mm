//
//  BCMToolLib.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMToolLib.h"
#import "BCMInfoViewController.h"
#import "ZipArchive.h"
#import "MBProgressHUD.h"

const char *legal32Chars = "ABCDEFGHJKLMNPQRTUVWXY0123456789"; //为了使所有字符都是可见的
static const int BASE32_ENCODE_INPUT = 5;
static const int BASE32_ENCODE_OUTPUT = 8;

static const int BASE32_DECODE_INPUT = 8;
static const int BASE32_DECODE_OUTPUT = 5;
static const unsigned char BASE32_DECODE_MAX = 31;
static const unsigned char BASE32_DECODE_TABLE[0x80] = { 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x16, 0x17, 0x18, 0x19,
    0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, 0xFF, 0xFF, 0xFF, 0x20, 0xFF, 0xFF,
    0xFF, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0xFF, 0x08, 0x09,
    0x0A, 0x0B, 0x0C, 0xFF, 0x0D, 0x0E, 0x0F, 0xFF, 0x10, 0x11, 0x12, 0x13,
    0x14, 0x15, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x01, 0x02,
    0x03, 0x04, 0x05, 0x06, 0x07, 0xFF, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0xFF,
    0x0D, 0x0E, 0x0F, 0xFF, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0xFF, 0xFF,
    0xFF, 0xFF, 0xFF, 0xFF };

@implementation BCMToolLib
+ (NSString *)getCurrentTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM HH:mm"];
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    return timeStr;
}
+ (NSDate *)getDateFromString:(NSString *)time
{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
    [fm setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSDate *wk_date = [fm dateFromString:time];//
    return wk_date;
}
+ (NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    return documents;
}
+ (NSString *)getMainFolderPath
{
    NSString *documents = [BCMToolLib getDocumentPath];
    NSString *wd_path = [documents stringByAppendingPathComponent:@"BCMBuddy"];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:wd_path isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:wd_path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return wd_path;
}
+ (NSString *)getCacheFolderPath:(NSString *)appId
{
    NSString *cachePath = [[BCMToolLib getAppFolderPath:appId] stringByAppendingPathComponent:@"Cache"];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:cachePath isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return cachePath;
}

+ (NSString *)getAppDeptFolderPath:(NSString *)appId depdeptId:(NSString *)deptId
{
    NSString *deptIdPath = [[BCMToolLib getAppFolderPath:appId] stringByAppendingPathComponent:deptId];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:deptIdPath isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:deptIdPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return deptIdPath;
}
+ (NSString *)getAppFolderPath:(NSString *)appId
{
    NSString *documents = [BCMToolLib getMainFolderPath];
    NSString *wd_path = [documents stringByAppendingPathComponent:appId];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:wd_path isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:wd_path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return wd_path;
}
+ (NSString *)getDownloadPath:(NSString *)appId depdeptId:(NSString *)deptId
{
    NSString *downloadPath = [[BCMToolLib getAppFolderPath:appId] stringByAppendingPathComponent:@"downloadPath"];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:downloadPath isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:downloadPath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return downloadPath;
}
+ (NSString *)getAPPPicturePath:(NSString *)appId depdeptId:(NSString *)deptId
{
    NSString *picturePath = [[BCMToolLib getAppFolderPath:appId] stringByAppendingPathComponent:@"picturePath"];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:picturePath isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:picturePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return picturePath;
}
+ (NSString *)getResoucePath:(NSString *)appId depdeptId:(NSString *)deptId contentId:(NSString *)contentId
{
    NSString *resoucePath = [[BCMToolLib getAppFolderPath:appId] stringByAppendingPathComponent:@"contentId"];
    NSFileManager *wk_manager = [NSFileManager defaultManager];
    BOOL wk_isExist,wk_isDirectory;
    wk_isExist = [wk_manager fileExistsAtPath:resoucePath isDirectory:&wk_isDirectory];
    if(wk_isExist == NO || wk_isDirectory == NO)
    {
        [wk_manager createDirectoryAtPath:resoucePath withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    return resoucePath;
}
//+ (NSString *)getUserThumbnailPath
//{
//    NSString *thumbnailPath = [[WDToolLib getUserPicturePath] stringByAppendingPathComponent:@"thumbnail"];
//    NSFileManager *wk_manager = [NSFileManager defaultManager];
//    BOOL wk_isExist,wk_isDirectory;
//    wk_isExist = [wk_manager fileExistsAtPath:thumbnailPath isDirectory:&wk_isDirectory];
//    if(wk_isExist == NO || wk_isDirectory == NO)
//    {
//        [wk_manager createDirectoryAtPath:thumbnailPath withIntermediateDirectories:YES attributes:nil error:NULL];
//    }
//    return thumbnailPath;
//}
//+ (NSString *)getUserPreViewPath
//{
//    NSString *preViewPath = [[WDToolLib getUserPicturePath] stringByAppendingPathComponent:@"preView"];
//    NSFileManager *wk_manager = [NSFileManager defaultManager];
//    BOOL wk_isExist,wk_isDirectory;
//    wk_isExist = [wk_manager fileExistsAtPath:preViewPath isDirectory:&wk_isDirectory];
//    if(wk_isExist == NO || wk_isDirectory == NO)
//    {
//        [wk_manager createDirectoryAtPath:preViewPath withIntermediateDirectories:YES attributes:nil error:NULL];
//    }
//    return preViewPath;
//}
//+ (NSString *)getVideoPath
//{
//    NSString *videoPath = [[BCMToolLib getUserFolderPath] stringByAppendingPathComponent:@"video"];
//    NSFileManager *wk_manager = [NSFileManager defaultManager];
//    BOOL wk_isExist,wk_isDirectory;
//    wk_isExist = [wk_manager fileExistsAtPath:videoPath isDirectory:&wk_isDirectory];
//    if(wk_isExist == NO || wk_isDirectory == NO)
//    {
//        [wk_manager createDirectoryAtPath:videoPath withIntermediateDirectories:YES attributes:nil error:NULL];
//    }
//    return videoPath;
//}
//
//+ (NSString *)getSqlitePath
//{
//    NSString *wk_userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
//    NSString *database_path = [BCMToolLib getUserFolderPath];
//    database_path = [database_path stringByAppendingPathComponent:wk_userID];
//    database_path = [database_path stringByAppendingPathExtension:@"sqlite"];
//    return database_path;
//}
+ (NSString *)getSendTime:(long long)timeString
{
    NSDate *date;
    if(timeString >= 10000000000)
    {
        double wk_newvalue = (double)(timeString/1000);
        date = [NSDate dateWithTimeIntervalSince1970:wk_newvalue];
    }
    else
    {
        date = [NSDate dateWithTimeIntervalSince1970:timeString];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:date];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *timeStr1 = [formatter stringFromDate:date];
    NSDate *wk_date1 = [formatter dateFromString:timeStr1];
    NSString *timeStr2 = [formatter stringFromDate:[NSDate date]];
    NSDate *wk_date2 = [formatter dateFromString:timeStr2];
    NSString *wk_string;
    if([wk_date1 isEqualToDate:wk_date2])
    {
        wk_string = [NSString stringWithFormat:@"%@%@",@"今天 ",timeStr,nil];
    }else
    {
        NSTimeInterval wk_timeInterval = [wk_date2 timeIntervalSinceDate:wk_date1];
        if(wk_timeInterval == 86400)
        {
            wk_string = [NSString stringWithFormat:@"%@%@",@"昨天 ",timeStr,nil];
        }
        else
        {
            [formatter setDateFormat:@"M月d日 "];
            wk_string = [NSString stringWithFormat:@"%@%@",[formatter stringFromDate:wk_date1],timeStr,nil];
        }
    }
    return wk_string;
}

//+ (int)changePCMToAMR:(NSString *)stringPath
//{
//    NSString *PCMstringPath = [stringPath stringByDeletingPathExtension];
//    PCMstringPath = [PCMstringPath stringByAppendingPathExtension:@"wav"];
//    NSString *PCMstringPath2 = [stringPath stringByDeletingPathExtension];
//    PCMstringPath2 = [PCMstringPath2 stringByAppendingPathExtension:@"amr"];
//    return EncodeWAVEFileToAMRFile([PCMstringPath UTF8String],[PCMstringPath2 UTF8String],1,16);
//}
//+ (int)changeAMRToPCM:(NSString *)stringPath
//{
//    NSString *PCMstringPath = [stringPath stringByDeletingPathExtension];
//    PCMstringPath = [PCMstringPath stringByAppendingPathExtension:@"wav"];
//    return DecodeAMRFileToWAVEFile([stringPath UTF8String],[PCMstringPath UTF8String]);
//}
+ (void)downloadFileWithOption:(NSString*)requestURL
                     savedPath:(NSString*)savedPath
               downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                      progress:(void (^)(float progress))progress
{
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:nil error:nil];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
    }];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    [operation start];
}

+ (void)showResouceInfoAction:(BCMContent *)content nav:(UINavigationController *)nav isShowServer:(BOOL)show
{
    MBProgressHUD *wd_hud = [MBProgressHUD showHUDAddedTo:nav.view animated:YES];
    wd_hud.label.text = @"加载中...";
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *wd_pathString;
    NSString *wd_urlStringValue;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        wd_urlStringValue = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,content.folderId,content.id];
        wd_pathString = content.file;
    }
    else
    {
        wd_urlStringValue = wd_appDelegate.m_urlPath;
        wd_pathString = content.filehosturl;
    }
    if([content.iszip isEqualToString:@"true"] && [wd_pathString.pathExtension isEqualToString:@"zip"])
    {
        NSString *wd_resoucePath = [BCMToolLib getResoucePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId contentId:content.id];
        NSString *wd_picString = [wd_resoucePath stringByAppendingPathComponent:[wd_pathString lastPathComponent]];
        NSFileManager *wd_fileManage = [NSFileManager defaultManager];
        if([wd_fileManage fileExistsAtPath:wd_picString])
        {
            NSString *wd_stringURL = [wd_resoucePath stringByAppendingPathComponent:content.defaultopenlink];
            if([wd_fileManage fileExistsAtPath:wd_stringURL])
            {
                BCMInfoViewController *wd_infoViewController = [[BCMInfoViewController alloc] initWithNibName:@"BCMInfoViewController" bundle:nil];
                wd_infoViewController.m_urlString = wd_stringURL;
                wd_infoViewController.m_content = content;
                wd_infoViewController.m_showServer = show;
                [nav pushViewController:wd_infoViewController animated:YES];
                [wd_hud hideAnimated:YES];
            }
            else
            {
                ZipArchive *za = [[ZipArchive alloc] init];
                if ([za UnzipOpenFile:wd_picString]) {
                    BOOL ret = [za UnzipFileTo:wd_resoucePath overWrite:YES];
                    if (NO == ret){}
                    [za UnzipCloseFile];
                    BCMInfoViewController *wd_infoViewController = [[BCMInfoViewController alloc] initWithNibName:@"BCMInfoViewController" bundle:nil];
                    wd_infoViewController.m_urlString = wd_stringURL;
                    wd_infoViewController.m_content = content;
                    wd_infoViewController.m_showServer = show;
                    [nav pushViewController:wd_infoViewController animated:YES];
                    [wd_hud hideAnimated:YES];
                }
                else
                {
                    [wd_hud hideAnimated:YES];
                }
            }
        }
        else
        {
            NSString *wd_resoucePath = [BCMToolLib getResoucePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId contentId:content.id];
            NSString *wd_fileName = [wd_pathString lastPathComponent];
            NSString *wd_savePath = [wd_resoucePath stringByAppendingPathComponent:wd_fileName];
            NSString *wd_urlString = [wd_urlStringValue stringByAppendingString:wd_pathString];
            [BCMToolLib downloadFileWithOption:wd_urlString savedPath:wd_savePath
                               downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   ZipArchive *za = [[ZipArchive alloc] init];
                                   if ([za UnzipOpenFile:wd_savePath]) {
                                       BOOL ret = [za UnzipFileTo:wd_resoucePath overWrite:YES];
                                       if (NO == ret){}
                                       [za UnzipCloseFile];
                                       BCMInfoViewController *wd_infoViewController = [[BCMInfoViewController alloc] initWithNibName:@"BCMInfoViewController" bundle:nil];
                                       wd_infoViewController.m_urlString = [wd_resoucePath stringByAppendingPathComponent:content.defaultopenlink];
                                       wd_infoViewController.m_content = content;
                                       wd_infoViewController.m_showServer = show;
                                       [nav pushViewController:wd_infoViewController animated:YES];
                                       [wd_hud hideAnimated:YES];
                                   }
                               } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   [wd_hud hideAnimated:YES];
                               } progress:^(float progress) {
                               }];
        }
    }
    else
    {
        NSString *wd_resoucePath = [BCMToolLib getResoucePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId contentId:content.id];
        NSString *wd_picString = [wd_resoucePath stringByAppendingPathComponent:[wd_pathString lastPathComponent]];
        NSFileManager *wd_fileManage = [NSFileManager defaultManager];
        if([wd_fileManage fileExistsAtPath:wd_picString])
        {
            BCMInfoViewController *wd_infoViewController = [[BCMInfoViewController alloc] initWithNibName:@"BCMInfoViewController" bundle:nil];
            wd_infoViewController.m_urlString = wd_picString;
            wd_infoViewController.m_content = content;
            wd_infoViewController.m_showServer = show;
            [nav pushViewController:wd_infoViewController animated:YES];
            [wd_hud hideAnimated:YES];
        }
        else
        {
            
            NSString *wd_urlString = [wd_urlStringValue stringByAppendingString:wd_pathString];
            [BCMToolLib downloadFileWithOption:wd_urlString savedPath:wd_picString
                               downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                                   BCMInfoViewController *wd_infoViewController = [[BCMInfoViewController alloc] initWithNibName:@"BCMInfoViewController" bundle:nil];
                                   wd_infoViewController.m_urlString = wd_picString;
                                   wd_infoViewController.m_content = content;
                                   wd_infoViewController.m_showServer = show;
                                   [nav pushViewController:wd_infoViewController animated:YES];
                                   [wd_hud hideAnimated:YES];
                               } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                   [wd_hud hideAnimated:YES];

                               } progress:^(float progress) {
                               }];
        }
    }
}

+ (BOOL)timeIsSame:(long)time1 time:(long)time2
{
    NSDate *wd_date1 = [NSDate dateWithTimeIntervalSince1970:time1];
    NSDate *wd_date2 = [NSDate dateWithTimeIntervalSince1970:time2];
    return [wd_date1 isEqualToDate:wd_date2];
}

int base32Decode(void* dest, const char* src, int size) {
    while (size % BASE32_DECODE_INPUT != 0) {
        src += '=';
        size++;
    }
    if (dest && src && (size % BASE32_DECODE_INPUT == 0)) {
        unsigned char* pDest = (unsigned char*) dest;
        int dwSrcSize = size;
        int dwDestSize = 0;
        unsigned char in1, in2, in3, in4, in5, in6, in7, in8;
        
        while (dwSrcSize >= 1) {
            /* 8 inputs */
            in1 = *src++;
            in2 = *src++;
            in3 = *src++;
            in4 = *src++;
            in5 = *src++;
            in6 = *src++;
            in7 = *src++;
            in8 = *src++;
            dwSrcSize -= BASE32_DECODE_INPUT;
            
            /* Validate ascii */
            if (in1 >= 0x80 || in2 >= 0x80 || in3 >= 0x80 || in4 >= 0x80
                || in5 >= 0x80 || in6 >= 0x80 || in7 >= 0x80 || in8 >= 0x80)
                return 0; /*ERROR - invalid base32 character*/
            
            /* Convert ascii to base16 */
            in1 = BASE32_DECODE_TABLE[in1];
            in2 = BASE32_DECODE_TABLE[in2];
            in3 = BASE32_DECODE_TABLE[in3];
            in4 = BASE32_DECODE_TABLE[in4];
            in5 = BASE32_DECODE_TABLE[in5];
            in6 = BASE32_DECODE_TABLE[in6];
            in7 = BASE32_DECODE_TABLE[in7];
            in8 = BASE32_DECODE_TABLE[in8];
            
            /* Validate base32 */
            if (in1 > BASE32_DECODE_MAX || in2 > BASE32_DECODE_MAX)
                return 0; /*ERROR - invalid base32 character*/
            /*the following can be padding*/
            if ((int) in3 > (int) BASE32_DECODE_MAX + 1
                || (int) in4 > (int) BASE32_DECODE_MAX + 1
                || (int) in5 > (int) BASE32_DECODE_MAX + 1
                || (int) in6 > (int) BASE32_DECODE_MAX + 1
                || (int) in7 > (int) BASE32_DECODE_MAX + 1
                || (int) in8 > (int) BASE32_DECODE_MAX + 1)
                return 0; /*ERROR - invalid base32 character*/
            
            /* 5 outputs */
            *pDest++ = ((unsigned char) (in1 & 0x1f) << 3)
            | ((unsigned char) (in2 & 0x1c) >> 2);
            *pDest++ = ((unsigned char) (in2 & 0x03) << 6)
            | ((unsigned char) (in3 & 0x1f) << 1)
            | ((unsigned char) (in4 & 0x10) >> 4);
            *pDest++ = ((unsigned char) (in4 & 0x0f) << 4)
            | ((unsigned char) (in5 & 0x1e) >> 1);
            *pDest++ = ((unsigned char) (in5 & 0x01) << 7)
            | ((unsigned char) (in6 & 0x1f) << 2)
            | ((unsigned char) (in7 & 0x18) >> 3);
            *pDest++ = ((unsigned char) (in7 & 0x07) << 5) | (in8 & 0x1f);
            dwDestSize += BASE32_DECODE_OUTPUT;
            
            /* Padding */
            if (in8 == BASE32_DECODE_MAX + 1) {
                --dwDestSize;
                assert(
                       (in7 == BASE32_DECODE_MAX + 1 && in6 == BASE32_DECODE_MAX + 1) || (in7 != BASE32_DECODE_MAX + 1));
                if (in6 == BASE32_DECODE_MAX + 1) {
                    --dwDestSize;
                    if (in5 == BASE32_DECODE_MAX + 1) {
                        --dwDestSize;
                        assert(
                               (in4 == BASE32_DECODE_MAX + 1 && in3 == BASE32_DECODE_MAX + 1) || (in4 != BASE32_DECODE_MAX + 1));
                        if (in3 == BASE32_DECODE_MAX + 1) {
                            --dwDestSize;
                        }
                    }
                }
            }
        }
        *pDest++ = '\x0'; /*append terminator*/
        
        return dwDestSize;
    } else
        return 0; /*ERROR - null pointer, or size isn't a multiple of 8*/
}
int base32Encode(char* dest, const void* src, int size)
{
    
    if (dest && src) {
        //__android_log_print(5, "C_Interface", ":::base32Encode__in£∫::%s,%s",
        //		dest, src);
        
        unsigned char* pSrc = (unsigned char*) src;
        int dwSrcSize = size;
        int dwDestSize = 0;
        int dwBlockSize;
        unsigned char n1, n2, n3, n4, n5, n6, n7, n8;
        
        while (dwSrcSize >= 1) {
            /* Encode inputs */
            dwBlockSize = (
                           dwSrcSize < BASE32_ENCODE_INPUT ?
                           dwSrcSize : BASE32_ENCODE_INPUT);
            n1 = n2 = n3 = n4 = n5 = n6 = n7 = n8 = 0;
            switch (dwBlockSize) {
                case 5:
                    n8 = (pSrc[4] & 0x1f);
                    n7 = ((unsigned char) (pSrc[4] & 0xe0) >> 5);
                    /* no break */
                case 4:
                    n7 |= ((unsigned char) (pSrc[3] & 0x03) << 3);
                    n6 = ((unsigned char) (pSrc[3] & 0x7c) >> 2);
                    n5 = ((unsigned char) (pSrc[3] & 0x80) >> 7);
                    /* no break */
                case 3:
                    n5 |= ((unsigned char) (pSrc[2] & 0x0f) << 1);
                    n4 = ((unsigned char) (pSrc[2] & 0xf0) >> 4);
                    
                    /* no break */
                case 2:
                    n4 |= ((unsigned char) (pSrc[1] & 0x01) << 4);
                    n3 = ((unsigned char) (pSrc[1] & 0x3e) >> 1);
                    n2 = ((unsigned char) (pSrc[1] & 0xc0) >> 6);
                    /* no break */
                case 1:
                    n2 |= ((unsigned char) (pSrc[0] & 0x07) << 2);
                    n1 = ((unsigned char) (pSrc[0] & 0xf8) >> 3);
                    break;
                    
                default:
                    assert( 0);
                    /* no break */
            }
            pSrc += dwBlockSize;
            dwSrcSize -= dwBlockSize;
            
            /* Validate */
            assert( n1 <= 31);
            assert( n2 <= 31);
            assert( n3 <= 31);
            assert( n4 <= 31);
            assert( n5 <= 31);
            assert( n6 <= 31);
            assert( n7 <= 31);
            assert( n8 <= 31);
            
            /* Padding */
            switch (dwBlockSize) {
                case 1:
                    n3 = n4 = 32;
                    /* no break */
                case 2:
                    n5 = 32;
                    /* no break */
                case 3:
                    n6 = n7 = 32;
                    /* no break */
                case 4:
                    n8 = 32;
                    /* no break */
                case 5:
                    break;
                    
                default:
                    assert( 0);
                    /* no break */
            }
            
            /* 8 outputs */
            *dest++ = legal32Chars[n1];
            *dest++ = legal32Chars[n2];
            *dest++ = legal32Chars[n3];
            *dest++ = legal32Chars[n4];
            *dest++ = legal32Chars[n5];
            *dest++ = legal32Chars[n6];
            *dest++ = legal32Chars[n7];
            *dest++ = legal32Chars[n8];
            dwDestSize += BASE32_ENCODE_OUTPUT;
        }
        *dest++ = '\x0'; /*append terminator*/
        
        return dwDestSize;
    } else
        return 0; /*ERROR - null pointer*/
}
+ (NSString *)base32Decode:(NSString *)ssidLast13
{
    const char *data = [ssidLast13 UTF8String];
    int dataSize = (int)ssidLast13.length;
    if (data == NULL) {
        return NULL;
    }
    int size;
    size = dataSize;
    while (size % 8 != 0) {
        size++;
    }
    
    char in[size];
    memset((void *) in, 0, size);
    for (int i = 0; i < size; i++) {
        if (i < dataSize) {
            in[i] = data[i];
        } else {
            in[i] = 61;
        }
    }
    
    char outTemp[dataSize];
    memset((void *) outTemp, 0, dataSize);
    int i = base32Decode(outTemp, in, size);
    char outStr[i];
    memset((void *) outStr, 0, i);
    if (i > 0) {
        for (int m = 0; m < i; m++) {
            outStr[m] = outTemp[m];
        };
    }
    return [[NSString alloc] initWithCString:outStr encoding:NSUTF8StringEncoding];
}
+ (NSString *)base32Encode:(NSString *)ssidLast13
{
    const char *data = [ssidLast13 UTF8String];
    int dataSize = (int)ssidLast13.length;
    char outTemp[255];
    memset((void *)outTemp, 0, 255);
    int i = base32Encode(outTemp, data, dataSize);
    char outStr[i];
    if (i > 0) {
        for (int m = 0; m < i; m++) {
            if (outTemp[m] != '=') { //去除'='
                outStr[m] = outTemp[m];
            }
        }
    }
    return [[NSString alloc] initWithCString:outStr encoding:NSUTF8StringEncoding];
}
+ (BOOL)checkBase32Char:(NSString *)jsString
{
    const char *str = [jsString UTF8String];
    if (str == NULL) {
        return NO;
    }
    bool isXaonlyBase32Char = true;
    int i, j;
    if (str == NULL) {
        return NO;
    }
    for (i = 0; i < strlen(str); i++) {
        for (j = 0; j < strlen(legal32Chars); j++) {
            if (str[i] == legal32Chars[j]) {
                break;
            }
        }
        
        if (j >= strlen(legal32Chars)) {
            break;
        }
    }
    
    if (i < strlen(str)) {
        isXaonlyBase32Char = false;
    }
    if (isXaonlyBase32Char == true)
    {
        return YES;
    }
    return NO;
}
char (*bssid2Mac(const char *s))[6]
{
    if (strlen(s) != 17) {
        return NULL;
    }
    //__android_log_print(6, "C_Interface", "::bssid2mac::in=%s", s);
    char (*out)[6];
    out = (char (*)[6]) malloc(6 * sizeof(char));
    
    // split s
    char delims[] = ":";
    char strTemp[18];
    memset((void *) strTemp, 0, 18);
    int si = 0;
    for (si = 0; si < 17; si++) {
        strTemp[si] = s[si];
    }
    strTemp[17] = '\0';
    //__android_log_print(6, "C_Interface", "::bssid2mac::out=%s", s);
    
    char *result = NULL;
    result = strtok(strTemp, delims);
    int a1, a2;
    int j = 0;
    for (j = 0; j <= 5; j++) {
        a1 = result[0];
        a2 = result[1];
        
        a1 -= 48;
        if (a1 >= 17 && a1 <= 22) {
            a1 -= 7;
        }
        if (a1 >= 49 && a1 <= 54) {
            a1 -= 39;
        }
        if (a1 < 0 || a1 > 15) {
            return NULL;
        }
        
        a2 -= 48;
        if (a2 >= 17 && a2 <= 22) {
            a2 -= 7;
        }
        if (a2 >= 49 && a2 <= 54) {
            a2 -= 39;
        }
        if (a2 < 0 || a2 > 15) {
            return NULL;
        }
        (*out)[j] = (char) (a1 * 16 + a2);
        result = strtok(NULL, delims);
    }
    //__android_log_print(6, "C_Interface", "::bssid2mac::__end--");
    return out;
}
/**
 *依据mac地址，根据传入的长度需求，生成对应的mac校验码
 * 使用:int (*result)[6] = makeMacCheck(*inmac，bytecount);
 */
char (*makeMacCheck(char *inMac, int bytecount))[6] { //返回的数组最大是6
    
    char (*returnbyte)[6];
    returnbyte = (char (*)[6]) malloc(6 * sizeof(char));
    
    char macbyte[7];
    memset((void *) macbyte, 0, 7);
    int nowbound;
    int i;
    int j;
    
    for (i = 0; i < 6; i++) {
        macbyte[i] = inMac[i];
    }
    macbyte[6] = '\0';
    
    nowbound = 6 - 1; //nowbound必须应该是五
    for (j = nowbound; j >= bytecount; j--) {
        for (i = 0; i <= j - 1; i++) {
            macbyte[i] = (macbyte[i] ^ macbyte[i + 1]);
        }
    }
    
    for (i = 0; i < bytecount; i++) {
        (*returnbyte)[i] = macbyte[i];
    }
    
    return returnbyte;
}
+(BOOL)NativeCheckTSSID:(NSString *)Ssid MacID:(NSString *)Mac
{
    if (Ssid == nil || Mac == nil) {
        return NO;
    }
    if (Ssid.length < 14) {
        return NO;
    }
    NSString *wd_last14 = [Ssid substringFromIndex:Ssid.length - 14];
    NSString *wd_last13 = [Ssid substringFromIndex:Ssid.length - 13];
    if (![BCMToolLib checkBase32Char:wd_last13]) {
        return NO;
    }
    if (![[wd_last14 substringToIndex:1] isEqualToString:@"-"]) {
        return NO;
    }
//    NSString *wd_base32DecodeString = [BCMToolLib base32Decode:wd_last13];
    char right13String[13];
//    int ssidLen;
    char cMac[6];
    memset((void *) cMac, 0, 6);
    char tmpmac_check[6];
    memset((void *) tmpmac_check, 0, 6);
    int i;
    char ossid_version;
    char ossid_len_byte;
    char TPwd[32];
    memset((void *) TPwd, 0, 32);
    int TStoreID;
    int TAppID;
    int TType;
    int TPwdType;
    int CheckTType = 0;
    int RemoveTType = 0;
    int APPID = 8388609;
    // 客户端模拟的传输器SSID长度至少为14个字符
    
    // 客户端模拟的传输器SSID后13位字符必须符合xaonlybase32编码规范
    for (i = 13; i > 0; i--) {
        right13String[13 - i] = [Ssid characterAtIndex:Ssid.length - i]; //取得ssid后13位
    }
    // 将客户端模拟的传输器SSID后13位字符进行xaonlybase32解码
    char in32String[16];
    memset((void *) in32String, 0, 16);
    for (int i = 0; i < 16; i++) {
        if (i < 13) {
            in32String[i] = right13String[i];
        } else {
            in32String[i] = 61;
        }
    }
    
    //__android_log_print(6, "C_Interface",
    //		"::Native___checkClientTSSID::%s--开始解码",
    //		in32String);
    
    char outTemp[13];
    memset((void *) outTemp, 0, 13);
    int decodeOutSize = base32Decode(outTemp, in32String, 16);
    char cOssid[decodeOutSize];
    memset((void *) cOssid, 0, decodeOutSize);
    if (decodeOutSize > 0) {
        for (int m = 0; m < decodeOutSize; m++) {
            cOssid[m] = outTemp[m];
        }
    }
    // 将头2字节与自身2字节的mac地址校验码进行异或
    char (*temp_cMac)[6] = bssid2Mac([Mac UTF8String]);
    for (i = 0; i < 6; i++) {
        cMac[i] = (*temp_cMac)[i];
    }
    free(temp_cMac);
    char (*temp_tmpmac_check)[6] = makeMacCheck(cMac, 2);
    for (i = 0; i < 2; i++) {
        tmpmac_check[i] = (*temp_tmpmac_check)[i];
    }
    free(temp_tmpmac_check);
    
    cOssid[0] = (char) (cOssid[0] ^ tmpmac_check[0]);
    cOssid[1] = (char) (cOssid[1] ^ tmpmac_check[1]);
    
    // 第一个字节的高3位是协议版本号
    ossid_version = (char) ((cOssid[0] & 0xe0) / 32);
    
    // 目前协议版本号1
    if (ossid_version != 1) {
        return NO;
    }
    
    // 第一个字节的低5位是OSSID长度定义区
    ossid_len_byte = (char) (cOssid[0] & 0x1f);
    if (ossid_len_byte != decodeOutSize) {
        return NO; // 如果ossid长度不符合OSSID长度定义区定义的话
    }
    
    // 协议版本1中OSSID的长度定义为8字节
    if (ossid_len_byte != 8) {
        return NO; // 协议版本1中客户端模拟的传输器OSSID的长度定义为8字节
    }
    
    /* OSSID第二个字节的高四位是类型区，
     * 标准传输器类型区为1，
     * 手机客户端模拟的传输器类型区为2,
     * 电脑模拟的传输器类型区为3 */
    TType = (cOssid[1] & 0xF0) / 0x10;
    if (TType < 1 || TType > 3) {
        return NO;
    }
    //如果不是查找所有类型传输器
    if (CheckTType != 0 && TType != CheckTType) {
        return NO;
    }
    //如果要剔除某一类传输器的话
    if (RemoveTType != 0 && TType == RemoveTType) {
        return NO;
    }
    
    // OSSID第二个字节的低四位是密码类型区目前：0表示默认加密，1表示有密钥校验码）
    TPwdType = cOssid[1] & 0xF;
    if (TPwdType != 0 && TPwdType != 1) {
        return NO;
    }
    
    // 判断mac地址校验码是否正确
    if (tmpmac_check[0] != cOssid[2]
        || tmpmac_check[1] != cOssid[3]) {
        return NO;
    }
    
    // 将第4到第7共4个字节的数据与自身4字节的mac地址校验码进行异或
    temp_tmpmac_check = makeMacCheck(cMac, 4); // 求出自身4字节的Mac校验码
    for (i = 0; i < 4; i++) {
        tmpmac_check[i] = (*temp_tmpmac_check)[i];
    }
    free(temp_tmpmac_check);
    
    for (i = 4; i < 8; i++) {
        cOssid[i] = (char) (cOssid[i] ^ tmpmac_check[i - 4]);
    }
    // 取出APPID
    // 4,5,6,7共4个字节是APPID
    TAppID = cOssid[4] * 16777216 + cOssid[5] * 65536
    + cOssid[6] * 256 + cOssid[7];
    
    //APPID的高两个字节是商家ID-StoreID
    TStoreID = cOssid[4] * 256 + cOssid[5];
    if (!(APPID == 0)) { // 如果输入的appid为0，则表示查找所有T
        if (TAppID != APPID) {
            return NO;
        }
    }
    return YES;
    
    //    /*
    //     * 计算客户端模拟的传输器的链接密码
    //     * AppID是一4个字节的数据，将此数据与一固定4字节的数据（字符串“only”）进行异或操作，
    //     * 得出的数据连接自身的mac地址，再后附一个用户自行输入的连接验证密匙（可有可无）
    //     * 得出的数据进行一次base64编码，再进行一次md5，即得出客户端模拟的传输器连接密匙。
    //     * 此处只取得10byte长的连接密码原型，连接前，需要用户输入连接验证密匙，再计算出连接密匙
    //     */
    //    const char *checkChar = "only";
    //    char pwdByte[10];
    //    memset((void *) pwdByte, 0, 10);
    //    for (i = 0; i < 4; i++) {
    //        pwdByte[i] = (char) (cOssid[i + 4] ^ checkChar[i]);
    //    }
    //    for (i = 4; i < 10; i++) {
    //        pwdByte[i] = cMac[i - 4];
    //    }
    //    if (TPwdType == 0) {
    //        //base64encode
    //        char out64Temp[64];
    //        memset((void *) out64Temp, 0, 64);
    //        int base64OutSize = base64Encode(out64Temp, pwdByte,
    //                                         10);
    //
    //        unsigned char encrypt[base64OutSize]; //加密前
    //        for (i = 0; i < base64OutSize; i++) {
    //            encrypt[i] = out64Temp[i];
    //        }
    //        //md5 by c,md5出来之后是以十六进制存放的
    //        MD5_CTX md5;
    //        unsigned char decrypt[16];
    //        MD5Init(&md5);
    //        MD5Update(&md5, encrypt, strlen((char *) encrypt));
    //        MD5Final(&md5, decrypt);
    //
    //        int tempPwdFlag = 0;
    //        for (i = 0; i < 16; i++) {
    //            char out[3];
    //            char2hex(decrypt[i], out);
    //
    //            for (int j = 0; j < 2; j++) {
    //                if (out[j] >= 'A') { //转小写
    //                    TPwd[tempPwdFlag] = out[j] + 32;
    //                } else {
    //                    TPwd[tempPwdFlag] = out[j];
    //                }
    //                tempPwdFlag++;
    //            }
    //        }
    //    }
    //
    //    xaonlyOssidMpT.SSID = Ssid;
    //    xaonlyOssidMpT.Mac = Mac;
    //    xaonlyOssidMpT.StoreID = TStoreID;
    //    xaonlyOssidMpT.AppID = TAppID;
    //    for (i = 0; i < 32; i++) {
    //        xaonlyOssidMpT.TPwd[i] = TPwd[i];
    //    }
    //    xaonlyOssidMpT.TPwdMold = pwdByte;
    //    xaonlyOssidMpT.TPwdType = TPwdType;
    //    xaonlyOssidMpT.TType = TType;
    //    xaonlyOssidMpT.TVersion = ossid_version;
    
    //    if (TType == 1) {
    //        const char *temp = "usb/";
    //        xaonlyOssidMpT.WebRootPath = temp;
    //        int WebPort = 80;
    //        xaonlyOssidMpT.WebPort = WebPort;
    //    } else {
    //        const char *temp = "/";
    //        xaonlyOssidMpT.WebRootPath = temp;
    //        int WebPort = 12202;
    //        xaonlyOssidMpT.WebPort = WebPort;
    //    }
}

@end
