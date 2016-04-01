//
//  BCMMySelfViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMMySelfViewController.h"
#import "BCMRootViewController.h"
#import "BCMAssistantViewController.h"
#import "BCMDownloadViewController.h"
#import "BCMAppInfoViewController.h"
#import "BCMAboutUsViewController.h"
#import "BCMDefineFile.h"
#import "BCMDrawingNumberViewController.h"

@interface BCMMySelfViewController ()

@property (nonatomic,weak) IBOutlet UILabel *ui_cacheLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_versionLabel;

- (IBAction)assistantClickAction:(id)sender;
- (IBAction)downloadClickAction:(id)sender;
- (IBAction)numberClickAction:(id)sender;
- (IBAction)clearCacheClickAction:(id)sender;
- (IBAction)appInfoClickAction:(id)sender;
- (IBAction)versionClickAction:(id)sender;
- (IBAction)boutUsaClickAction:(id)sender;

@end

@implementation BCMMySelfViewController

//遍历文件夹获得文件夹大小，返回多少M
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager *wd_fileManager = [NSFileManager defaultManager];
    if ([wd_fileManager fileExistsAtPath:filePath]){
        return [[wd_fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
- (long long)folderSizeAtPath:(NSString *)path{
    NSFileManager *wd_fileManager = [NSFileManager defaultManager];
    if (![wd_fileManager fileExistsAtPath:path])
        return 0;
    NSEnumerator *wd_childFilesEnumerator = [[wd_fileManager subpathsAtPath:path] objectEnumerator];
    NSString *wd_fileName;
    long long wd_folderSize = 0;
    while ((wd_fileName = [wd_childFilesEnumerator nextObject]) != nil){
        NSString* wd_fileAbsolutePath = [path stringByAppendingPathComponent:wd_fileName];
        BOOL wd_isDirectory;
        BOOL wd_isExists;
        wd_isExists = [wd_fileManager fileExistsAtPath:wd_fileAbsolutePath isDirectory:&wd_isDirectory];
        if (wd_isExists)
        {
            if(!wd_isDirectory)
            {
                wd_folderSize += [self fileSizeAtPath:wd_fileAbsolutePath];
            }
        }
    }
    return wd_folderSize;
}

- (void)cleanCache:(NSString *)path
{
    NSFileManager *wd_fileManager = [NSFileManager defaultManager];
    if (![wd_fileManager fileExistsAtPath:path])
        return;
    NSEnumerator *wd_childFilesEnumerator = [[wd_fileManager subpathsAtPath:path] objectEnumerator];
    NSString *wd_fileName;
    while ((wd_fileName = [wd_childFilesEnumerator nextObject]) != nil){
        NSString* wd_fileAbsolutePath = [path stringByAppendingPathComponent:wd_fileName];
        BOOL wd_isDirectory;
        BOOL wd_isExists;
        wd_isExists = [wd_fileManager fileExistsAtPath:wd_fileAbsolutePath isDirectory:&wd_isDirectory];
        if (wd_isExists)
        {
            if(wd_isDirectory)
            {
                [self cleanCache:wd_fileAbsolutePath];
            }
            else
            {
                [wd_fileManager removeItemAtPath:wd_fileAbsolutePath error:NULL];
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ui_versionLabel.text = [NSString stringWithFormat:@"当前版本:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *wd_userPath = [BCMToolLib getMainFolderPath];
        long long wd_fileLongSize = 0;
        wd_fileLongSize = [self folderSizeAtPath:wd_userPath];
        float wd_fileSize = wd_fileLongSize/(1024.0*1024.0);
        self.ui_cacheLabel.text = [NSString stringWithFormat:@"%0.2fMB",wd_fileSize];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
    mu_rootViewController.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
    mu_rootViewController.m_tabBarView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
    mu_rootViewController.m_tabBarView.hidden = YES;
}

- (IBAction)assistantClickAction:(id)sender
{
    BCMAssistantViewController *wd_assistantViewController = [[BCMAssistantViewController alloc] initWithNibName:@"BCMAssistantViewController" bundle:nil];
    [self.navigationController pushViewController:wd_assistantViewController animated:YES];
}
- (IBAction)downloadClickAction:(id)sender
{
    BCMDownloadViewController *wd_downloadViewController = [[BCMDownloadViewController alloc] initWithNibName:@"BCMDownloadViewController" bundle:nil];
    [self.navigationController pushViewController:wd_downloadViewController animated:YES];
}
- (IBAction)numberClickAction:(id)sender
{
    BCMDrawingNumberViewController *wd_drawingNumberViewController = [[BCMDrawingNumberViewController alloc] initWithNibName:@"BCMDrawingNumberViewController" bundle:nil];
    [self.navigationController pushViewController:wd_drawingNumberViewController animated:YES];
}
- (IBAction)clearCacheClickAction:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定清除所有的的缓存数据吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert setTag:1001];
    [alert show];
}
- (IBAction)appInfoClickAction:(id)sender
{
//    BCMAppInfoViewController *wd_appInfoViewController = [[BCMAppInfoViewController alloc] initWithNibName:@"BCMAppInfoViewController" bundle:nil];
//    [self.navigationController pushViewController:wd_appInfoViewController animated:YES];
}
- (IBAction)versionClickAction:(id)sender
{
    return;
}
- (IBAction)boutUsaClickAction:(id)sender
{
    BCMAboutUsViewController *wd_aboutUsViewController = [[BCMAboutUsViewController alloc] initWithNibName:@"BCMAboutUsViewController" bundle:nil];
    [self.navigationController pushViewController:wd_aboutUsViewController animated:YES];
}

#pragma mark -
#pragma mark UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger alerViewTag= [alertView tag];
    
    if(alerViewTag==1001){
        if (buttonIndex == 0) {
            NSString *wd_userPath = [BCMToolLib getMainFolderPath];
            [self cleanCache:wd_userPath];
            long long wd_fileLongSize = [self folderSizeAtPath:wd_userPath];
            float wd_fileSize = wd_fileLongSize/(1024.0*1024.0);
            self.ui_cacheLabel.text = [NSString stringWithFormat:@"%0.2fMB",wd_fileSize];
        }
    }
}
@end
