//
//  BackMenuViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/6.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BackMenuViewController.h"
#import "BCMToolLib.h"
#import "BCMAboutUsViewController.h"

@interface BackMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labCache;
@property (weak, nonatomic) IBOutlet UILabel *labVersion;

@end

@implementation BackMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    swipeGestureLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGestureLeft];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *wd_userPath = [BCMToolLib getMainFolderPath];
        long long wd_fileLongSize = 0;
        wd_fileLongSize = [self folderSizeAtPath:wd_userPath];
        float wd_fileSize = wd_fileLongSize/(1024.0*1024.0);
        self.labCache.text = [NSString stringWithFormat:@"%0.2fMB",wd_fileSize];
    });
    // Do any additional setup after loading the view from its nib.
}

-(void)swipeGesture:(id)sender
{
    
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
        
    {
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center postNotificationName:@"rootViewMoveLeft" object:nil userInfo:nil];
     
    }
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

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager *wd_fileManager = [NSFileManager defaultManager];
    if ([wd_fileManager fileExistsAtPath:filePath]){
        return [[wd_fileManager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
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
- (IBAction)actionAbout:(id)sender {
    
    BCMAboutUsViewController *wd_aboutUsViewController = [[BCMAboutUsViewController alloc] initWithNibName:@"BCMAboutUsViewController" bundle:nil];
    
    [self presentViewController:wd_aboutUsViewController animated:YES completion:nil];
//    [self pushViewController:wd_aboutUsViewController animated:YES];
}
- (IBAction)actionUpdata:(UIButton *)sender {
}
- (IBAction)actionCleanCache:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定清除所有的的缓存数据吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert setTag:1001];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSInteger alerViewTag= [alertView tag];
    
    if(alerViewTag==1001){
        if (buttonIndex == 0) {
            NSString *wd_userPath = [BCMToolLib getMainFolderPath];
            [self cleanCache:wd_userPath];
            long long wd_fileLongSize = [self folderSizeAtPath:wd_userPath];
            float wd_fileSize = wd_fileLongSize/(1024.0*1024.0);
            self.labCache.text = [NSString stringWithFormat:@"%0.2fMB",wd_fileSize];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
