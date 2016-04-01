//
//  BCMDownloadViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMDownloadViewController.h"
#import "BCMDefineFile.h"
#import "LDImageView.h"
#import "WDCustemButton.h"
#import <MediaPlayer/MediaPlayer.h>

@interface BCMDownloadViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *ui_tableView1;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView2;
@property (nonatomic,weak) IBOutlet UILabel *ui_label1;
@property (nonatomic,weak) IBOutlet UILabel *ui_label2;
@property (nonatomic,weak) IBOutlet UIButton *ui_typeButton1;
@property (nonatomic,weak) IBOutlet UIButton *ui_typeButton2;

@property (nonatomic,weak) IBOutlet UIButton *ui_deleteButton;
@property (nonatomic,weak) IBOutlet UIButton *ui_deleteSelectedButton;
@property (nonatomic,weak) IBOutlet UIButton *ui_deleteAllButton;
@property (nonatomic,weak) IBOutlet UIView *ui_deleteView;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_deleteViewBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_tableViewBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_tableViewBottomConstraint1;

@property (nonatomic,strong) NSMutableArray *m_downloadingArray;
@property (nonatomic,strong) NSMutableArray *m_downloadedArray;
@property (nonatomic,strong) NSMutableArray *m_selectedCellsArray;
@property (nonatomic,assign) int m_index;
@property (nonatomic,assign) BOOL m_isEdit;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)typeButtonAction1:(id)sender;
- (IBAction)typeButtonAction2:(id)sender;
- (IBAction)clickPlayButtonAction:(id)sender;
- (IBAction)selectDownloadCellButtonAction:(id)sender;
- (IBAction)deleteSelectedButtonAction:(id)sender;
- (IBAction)deleteAllButtonAction:(id)sender;

@end

@implementation BCMDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_downloadingArray = [[NSMutableArray alloc] init];
    self.m_downloadedArray = [[NSMutableArray alloc] init];
    self.m_selectedCellsArray = [[NSMutableArray alloc] init];
    self.m_index = 1;
    self.ui_label1.hidden = NO;
    self.ui_label2.hidden = YES;
    self.ui_typeButton1.selected = YES;
    self.ui_typeButton2.selected = NO;
    self.ui_tableView1.hidden = NO;
    self.ui_tableView2.hidden = YES;
    [self.ui_tableView1 reloadData];
    UINib *mu_cellNib1 = [UINib nibWithNibName:@"BCMAudioListCell" bundle:nil];
    [self.ui_tableView1 registerNib:mu_cellNib1 forCellReuseIdentifier:@"BCMAudioListCell"];
    UINib *mu_cellNib2 = [UINib nibWithNibName:@"BCMAudioListCell" bundle:nil];
    [self.ui_tableView2 registerNib:mu_cellNib2 forCellReuseIdentifier:@"BCMAudioListCell"];
    
    self.ui_deleteView.hidden = YES;
    self.ui_deleteViewBottomConstraint.constant = -55;
    self.ui_tableViewBottomConstraint.constant = 0;
    self.ui_tableViewBottomConstraint1.constant = 0;

    self.m_isEdit = NO;
    [self.m_selectedCellsArray removeAllObjects];
    [self.ui_deleteButton setImage:[UIImage imageNamed:@"delete_button_image.png"] forState:UIControlStateNormal];
    [self.ui_deleteButton setTitle:nil forState:UIControlStateNormal];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.m_isFull = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteButtonAction:(id)sender
{
    if(self.m_isEdit)
    {
        self.ui_deleteView.hidden = YES;
        self.ui_deleteViewBottomConstraint.constant = -55;
        self.ui_tableViewBottomConstraint.constant = 0;
        self.ui_tableViewBottomConstraint1.constant = 0;
        self.m_isEdit = NO;
        [self.m_selectedCellsArray removeAllObjects];
        [self.ui_deleteButton setImage:[UIImage imageNamed:@"delete_button_image.png"] forState:UIControlStateNormal];
        [self.ui_deleteButton setTitle:nil forState:UIControlStateNormal];
    }
    else
    {
        self.ui_deleteView.hidden = NO;
        self.ui_deleteViewBottomConstraint.constant = 0;
        self.ui_tableViewBottomConstraint.constant = 55;
        self.ui_tableViewBottomConstraint1.constant = 55;
        [self.m_selectedCellsArray removeAllObjects];
        [self.ui_deleteButton setImage:nil forState:UIControlStateNormal];
        [self.ui_deleteButton setTitle:@"完成" forState:UIControlStateNormal];
        self.m_isEdit = YES;
    }
    [self.ui_tableView1 reloadData];
    [self.ui_tableView2 reloadData];
}
- (IBAction)typeButtonAction1:(id)sender
{
    if(self.m_isEdit)
    {
        [self deleteButtonAction:nil];
    }
    self.m_index = 1;
    self.ui_label1.hidden = NO;
    self.ui_label2.hidden = YES;
    self.ui_typeButton1.selected = YES;
    self.ui_typeButton2.selected = NO;
    self.ui_tableView1.hidden = NO;
    self.ui_tableView2.hidden = YES;
    [self.ui_tableView1 reloadData];
}
- (IBAction)typeButtonAction2:(id)sender
{
    if(self.m_isEdit)
    {
        [self deleteButtonAction:nil];
    }
    self.m_index = 2;
    self.ui_label1.hidden = YES;
    self.ui_label2.hidden = NO;
    self.ui_typeButton1.selected = NO;
    self.ui_typeButton2.selected = YES;
    self.ui_tableView1.hidden = YES;
    self.ui_tableView2.hidden = NO;
    [self.ui_tableView2 reloadData];
}
- (IBAction)selectDownloadCellButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content;
    if(self.m_index == 1)
    {
        wd_content = [self.m_downloadingArray objectAtIndex:wd_button.m_index];
    }
    if(self.m_index == 2)
    {
        wd_content = [self.m_downloadedArray objectAtIndex:wd_button.m_index];
    }
    if(wd_button.selected == YES)
    {
        [self.m_selectedCellsArray removeObject:wd_content];
    }
    else
    {
        [self.m_selectedCellsArray addObject:wd_content];
    }
    wd_button.selected = !wd_button.selected;
}
- (IBAction)deleteSelectedButtonAction:(id)sender
{
    if(self.m_selectedCellsArray.count <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有选择要删除的助理，请选择后再删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        for(NSUInteger i = self.m_selectedCellsArray.count;i > 0;i--)
        {
            BCMContent *wd_content = [self.m_selectedCellsArray objectAtIndex:i-1];
            if(self.m_index == 1)
            {
                [self.m_downloadingArray removeObject:wd_content];
            }
            if(self.m_index == 2)
            {
                [self.m_downloadedArray removeObject:wd_content];
            }
            [self.m_selectedCellsArray removeObject:wd_content];
        }
        [self deleteButtonAction:nil];
    }
}
- (IBAction)deleteAllButtonAction:(id)sender
{
    if(self.m_index == 1)
    {
        for(NSUInteger i = self.m_downloadingArray.count;i > 0;i--)
        {
//            BCMContent *wd_content = [self.m_downloadingArray objectAtIndex:i-1];
//            [self deleteServiceInfo:wd_content];
        }
        [self.m_selectedCellsArray removeAllObjects];
        [self.m_downloadingArray removeAllObjects];
        [self.ui_tableView1 reloadData];
    }
    if(self.m_index == 2)
    {
        for(NSUInteger i = self.m_downloadedArray.count;i > 0;i--)
        {
//            BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:i-1];
//            [self deleteServiceInfo:wd_content];
        }
        [self.m_selectedCellsArray removeAllObjects];
        [self.m_downloadedArray removeAllObjects];
        [self.ui_tableView2 reloadData];
    }
    [self deleteButtonAction:nil];
}

- (IBAction)clickPlayButtonAction:(id)sender
{
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    wd_appDelegate.m_isFull = YES;
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content = [self.m_downloadedArray objectAtIndex:wd_button.m_index];
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
    if(self.m_index == 1)
    {
        return self.m_downloadingArray.count;
    }
    if(self.m_index == 1)
    {
        return self.m_downloadedArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMAudioListCell"];
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
    if(tableView == self.ui_tableView1)
    {
        BCMContent *wd_content = [self.m_downloadedArray objectAtIndex:indexPath.row];
        wd_nameLabel.text = wd_content.name;
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
        CALayer * wd_layer1 = [wd_downloadButton layer];
        wd_layer1.masksToBounds = YES;
        wd_layer1.cornerRadius = 4;
        wd_layer1.borderColor = RGBA(27,120,216,1.0).CGColor;
        wd_layer1.borderWidth = 1.0f;
        CALayer * wd_layer = [wd_headImageView layer];
        wd_layer.masksToBounds = YES;
        wd_layer.cornerRadius = 8;
        wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon5.png"];
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
    if(tableView == self.ui_tableView2)
    {
        BCMContent *wd_content = [self.m_downloadingArray objectAtIndex:indexPath.row];
        wd_nameLabel.text = wd_content.name;
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
        wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon5.png"];
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
    CGFloat wd_height = 90;
    return wd_height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
