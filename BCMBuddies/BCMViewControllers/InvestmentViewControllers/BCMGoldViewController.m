//
//  BCMGoldViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMGoldViewController.h"
#import "BCMDefineFile.h"
#import "LDImageView.h"
#import "WDCustemButton.h"
#import "BCMHeadView.h"

@interface BCMGoldViewController ()<UITableViewDataSource,UITableViewDelegate,BCMHeadViewDelegate>

@property (nonatomic,strong) IBOutlet BCMHeadView *ui_headView;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView;

@property (nonatomic,strong) NSMutableArray *m_titleArray;
@property (nonatomic,strong) NSMutableArray *m_goldArray;

@property (nonatomic,assign) NSInteger m_selectIndex;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)goldInfoButtonAction:(id)sender;

@end

@implementation BCMGoldViewController

- (void)getBankGoldInfo:(NSString *)folderID
{
    [self.m_goldArray removeAllObjects];
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
                [self.m_goldArray addObject:wd_manageObject];
            }
            [self.ui_tableView reloadData];
        }
    }
}
- (void *)getFolderInfoForType:(NSString *)type
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
            if(![wd_manageObject.folderlevel isEqualToString:@"2"])
            {
                [self.m_titleArray addObject:wd_manageObject];
            }
        }
        if(self.m_titleArray.count > 0)
        {
            BCMFolder *wd_folderInfo = [self.m_titleArray objectAtIndex:0];
            [self.ui_headView initViewWithTitleArray:self.m_titleArray selected:0];
            [self getBankGoldInfo:wd_folderInfo.id];
        }
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_titleArray = [[NSMutableArray alloc] init];
    self.m_goldArray = [[NSMutableArray alloc] init];
    self.ui_headView.m_delegate = self;

    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMGoldListCell" bundle:nil];
    [self.ui_tableView registerNib:mu_cellNib forCellReuseIdentifier:@"BCMGoldListCell"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"bank_gold"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goldInfoButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_goldObject = [self.m_goldArray objectAtIndex:wd_button.m_index];
    [BCMToolLib showResouceInfoAction:wd_goldObject nav:self.navigationController isShowServer:YES];
}
#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_goldArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMGoldListCell"];
    if(wd_cell == nil)
    {
        wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMGoldListCell"];
    }
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
    UILabel *wd_lineLabel1 = (UILabel *)[wd_cellView viewWithTag:301];
    LDImageView *wd_imageView = (LDImageView *)[wd_cellView viewWithTag:302];
    UILabel *wd_nameLabel = (UILabel *)[wd_cellView viewWithTag:303];
    UILabel *wd_moneyLabel = (UILabel *)[wd_cellView viewWithTag:304];
    UILabel *wd_lineLabel2 = (UILabel *)[wd_cellView viewWithTag:305];
    WDCustemButton *wd_cellButton = (WDCustemButton *)[wd_cellView viewWithTag:306];
    wd_cellButton.m_index = indexPath.row;
    wd_lineLabel1.hidden = YES;
    wd_lineLabel2.hidden = NO;
    if(indexPath.row == 0)
    {
        wd_lineLabel1.hidden = NO;
    }
    BCMContent *wd_goldObject = [self.m_goldArray objectAtIndex:indexPath.row];
    wd_imageView.defaultImage = [UIImage imageNamed:@"default_image_icon1.png"];
    NSString *wd_picString;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_goldObject.folderId,wd_goldObject.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:wd_goldObject.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_goldObject.logohosturl];
    }
    if(!isStringEmpty(wd_picString))
    {
        NSString *wd_lastpath = [wd_picString lastPathComponent];
        NSString *wd_imagePath = [[BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId] stringByAppendingPathComponent:wd_lastpath];
        [wd_imageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [wd_imageView setUrlAndPath:nil imagePath:nil];
    }
    wd_nameLabel.text = wd_goldObject.name;
    wd_moneyLabel.text = wd_goldObject.goldPrice;
    return wd_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
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
    BCMFolder *wd_folderInfo = [self.m_titleArray objectAtIndex:index];
    [self getBankGoldInfo:wd_folderInfo.id];
}


@end
