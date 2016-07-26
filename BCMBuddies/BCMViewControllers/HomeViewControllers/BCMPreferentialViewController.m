//
//  BCMPreferentialViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMPreferentialViewController.h"
#import "BCMDefineFile.h"
#import "LDImageView.h"
#import "BCMHeadView.h"
#import "LDImageView.h"
#import "WDCustemButton.h"

@interface BCMPreferentialViewController ()<UITableViewDataSource,UITableViewDelegate,BCMHeadViewDelegate>

@property (nonatomic,strong) IBOutlet BCMHeadView *ui_headView;
@property (nonatomic,weak) IBOutlet  UITableView *ui_tableView;

@property (nonatomic,strong) NSMutableArray *ui_titleArray;
@property (nonatomic,strong) NSMutableArray *ui_messageInfoArray;

@property (nonatomic,assign) NSInteger m_selectIndex;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)clickCellButtonAction:(id)sender;

@end

@implementation BCMPreferentialViewController

- (void)getMessageInfo:(NSString *)folderID
{
    [self.ui_messageInfoArray removeAllObjects];
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
        wd_appDelegate.m_appId =[NSString stringWithFormat:@"%@",self.user.curBank.appid] ;
        wd_appDelegate.m_deptId = [NSString stringWithFormat:@"%@",self.user.curBank.deptid];
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
                [self.ui_messageInfoArray addObject:wd_manageObject];
            }
            [self.ui_tableView reloadData];
        }
    }
}
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
        for(int i = 0;i < studentAry.count;i++)
        {
            BCMFolder *wd_manageObject = [studentAry objectAtIndex:i];
            if([wd_manageObject.folderlevel isEqualToString:@"2"])
            {
                [self.ui_titleArray addObject:wd_manageObject];
            }
        }
        if(self.ui_titleArray.count > 0)
        {
            BCMFolder *wd_folderInfo = [self.ui_titleArray objectAtIndex:0];
            [self.ui_headView initViewWithTitleArray:self.ui_titleArray selected:0];
            [self getMessageInfo:wd_folderInfo.id];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ui_titleArray = [[NSMutableArray alloc] init];
    self.ui_messageInfoArray = [[NSMutableArray alloc] init];
    self.ui_headView.m_delegate = self;
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMPreferentialListCell" bundle:nil];
    [self.ui_tableView registerNib:mu_cellNib forCellReuseIdentifier:@"BCMPreferentialListCell"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"bank_discount"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickCellButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content = [self.ui_messageInfoArray objectAtIndex:wd_button.m_index];
    [BCMToolLib showResouceInfoAction:wd_content nav:self.navigationController isShowServer:NO];
}
#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ui_messageInfoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMPreferentialListCell"];
    if(wd_cell == nil)
    {
        wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMPreferentialListCell"];
    }
    UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
    LDImageView *wd_videoImageView = (LDImageView *)[wd_cellView viewWithTag:301];
    WDCustemButton *wd_cellButton = (WDCustemButton *)[wd_cellView viewWithTag:302];
    BCMContent *wd_content = [self.ui_messageInfoArray objectAtIndex:indexPath.row];
    wd_cellButton.m_index = indexPath.row;
    CALayer * wd_layer = [wd_videoImageView layer];
    wd_layer.masksToBounds = YES;
    wd_layer.cornerRadius = 8;
    wd_videoImageView.defaultImage = [UIImage imageNamed:@"default_image_icon10.png"];
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
        [wd_videoImageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [wd_videoImageView setUrlAndPath:nil imagePath:nil];
    }
    return wd_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREENWIDTH * 136/320;
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
    self.m_selectIndex = index;
    BCMFolder *wd_folderInfo = [self.ui_titleArray objectAtIndex:index];
    [self getMessageInfo:wd_folderInfo.id];
}

@end
