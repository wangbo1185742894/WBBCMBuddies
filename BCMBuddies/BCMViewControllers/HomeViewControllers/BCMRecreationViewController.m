//
//  BCMRecreationViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMRecreationViewController.h"
#import "BCMDefineFile.h"
#import "BCMHeadView.h"
#import "LDImageView.h"
#import "WDCustemButton.h"
#import <MediaPlayer/MediaPlayer.h>

@interface BCMRecreationViewController ()<UITableViewDataSource,UITableViewDelegate,BCMHeadViewDelegate>


@property (nonatomic,strong) IBOutlet BCMHeadView *ui_headView;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView1;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView2;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView3;

@property (nonatomic,strong) NSMutableArray *ui_titleArray;
@property (nonatomic,strong) NSMutableArray *ui_appsArray;
@property (nonatomic,strong) NSMutableArray *ui_videosArray;
@property (nonatomic,strong) NSMutableArray *ui_audiosArray;
@property (nonatomic,assign) int m_index;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)downloadButtonAction:(id)sender;
- (IBAction)clickPlayButtonAction:(id)sender;
- (IBAction)clickPlayButtonAction1:(id)sender;

@end

@implementation BCMRecreationViewController

- (void)getAudioinfo:(NSString *)folderID
{
    [self.ui_audiosArray removeAllObjects];
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
        NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
        NSFetchRequest *request = [NSFetchRequest new];
        [request setEntity:wd_entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"folderId=%@",folderID];
        [request setPredicate:predicate];
        NSArray *studentAry = [context executeFetchRequest:request error:nil];
        if (studentAry.count>0)
        {
            for(int i = 0;i < studentAry.count;i++)
            {
                BCMContent *wd_manageObject = [studentAry objectAtIndex:i];
                [self.ui_audiosArray addObject:wd_manageObject];
            }
            [self.ui_tableView3 reloadData];
        }
    }
}
- (void)getVideoinfo:(NSString *)folderID
{
    [self.ui_videosArray removeAllObjects];
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
        NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
        NSFetchRequest *request = [NSFetchRequest new];
        [request setEntity:wd_entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"folderId=%@",folderID];
        [request setPredicate:predicate];
        NSArray *studentAry = [context executeFetchRequest:request error:nil];
        if (studentAry.count>0)
        {
            for(int i = 0;i < studentAry.count;i++)
            {
                BCMContent *wd_manageObject = [studentAry objectAtIndex:i];
                [self.ui_videosArray addObject:wd_manageObject];
            }
            [self.ui_tableView2 reloadData];
        }
    }

}
//- (void)getFolderInfoForType:(NSString *)type
//{
//    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
//    NSString *wd_appID = wd_appDelegate.m_appId;
//    NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
//    NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMFolder" inManagedObjectContext:context];
//    NSFetchRequest *request = [NSFetchRequest new];
//    [request setEntity:wd_entityDescription];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId=%@ AND foldertypename=%@",wd_appID,type];
//    [request setPredicate:predicate];
//    NSArray *studentAry = [context executeFetchRequest:request error:nil];
//    if (studentAry.count>0)
//    {
//        for(int i = 0;i < studentAry.count;i++)
//        {
//            BCMFolder *wd_manageObject = [studentAry objectAtIndex:i];
//            if(![wd_manageObject.name isEqualToString:@"APP应用"])
//            {
//                [self.ui_titleArray addObject:wd_manageObject];
//            }
//        }
//        [self.ui_headView initViewWithTitleArray:self.ui_titleArray selected:0];
//        BCMFolder *wd_folderInfo = [self.ui_titleArray objectAtIndex:0];
//        [self getVideoinfo:wd_folderInfo.id];
//        BCMFolder *wd_folderInfo2 = [self.ui_titleArray objectAtIndex:1];
//        [self getAudioinfo:wd_folderInfo2.id];
//    }
//}
- (void)getFolderInfoForType:(NSString *)type
{
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSString *wd_appID = wd_appDelegate.m_appId;
    NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
    NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMFolder" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:wd_entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"appId=%@ AND foldertypename=%@",wd_appID,type];
    [request setPredicate:predicate];
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count>0)
    {
        BCMFolder *wd_manageObject = [studentAry objectAtIndex:0];
        [self.ui_titleArray addObject:wd_manageObject];
        if([type isEqualToString:@"video"])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getVideoinfo:wd_manageObject.id];
                [self getFolderInfoForType:@"audio"];
            });
        }
        if([type isEqualToString:@"audio"])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.ui_headView initViewWithTitleArray:self.ui_titleArray selected:0];
                [self getAudioinfo:wd_manageObject.id];
            });
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_index = 1;
    self.ui_titleArray = [[NSMutableArray alloc] init];
    self.ui_appsArray = [[NSMutableArray alloc] init];
    self.ui_videosArray = [[NSMutableArray alloc] init];
    self.ui_audiosArray = [[NSMutableArray alloc] init];
    self.ui_tableView1.hidden = YES;
    self.ui_tableView2.hidden = NO;
    self.ui_tableView3.hidden = YES;
    self.ui_headView.m_delegate = self;
    UINib *mu_cellNib0 = [UINib nibWithNibName:@"BCMAppListCell" bundle:nil];
    [self.ui_tableView1 registerNib:mu_cellNib0 forCellReuseIdentifier:@"BCMAppListCell"];
    UINib *mu_cellNib1 = [UINib nibWithNibName:@"BCMVideoListCell" bundle:nil];
    [self.ui_tableView2 registerNib:mu_cellNib1 forCellReuseIdentifier:@"BCMVideoListCell"];
    UINib *mu_cellNib2 = [UINib nibWithNibName:@"BCMAudioListCell" bundle:nil];
    [self.ui_tableView3 registerNib:mu_cellNib2 forCellReuseIdentifier:@"BCMAudioListCell"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"video"];
    });
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.m_isFull = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)downloadButtonAction:(id)sender
{

}

- (IBAction)clickPlayButtonAction:(id)sender
{
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    wd_appDelegate.m_isFull = YES;
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content = [self.ui_videosArray objectAtIndex:wd_button.m_index];
    NSString *wd_videoString;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_content.folderId,wd_content.id];
        wd_videoString = [wd_tfiUrlPath stringByAppendingString:wd_content.file];
    }
    else
    {
        wd_videoString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_content.filehosturl];
    }
    NSURL *wd_videoURL = [NSURL URLWithString:wd_videoString];
    MPMoviePlayerViewController *wd_moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:wd_videoURL];
    wd_moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeUnknown;
    wd_moviePlayerController.moviePlayer.shouldAutoplay = YES;
    //moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [wd_moviePlayerController.moviePlayer prepareToPlay];
    [wd_moviePlayerController.moviePlayer play];
    [wd_moviePlayerController.moviePlayer setFullscreen:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(myMovieFinishedCallback:) name: MPMoviePlayerPlaybackDidFinishNotification object:wd_moviePlayerController];
    [self.navigationController presentMoviePlayerViewControllerAnimated:wd_moviePlayerController];
}
- (IBAction)clickPlayButtonAction1:(id)sender
{
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    wd_appDelegate.m_isFull = YES;
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content = [self.ui_audiosArray objectAtIndex:wd_button.m_index];
    NSString *wd_videoString;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_content.folderId,wd_content.id];
        wd_videoString = [wd_tfiUrlPath stringByAppendingString:wd_content.file];
    }
    else
    {
        wd_videoString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_content.filehosturl];
    }
    NSURL *wd_videoURL = [NSURL URLWithString:wd_videoString];
    MPMoviePlayerViewController *wd_moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:wd_videoURL];
    wd_moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeUnknown;
    wd_moviePlayerController.moviePlayer.shouldAutoplay = YES;
    //moviePlayerController.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [wd_moviePlayerController.moviePlayer prepareToPlay];
    [wd_moviePlayerController.moviePlayer play];
    [wd_moviePlayerController.moviePlayer setFullscreen:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(myMovieFinishedCallback:) name: MPMoviePlayerPlaybackDidFinishNotification object:wd_moviePlayerController];
    [self.navigationController presentMoviePlayerViewControllerAnimated:wd_moviePlayerController];
}
- (void)myMovieFinishedCallback:(NSNotification *)notification
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.m_isFull = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [self.navigationController dismissMoviePlayerViewControllerAnimated];
}

#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.ui_tableView1)
    {
        return self.ui_appsArray.count;
    }
    if(tableView == self.ui_tableView2)
    {
        return self.ui_videosArray.count;
    }
    if(tableView == self.ui_tableView3)
    {
        return self.ui_audiosArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell;
    if(tableView == self.ui_tableView1)
    {
        wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMAppListCell"];
        if(wd_cell == nil)
        {
            wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMAppListCell"];
        }
    }
    if(tableView == self.ui_tableView2)
    {
        wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMVideoListCell"];
        if(wd_cell == nil)
        {
            wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMVideoListCell"];
        }
        UIView *wd_view = (UIView *)[wd_cell viewWithTag:300];
        LDImageView *wd_headImageView = (LDImageView *)[wd_view viewWithTag:302];
        UILabel *wd_nameLabel = (UILabel *)[wd_view viewWithTag:303];
        UILabel *wd_sizeLabel = (UILabel *)[wd_view viewWithTag:304];
        WDCustemButton *wd_downloadButton = (WDCustemButton *)[wd_view viewWithTag:305];
        UILabel *wd_otherInfoLabel = (UILabel *)[wd_view viewWithTag:306];
        UILabel *wd_messageLabel = (UILabel *)[wd_view viewWithTag:308];
        WDCustemButton *wd_clickCellButton = (WDCustemButton *)[wd_view viewWithTag:310];
        wd_downloadButton.m_index = indexPath.row;
        wd_clickCellButton.m_index = indexPath.row;
        BCMContent *wd_content = [self.ui_videosArray objectAtIndex:indexPath.row];
        wd_nameLabel.text = wd_content.name;
        wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon5.png"];
        long long wd_size = [wd_content.size longLongValue];
        if(wd_size/(1024 * 1024 * 1024.0) > 1.0)
        {
            wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fGB",wd_size/(1024 * 1024 * 1024.0)];
        }
        else
        {
            if(wd_size/(1024 * 1024.0) > 1.0)
            {
                wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fMB",wd_size/(1024 * 1024.0)];
            }
            else
            {
                wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fKB",wd_size/1024.0];
            }
        }
        wd_otherInfoLabel.text = wd_content.artist;
        wd_messageLabel.text = wd_content.remark;
        CALayer * wd_layer1 = [wd_downloadButton layer];
        wd_layer1.masksToBounds = YES;
        wd_layer1.cornerRadius = 4;
        wd_layer1.borderColor = RGBA(27,120,216,1.0).CGColor;
        wd_layer1.borderWidth = 1.0f;
        CALayer * wd_layer = [wd_headImageView layer];
        wd_layer.masksToBounds = YES;
        wd_layer.cornerRadius = 8;
        AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *wd_picString;
        if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
        {
            NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_content.folderId,wd_content.id];
            wd_picString = [wd_tfiUrlPath stringByAppendingString:wd_content.logo];
        }
        else
        {
            wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_content.logohosturl];
        }
        if(!isStringEmpty(wd_picString))
        {
            NSString *wd_picPath = [BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
            NSString *wd_lastpath = [wd_picString lastPathComponent];
            NSString *wd_imagePath = [wd_picPath stringByAppendingPathComponent:wd_lastpath];
            [wd_headImageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
        }
        else
        {
            [wd_headImageView setUrlAndPath:nil imagePath:nil];
        }
    }
    if(tableView == self.ui_tableView3)
    {
        wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMAudioListCell"];
        if(wd_cell == nil)
        {
            wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMAudioListCell"];
        }
        UIView *wd_view = (UIView *)[wd_cell viewWithTag:300];
        LDImageView *wd_headImageView = (LDImageView *)[wd_view viewWithTag:302];
        UILabel *wd_nameLabel = (UILabel *)[wd_view viewWithTag:303];
        UILabel *wd_otherInfoLabel = (UILabel *)[wd_view viewWithTag:304];
        UILabel *wd_sizeLabel = (UILabel *)[wd_view viewWithTag:306];
        WDCustemButton *wd_downloadButton = (WDCustemButton *)[wd_view viewWithTag:305];
        wd_downloadButton.m_index = indexPath.row;
        BCMContent *wd_content = [self.ui_audiosArray objectAtIndex:indexPath.row];
        wd_nameLabel.text = wd_content.name;
        wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon5.png"];
        long long wd_size = [wd_content.size longLongValue];
        if(wd_size/(1024 * 1024 * 1024.0) > 1.0)
        {
            wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fGB",wd_size/(1024 * 1024 * 1024.0)];
        }
        else
        {
            if(wd_size/(1024 * 1024.0) > 1.0)
            {
                wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fMB",wd_size/(1024 * 1024.0)];
            }
            else
            {
                wd_sizeLabel.text = [NSString stringWithFormat:@"%0.2fKB",wd_size/1024.0];
            }
        }
        wd_otherInfoLabel.text = wd_content.remark;
        CALayer * wd_layer1 = [wd_downloadButton layer];
        wd_layer1.masksToBounds = YES;
        wd_layer1.cornerRadius = 4;
        wd_layer1.borderColor = RGBA(27,120,216,1.0).CGColor;
        wd_layer1.borderWidth = 1.0f;
        CALayer * wd_layer = [wd_headImageView layer];
        wd_layer.masksToBounds = YES;
        wd_layer.cornerRadius = 8;
        AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *wd_picString;
        if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
        {
            NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_content.folderId,wd_content.id];
            wd_picString = [wd_tfiUrlPath stringByAppendingString:wd_content.logo];
        }
        else
        {
            wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_content.logohosturl];
        }
        if(!isStringEmpty(wd_picString))
        {
            NSString *wd_picPath = [BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
            NSString *wd_lastpath = [wd_picString lastPathComponent];
            NSString *wd_imagePath = [wd_picPath stringByAppendingPathComponent:wd_lastpath];
            [wd_headImageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
        }
        else
        {
            [wd_headImageView setUrlAndPath:nil imagePath:nil];
        }
    }
    return wd_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int wd_height = 0;
    if(tableView == self.ui_tableView1)
    {
    }
    if(tableView == self.ui_tableView2)
    {
        wd_height = 110;
        BCMContent *wd_content = [self.ui_videosArray objectAtIndex:indexPath.row];
        static UITableViewCell *wd_sizingCell = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            wd_sizingCell = [tableView dequeueReusableCellWithIdentifier:@"BCMVideoListCell"];
        });
        UIView *wd_view = (UIView *)[wd_sizingCell viewWithTag:300];
        UILabel *wd_messageLabel = (UILabel *)[wd_view viewWithTag:308];
        wd_messageLabel.text = wd_content.remark;
        [wd_view setNeedsLayout];
        [wd_view layoutIfNeeded];
        CGSize wk_titleSize = wd_messageLabel.frame.size;
        if(wk_titleSize.height > 0)
        {
            wd_height = wd_height + wk_titleSize.height + 10;
        }
        else
        {
            wd_height = wd_height + 25;
        }
    }
    if(tableView == self.ui_tableView3)
    {
        wd_height = 90;
    }
    return wd_height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -
#pragma mark BCMHeadViewDelegate

- (void)headViewSelected:(BCMHeadView *)headView didSelectIndex:(NSInteger)index
{
    if(index == 0)
    {
        self.ui_tableView1.hidden = YES;
        self.ui_tableView2.hidden = NO;
        self.ui_tableView3.hidden = YES;
    }
    if(index == 1)
    {
        self.ui_tableView1.hidden = YES;
        self.ui_tableView2.hidden = YES;
        self.ui_tableView3.hidden = NO;
    }
}
@end
