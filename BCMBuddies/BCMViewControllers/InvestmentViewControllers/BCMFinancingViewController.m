//
//  BCMFinancingViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMFinancingViewController.h"
#import "BCMDefineFile.h"
#import "BCMHeadView.h"
#import "WDCustemButton.h"

@interface BCMFinancingViewController ()<UITableViewDataSource,UITableViewDelegate,BCMHeadViewDelegate>

@property (nonatomic,strong) IBOutlet BCMHeadView *ui_headView;
@property (nonatomic,weak) IBOutlet UITableView *ui_tableView;

@property (nonatomic,strong) NSMutableArray *m_titleArray;
@property (nonatomic,strong) NSMutableArray *m_financingArray;

@property (nonatomic,assign) NSInteger m_selectIndex;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)financingInfoButtonAction:(id)sender;

@end

@implementation BCMFinancingViewController

- (void)getFinancingFundInfo:(NSString *)folderID
{
    [self.m_financingArray removeAllObjects];
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
                [self.m_financingArray addObject:wd_manageObject];
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
        BCMFolder *wd_manageObject = [studentAry objectAtIndex:0];
        [self getFinancingFundInfo:wd_manageObject.id];
//        for(int i = 0;i < studentAry.count;i++)
//        {
//            BCMFolder *wd_manageObject = [studentAry objectAtIndex:i];
//            if(![wd_manageObject.folderlevel isEqualToString:@"2"])
//            {
//                [self.m_titleArray addObject:wd_manageObject];
//            }
//        }
//        if(self.m_titleArray.count > 0)
//        {
//            BCMFolder *wd_folderInfo = [self.m_titleArray objectAtIndex:0];
//            [self.ui_headView initViewWithTitleArray:self.m_titleArray selected:0];
//            [self getFinancingFundInfo:wd_folderInfo.id];
//        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.m_titleArray = [[NSMutableArray alloc] init];
    self.m_financingArray = [[NSMutableArray alloc] init];
    self.ui_headView.m_delegate = self;
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMFinancingListCell" bundle:nil];
    [self.ui_tableView registerNib:mu_cellNib forCellReuseIdentifier:@"BCMFinancingListCell"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"bank_financing"];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)financingInfoButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_financingObject = [self.m_financingArray objectAtIndex:wd_button.m_index];
    [BCMToolLib showResouceInfoAction:wd_financingObject nav:self.navigationController isShowServer:YES];
}
#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_financingArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMFinancingListCell"];
    if(wd_cell == nil)
    {
        wd_cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMFinancingListCell"];
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
    UILabel *wd_infoLabel1 = (UILabel *)[wd_cellView2 viewWithTag:301];
    UILabel *wd_infoLabel2 = (UILabel *)[wd_cellView2 viewWithTag:302];
    UILabel *wd_infoLabel3 = (UILabel *)[wd_cellView2 viewWithTag:303];
    UILabel *wd_infoLabel4 = (UILabel *)[wd_cellView2 viewWithTag:304];
    UILabel *wd_infoLabel5 = (UILabel *)[wd_cellView2 viewWithTag:305];
    UILabel *wd_infoLabel6 = (UILabel *)[wd_cellView2 viewWithTag:306];
    UILabel *wd_infoLabel7 = (UILabel *)[wd_cellView2 viewWithTag:307];
    UILabel *wd_infoLabel8 = (UILabel *)[wd_cellView2 viewWithTag:308];
    UILabel *wd_infoLabel9 = (UILabel *)[wd_cellView2 viewWithTag:309];
    WDCustemButton *wd_cellButton = (WDCustemButton *)[wd_cellView2 viewWithTag:310];
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
        wd_cellView1.hidden = YES;
        wd_cellView2.hidden = NO;
        BCMContent *wd_financingObject = [self.m_financingArray objectAtIndex:indexPath.row - 1];
        wd_infoLabel1.text = wd_financingObject.name;
        wd_infoLabel2.text = wd_financingObject.finProductcode;
        if(isStringEmpty(wd_financingObject.finProductstatus))
        {
            wd_infoLabel3.hidden = YES;
        }
        else
        {
            wd_infoLabel3.hidden = NO;
            wd_infoLabel3.text = wd_financingObject.finProductstatus;
        }
        if(isStringEmpty(wd_financingObject.finExprevenuerange))
        {
            wd_infoLabel4.hidden = YES;
            wd_infoLabel6.hidden = YES;
            wd_infoLabel5.hidden = NO;
            wd_infoLabel5.text = wd_financingObject.finExprevenuevalue;
        }
        else
        {
            wd_infoLabel4.hidden = NO;
            wd_infoLabel6.hidden = NO;
            wd_infoLabel5.hidden = YES;
            wd_infoLabel4.text = wd_financingObject.finExprevenuevalue;
            wd_infoLabel6.text = wd_financingObject.finExprevenuerange;
        }
        if(isStringEmpty(wd_financingObject.remark))
        {
            wd_infoLabel8.hidden = YES;
            wd_infoLabel9.hidden = YES;
            wd_infoLabel7.hidden = NO;
            wd_infoLabel7.text = wd_financingObject.finTermvalue;
        }
        else
        {
            wd_infoLabel8.hidden = NO;
            wd_infoLabel9.hidden = NO;
            wd_infoLabel7.hidden = YES;
            wd_infoLabel8.text = wd_financingObject.finTermvalue;
            wd_infoLabel9.text = wd_financingObject.remark;
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

@end
