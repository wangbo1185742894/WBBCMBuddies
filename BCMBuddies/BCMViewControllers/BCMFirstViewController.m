
//
//  BCMFirstViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/1.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMFirstViewController.h"
#import "BCMDefineFile.h"
#include <SystemConfiguration/CaptiveNetwork.h>
#import "ZipArchive.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface BCMFirstViewController ()<NSXMLParserDelegate>

@property (nonatomic,assign) BOOL m_isFirstParse;
@property (nonatomic,assign) int m_parseIndex;
@property (nonatomic,strong) NSString *m_appParentId;
@property (nonatomic,strong) NSString *m_contentParentId;
@property (nonatomic,strong) NSString *m_folderParentId;
@property (nonatomic,strong) NSString *m_contentResParentId;
@property (nonatomic,strong) NSMutableArray *m_extFileArray;
@property (nonatomic,strong) NSMutableArray *m_contentResArray;
@property (nonatomic,strong) MBProgressHUD *m_hud;
@property (nonatomic,weak) IBOutlet UIImageView *m_backImageView;

@end

@implementation BCMFirstViewController

//- (void)downloadFileWithOption1:(NSString*)requestURL
//                      savedPath:(NSString*)savedPath
//                downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
//                       progress:(void (^)(float progress))progress
//
//{
//    
//    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
//    NSMutableURLRequest *request =[serializer requestWithMethod:@"GET" URLString:requestURL parameters:nil error:nil];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        float p = (float)totalBytesRead / totalBytesExpectedToRead;
//        progress(p);
//    }];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        success(operation,responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failure(operation,error);
//    }];
//    [operation start];
//}
- (void)downloadOtherSouce:(int)index
{
    self.m_parseIndex = index;
    NSDictionary *wd_dic = [self.m_extFileArray objectAtIndex:index];
    NSString *wd_extinfo = [wd_dic objectForKey:@"downloadFile"];
    
     AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    if ([wd_appDelegate.m_isTFI isEqualToString:@"YES"]) {
        NSString *temp = [[wd_extinfo componentsSeparatedByString:@"appinfo_cache"] firstObject];
        wd_extinfo = [NSString stringWithFormat:@"%@%@",temp,@"extinfo.xml"];
    }
    
    NSString *wd_savePath = [wd_dic objectForKey:@"saveFile"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [BCMToolLib downloadFileWithOption:wd_extinfo savedPath:wd_savePath
                      downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                          
                         
                          NSData *data = [[NSData alloc]initWithContentsOfFile:wd_savePath];
                          NSXMLParser *wd_parser = [[NSXMLParser alloc] initWithData:data];
                          wd_parser.delegate = self;
                          if([wd_parser parse]){
                          }else{
                          }
//                          <NSHTTPURLResponse: 0x1377cf8c0> { URL: http://192.0.0.1:12202/8388609/2456/appinfo_cache/1782/8388609/2456/extinfo.xml } { status code: 404, headers {
//                              "Accept-Ranges" = bytes;
//                              "Content-Type" = "text/html";
//                              Date = "Wed, 4 May 2016 05:10:43 GMT";
//                          } }
                      } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                          NSLog(@"下载失败");
                      } progress:^(float progress) {
                      }];
    });
}
- (void)initBackImageView
{
    CGSize wd_viewSize = CGSizeMake(SCREENWIDTH,SCREENHEIGHT);
    NSString *wd_imagePath = nil;
    NSString *wd_viewOrientation = @"Portrait"; //横屏请设置成 @"Landscape"
    NSArray *wd_imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for(NSDictionary *wd_dic in wd_imagesDict)
    {
        CGSize wd_imageSize = CGSizeFromString([wd_dic objectForKey:@"UILaunchImageSize"]);
        if(CGSizeEqualToSize(wd_imageSize,wd_viewSize) && [wd_viewOrientation isEqualToString:[wd_dic objectForKey:@"UILaunchImageOrientation"]])
        {
            wd_imagePath = [wd_dic objectForKey:@"UILaunchImageName"];
        }
    }
    self.m_backImageView.image = [UIImage imageNamed:wd_imagePath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBackImageView];
    self.m_hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.m_hud.label.text = @"加载中...";
    self.m_extFileArray = [[NSMutableArray alloc] init];
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *wd_string = [[NSString alloc] initWithFormat:@"xaonly%@",wd_appDelegate.m_appId];
    NSString *wd_password = md5(wd_string);
    wd_string = [wd_string stringByAppendingString:@"1"];
    NSString *wd_keyValue = md5(wd_string);
    NSString *wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
    NSString *wd_savePath = [wd_appPath stringByAppendingPathComponent:@"packageci.zip"];
    NSFileManager *wd_fileManage = [NSFileManager defaultManager];
    if([wd_fileManage fileExistsAtPath:wd_savePath] == YES)
    {
        [wd_fileManage removeItemAtPath:wd_appPath error:nil];
        wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
    }
    //93ec7d0f72ac511b64719dc71c552f85
    
    NSString *wd_downloadPath;
    if ([wd_appDelegate .m_isTFI isEqualToString:@"NO"]) {
          wd_downloadPath = [NSString stringWithFormat:@"%@%@%@%@%@",wd_appDelegate.m_urlPath,@"AppForClient/GetPackageCiV2?userid=1351&appid=",wd_appDelegate.m_appId,@"&timestamp=1&key=",wd_keyValue,nil];
    }else{
        wd_downloadPath = [NSString stringWithFormat:@"%@%@/%@",wd_appDelegate.m_urlPath,wd_appDelegate.m_appId,@"packageci.zip"];
    
    }
   
    [BCMToolLib downloadFileWithOption:wd_downloadPath savedPath:wd_savePath
                 downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                     ZipArchive *za = [[ZipArchive alloc] init];
                     
                     if ([za UnzipOpenFile:wd_savePath Password:wd_password]) {
                         BOOL ret = [za UnzipFileTo:wd_appPath overWrite:YES];
                         if (NO == ret){}
                         [za UnzipCloseFile];
                         NSString *xmlFilePath = [wd_appPath stringByAppendingPathComponent:@"packageci.xml"];
                         NSData *data = [[NSData alloc]initWithContentsOfFile:xmlFilePath];
                         
                         NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                         NSXMLParser *wd_parser = [[NSXMLParser alloc]initWithData:data];
                         wd_parser.delegate = self;
                         self.m_isFirstParse = YES;
                         if([wd_parser parse]){
                         }else{
                         }
                     }
                 } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     [self.m_hud hideAnimated:YES];
                     self.m_hud = nil;
                     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                     hud.mode = MBProgressHUDModeText;
                     hud.label.text = @"下载失败";
                     [hud hideAnimated:YES afterDelay:2.f];
                 } progress:^(float progress) {
                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)downloadContentRes:(int)index
{
    if(self.m_contentResArray.count > index)
    {
//        if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
//        {
//            NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/res/",wd_appDelegate.m_appId,[attributeDict objectForKey:@"id"]];
//            wd_urlString = [wd_tfiUrlPath stringByAppendingString:wd_urlString];
//        }
//        else
//        {
//            wd_urlString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_urlString];
//        }

        NSString *wd_urlString = [self.m_contentResArray objectAtIndex:index];
        AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
        NSString *wd_fileName = [wd_urlString lastPathComponent];
        NSString *wd_savePath = [wd_appPath stringByAppendingPathComponent:wd_fileName];
        wd_urlString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_urlString];
        [BCMToolLib downloadFileWithOption:wd_urlString savedPath:wd_savePath
                     downloadSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                         ZipArchive *za = [[ZipArchive alloc] init];
                         if ([za UnzipOpenFile:wd_savePath]) {
                             BOOL ret = [za UnzipFileTo:wd_appPath overWrite:YES];
                             if (NO == ret){}
                             [za UnzipCloseFile];
                             [self downloadContentRes:index + 1];
                         }
                     } downloadFailure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     } progress:^(float progress) {
                     }];
    }
    else
    {
        [self.m_hud hideAnimated:YES];
        self.m_hud = nil;
        AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
        NSString *wd_deptIdPath = [BCMToolLib getAppDeptFolderPath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
        NSFileManager *wd_fileManager = [NSFileManager defaultManager];
        NSArray *wd_array = [wd_fileManager subpathsOfDirectoryAtPath:wd_appPath error:nil];
        for(NSString *wd_path in wd_array)
        {
            [wd_fileManager moveItemAtPath:wd_path toPath:[wd_deptIdPath stringByAppendingPathComponent:[wd_path lastPathComponent]] error:nil];
        }
        [wd_fileManager removeItemAtPath:wd_appPath error:nil];
        [wd_appDelegate showMainViewController];
    }
}
#pragma mark -
#pragma mark NSXMLParserDelegate

-(void)parserDidStartDocument:(NSXMLParser *)parser
{
}
-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    if(self.m_isFirstParse == YES)
    {
        if(self.m_extFileArray.count > 0)
        {
            [self downloadOtherSouce:0];
        }
        else
        {
            AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            NSString *wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
            NSString *wd_deptIdPath = [BCMToolLib getAppDeptFolderPath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
            NSFileManager *wd_fileManager = [NSFileManager defaultManager];
            NSArray *wd_array = [wd_fileManager subpathsOfDirectoryAtPath:wd_appPath error:nil];
            for(NSString *wd_path in wd_array)
            {
                [wd_fileManager moveItemAtPath:wd_path toPath:[wd_deptIdPath stringByAppendingPathComponent:[wd_path lastPathComponent]] error:nil];
            }
            [wd_fileManager removeItemAtPath:wd_appPath error:nil];
            [wd_appDelegate showMainViewController];
        }
        self.m_isFirstParse = NO;
    }
    else
    {
        if((self.m_extFileArray.count - 1) > self.m_parseIndex)
        {
            [self downloadOtherSouce:self.m_parseIndex + 1];
        }
        else
        {
            [self downloadContentRes:0];
        }
    }
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSMutableDictionary *wd_dic = [NSMutableDictionary dictionaryWithDictionary:attributeDict];
    if(attributeDict.count <= 0)
    {
        return;
    }
    if([elementName isEqualToString:@"extinfo"])
    {
        self.m_contentParentId = [attributeDict objectForKey:@"id"];
        return;
    }
    if([elementName isEqualToString:@"resfiles"] || [elementName isEqualToString:@"res"])
    {
        return;
    }
    if([elementName isEqualToString:@"folder"])
    {
        NSString *wd_extinfo = [attributeDict objectForKey:@"extinfo"];
        if(!isStringEmpty(wd_extinfo) && ![[attributeDict objectForKey:@"foldertypename"] isEqualToString:@"ServPerData"])
        {
            AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
            {
                NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/",wd_appDelegate.m_appId,[attributeDict objectForKey:@"id"]];
                wd_extinfo = [wd_tfiUrlPath stringByAppendingString:wd_extinfo];
            }
            else
            {
                wd_extinfo = [wd_appDelegate.m_urlPath stringByAppendingString:wd_extinfo];
            }
            NSMutableDictionary *wd_extFileDic = [[NSMutableDictionary alloc] init];
            NSString *wd_appPath = [BCMToolLib getCacheFolderPath:wd_appDelegate.m_appId];
            NSString *wd_fileName = [[attributeDict objectForKey:@"id"] stringByAppendingString:[wd_extinfo lastPathComponent]];
            NSString *wd_savePath = [wd_appPath stringByAppendingPathComponent:wd_fileName];
            
            [wd_extFileDic setObject:wd_extinfo forKey:@"downloadFile"];
            [wd_extFileDic setObject:wd_savePath forKey:@"saveFile"];
            [self.m_extFileArray addObject:wd_extFileDic];
        }
    }
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
    NSString *wd_BCMString;
    if([elementName isEqualToString:@"store"])
    {
        self.m_appParentId = [attributeDict objectForKey:@"id"];
        wd_BCMString = @"BCMStore";
    }
    if([elementName isEqualToString:@"app"])
    {
        self.m_folderParentId = [attributeDict objectForKey:@"id"];
        [wd_dic setObject:self.m_folderParentId forKey:@"storeId"];
        AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [wd_appDelegate initDeptIdPath:[attributeDict objectForKey:@"deptId"]];
        wd_BCMString = @"BCMApp";
    }
    if([elementName isEqualToString:@"folder"])
    {
        self.m_contentParentId = [attributeDict objectForKey:@"id"];
        [wd_dic setObject:self.m_appParentId forKey:@"storeId"];
        [wd_dic setObject:self.m_folderParentId forKey:@"appId"];
        wd_BCMString = @"BCMFolder";
    }
    if([elementName isEqualToString:@"content"])
    {
        self.m_contentResParentId = [attributeDict objectForKey:@"id"];
        [wd_dic setObject:self.m_appParentId forKey:@"storeId"];
        [wd_dic setObject:self.m_folderParentId forKey:@"appId"];
        [wd_dic setObject:@"NO" forKey:@"isAdd"];
        if([attributeDict objectForKey:@"operator"])
        {
            [wd_dic removeObjectForKey:@"operator"];
            [wd_dic setObject:[attributeDict objectForKey:@"operator"] forKey:@"wd_operator"];
        }
        if(self.m_contentParentId)
        {
            [wd_dic setObject:self.m_contentParentId forKey:@"folderId"];
        }
        wd_BCMString = @"BCMContent";
    }
    if([elementName isEqualToString:@"reszip"])
    {
        [wd_dic setObject:self.m_contentResParentId forKey:@"contentId"];
        wd_BCMString = @"BCMContentRes";
    }
    if([elementName isEqualToString:@"res"])
    {
        wd_BCMString = @"BCMContentRes";
    }
    
    NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:wd_BCMString inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:wd_entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%@",[attributeDict objectForKey:@"id"]];
    if(predicate)
    {
        [request setPredicate:predicate];
    }
    NSString *wd_string = [attributeDict objectForKey:@"description"];
    if(wd_string)
    {
        [wd_dic removeObjectForKey:@"description"];
        [wd_dic setObject:wd_string forKey:@"description1"];
    }
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count > 0)
    {        //更新里面的值
        NSManagedObject *wd_manageObject = studentAry[0];
        if([elementName isEqualToString:@"content"])
        {
            BCMContent *wd_content = (BCMContent *)wd_manageObject;
            [wd_dic setObject:wd_content.isAdd forKey:@"isAdd"];
        }
        [wd_manageObject setValuesForKeysWithDictionary:wd_dic];
    }else
    {
        NSManagedObject *wd_manageObject = [NSEntityDescription insertNewObjectForEntityForName:wd_BCMString inManagedObjectContext:context];
        [wd_manageObject setValuesForKeysWithDictionary:wd_dic];
    }
    NSError *error;
    if ([context save:&error])
    {
    }
    else
    {
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
}

@end
