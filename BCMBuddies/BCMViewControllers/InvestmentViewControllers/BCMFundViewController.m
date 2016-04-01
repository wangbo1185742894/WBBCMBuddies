//
//  BCMFundViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMFundViewController.h"
#import "BCMDefineFile.h"
#import "BCMHeadView.h"
#import "WDCustemButton.h"

@interface BCMFundViewController ()<UITableViewDataSource,UITableViewDelegate,BCMHeadViewDelegate>

@property (nonatomic,strong) IBOutlet BCMHeadView *ui_headView;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView;

@property (nonatomic,strong) NSMutableArray *m_titleArray;
@property (nonatomic,strong) NSMutableArray *m_fundArray;

@property (nonatomic,assign) NSInteger m_selectIndex;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)fundInfoButtonAction:(id)sender;

@end

@implementation BCMFundViewController

- (void)getBankFundInfo:(NSString *)folderID
{
    [self.m_fundArray removeAllObjects];
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
                [self.m_fundArray addObject:wd_manageObject];
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
            [self getBankFundInfo:wd_folderInfo.id];
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_titleArray = [[NSMutableArray alloc] init];
    self.m_fundArray = [[NSMutableArray alloc] init];
    self.ui_headView.m_delegate = self;
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMFundListCell" bundle:nil];
    [self.ui_tableView registerNib:mu_cellNib forCellReuseIdentifier:@"BCMFundListCell"];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"bank_fund"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)fundInfoButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_goldObject = [self.m_fundArray objectAtIndex:wd_button.m_index];
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
    return self.m_fundArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMFundListCell"];
    if(wd_cell == nil)
    {
        wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMFundListCell"];
    }
    UILabel *wd_lineLabel1 = (UILabel *)[wd_cell viewWithTag:401];
    UILabel *wd_lineLabel2 = (UILabel *)[wd_cell viewWithTag:402];

    UIView *wd_cellView1 = (UIView *)[wd_cell viewWithTag:200];
//    UILabel *wd_titleLabel1 = (UILabel *)[wd_cell viewWithTag:201];
//    UILabel *wd_fengeLabel1 = (UILabel *)[wd_cell viewWithTag:202];
//    UILabel *wd_titleLabel2 = (UILabel *)[wd_cell viewWithTag:203];
//    UILabel *wd_fengeLabel2 = (UILabel *)[wd_cell viewWithTag:204];
//    UILabel *wd_titleLabel3 = (UILabel *)[wd_cell viewWithTag:205];

    UIView *wd_cellView2 = (UIView *)[wd_cell viewWithTag:300];
    UILabel *wd_nameLabel = (UILabel *)[wd_cellView2 viewWithTag:301];
    UILabel *wd_moneyLabel = (UILabel *)[wd_cellView2 viewWithTag:302];
    UILabel *wd_personLabel = (UILabel *)[wd_cellView2 viewWithTag:307];
    UIImageView *wd_imageView1 = (UIImageView *)[wd_cellView2 viewWithTag:303];
    UIImageView *wd_imageView2 = (UIImageView *)[wd_cellView2 viewWithTag:304];
    UIImageView *wd_imageView3 = (UIImageView *)[wd_cellView2 viewWithTag:305];
    UIImageView *wd_imageView4 = (UIImageView *)[wd_cellView2 viewWithTag:306];
    WDCustemButton *wd_cellButton = (WDCustemButton *)[wd_cellView2 viewWithTag:308];
    wd_cellButton.m_index = indexPath.row - 1;
    wd_lineLabel1.hidden = YES;
    wd_lineLabel2.hidden = NO;
    if(indexPath.row == 0)
    {
        wd_lineLabel1.hidden = NO;
        wd_cellView1.hidden = NO;
        wd_cellView2.hidden = YES;
    }
    else
    {
        wd_imageView1.hidden = YES;
        wd_imageView2.hidden = YES;
        wd_imageView3.hidden = YES;
        wd_imageView4.hidden = YES;
        wd_cellView1.hidden = YES;
        wd_cellView2.hidden = NO;
        BCMContent *wd_fundObject = [self.m_fundArray objectAtIndex:indexPath.row - 1];
        wd_nameLabel.text = wd_fundObject.name;
        wd_moneyLabel.text = wd_fundObject.fundPurevalue;
        wd_personLabel.text = wd_fundObject.fundPurevalue;
        NSString *wd_fundTag = wd_fundObject.fundTag;
        NSArray *wd_tagArray = [wd_fundTag componentsSeparatedByString:@","];
        for(int i = 0;i < wd_tagArray.count;i++)
        {
            UIImageView *wd_imageView = (UIImageView *)[wd_cellView2 viewWithTag:(303+i)];
            wd_imageView.hidden = NO;
            NSString *wd_tagName = [wd_tagArray objectAtIndex:i];
            if([wd_tagName isEqualToString:@"荐"])
            {
                wd_imageView.image = [UIImage imageNamed:@"jian_kind_icon.png"];
            }
            if([wd_tagName isEqualToString:@"热"])
            {
                wd_imageView.image = [UIImage imageNamed:@"re_kind_icon.png"];
            }
            if([wd_tagName isEqualToString:@"保"])
            {
                wd_imageView.image = [UIImage imageNamed:@"bao_kind_icon.png"];
            }
            if([wd_tagName isEqualToString:@"独"])
            {
                wd_imageView.image = [UIImage imageNamed:@"du_kind_icon.png"];
            }
        }
    }
    return wd_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 40;
    }
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
    [self getBankFundInfo:wd_folderInfo.id];
}

@end
