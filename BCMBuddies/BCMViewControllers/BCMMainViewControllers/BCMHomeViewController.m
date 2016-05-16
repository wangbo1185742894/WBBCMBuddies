//
//  BCMHomeViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMHomeViewController.h"
#import "LDImageCarouselView.h"
#import "BCMRootViewController.h"
#import "BCMServiceViewController.h"
#import "BCMInvestmentViewController.h"
#import "BCMRecreationViewController.h"
#import "BCMPreferentialViewController.h"
#import "BCMServiceInfoViewController.h"
#import "BCMDefineFile.h"
#import "BCMServiceInfoViewController1.h"

@interface BCMHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,LDImageCarouselViewDelegate>
{
}
@property (nonatomic,weak) IBOutlet UIScrollView *ui_scrollView;
@property (nonatomic,strong) IBOutlet UIView *ui_bankNoticView;
@property (nonatomic,strong) IBOutlet LDImageCarouselView *ui_imageCarouselView;
@property (nonatomic,weak) IBOutlet UILabel *ui_newsLabel;
@property (nonatomic,weak) IBOutlet UICollectionView *ui_collectionView;
@property (nonatomic,weak) IBOutlet UILabel *ui_titleLabel1;
@property (nonatomic,weak) IBOutlet UILabel *ui_titleLabel2;
@property (nonatomic,weak) IBOutlet UILabel *ui_titleLabel3;
@property (nonatomic,weak) IBOutlet UILabel *ui_titleLabel4;
@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel1;
@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel2;
@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel3;
@property (nonatomic,weak) IBOutlet UILabel *ui_messageLabel4;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentTrailingConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_bankNoticHeightConstraint;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_button1Constraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_button2Constraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_button3Constraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_button4Constraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_imageConstraint;

@property (nonatomic,strong) NSMutableArray *m_newsArray;
@property (nonatomic,strong) NSMutableArray *m_teamArray;
@property (nonatomic,strong) BCMContent *m_noticContent;

- (IBAction)noticButtonAction:(id)sender;
- (IBAction)button1Action:(id)sender;
- (IBAction)button2Action:(id)sender;
- (IBAction)button3Action:(id)sender;
- (IBAction)button4Action:(id)sender;
- (IBAction)teamNextButtonAction:(id)sender;
- (IBAction)teamTopButtonAction:(id)sender;

@end

@implementation BCMHomeViewController

- (void)getBankImgeInfo:(NSString *)folderID
{
    
   
    [self.m_newsArray removeAllObjects];
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
                [self.m_newsArray addObject:wd_manageObject];
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getBankNoticInfo:[self getFolderInfoForType:@"bank_notice"]];
    });
}
- (void)getBankNoticInfo:(NSString *)folderID
{
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
            self.ui_imageCarouselView.m_isOpen = 0;
            self.ui_bankNoticView.hidden = NO;
            self.ui_button1Constraint.constant = 0;
            self.ui_button2Constraint.constant = 0;
            self.ui_button3Constraint.constant = 0;
            self.ui_button4Constraint.constant = 0;
            self.ui_imageConstraint.constant = 0;
            self.ui_bankNoticHeightConstraint.constant = 41;
            self.m_noticContent = [studentAry objectAtIndex:0];
            self.ui_newsLabel.text = self.m_noticContent.remark;
        }
        else
        {
            self.ui_bankNoticView.hidden = YES;
            self.ui_button1Constraint.constant = -25;
            self.ui_button2Constraint.constant = -25;
            self.ui_button3Constraint.constant = -25;
            self.ui_button4Constraint.constant = -25;
            self.ui_imageConstraint.constant = -50;
            self.ui_bankNoticHeightConstraint.constant = 0;
            self.ui_imageCarouselView.m_isOpen = 26;
        }
    }
    else
    {
        self.ui_bankNoticView.hidden = YES;
        self.ui_button1Constraint.constant = -25;
        self.ui_button2Constraint.constant = -25;
        self.ui_button3Constraint.constant = -25;
        self.ui_button4Constraint.constant = -25;
        self.ui_imageConstraint.constant = -50;
        self.ui_bankNoticHeightConstraint.constant = 0;
        self.ui_imageCarouselView.m_isOpen = 26;
    }
    [self.ui_imageCarouselView initWithCount:self.m_newsArray.count delegate:self];
}
- (NSString *)getFolderInfoForType:(NSString *)type
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
        BCMFolder *wd_manageObject = (BCMFolder *)[studentAry objectAtIndex:0];
        return wd_manageObject.id;
    }
    return nil;
}

- (void)getCustomerServiceInfo:(NSString *)folderID
{
    [self.m_teamArray removeAllObjects];
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
        {        //更新里面的值
            for(int i = 0;i < studentAry.count;i++)
            {
                BCMContent *wd_manageObject = [studentAry objectAtIndex:i];
                [self.m_teamArray addObject:wd_manageObject];
            }
            [self.ui_collectionView reloadData];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ui_contentTrailingConstraint.constant = SCREENWIDTH - 1;
    self.ui_contentBottomConstraint.constant = SCREENHEIGHT-50;
    
    self.m_newsArray = [[NSMutableArray alloc] init];
    self.m_teamArray = [[NSMutableArray alloc] init];
    self.ui_scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    self.ui_collectionView.backgroundColor = [UIColor clearColor];
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMTeamListCell" bundle:nil];
    [self.ui_collectionView registerNib:mu_cellNib forCellWithReuseIdentifier:@"BCMTeamListCell"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getBankImgeInfo:[self getFolderInfoForType:@"bank_imge"]];
        [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
//        [self getBankNoticInfo:[self getFolderInfoForType:@"bank_notice"]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
//    mu_rootViewController.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
//    mu_rootViewController.m_tabBarView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    BCMRootViewController *mu_rootViewController = (BCMRootViewController *)[[self parentViewController] parentViewController];
    mu_rootViewController.m_tabBarView.hidden = YES;
}

- (IBAction)noticButtonAction:(id)sender
{
    [BCMToolLib showResouceInfoAction:self.m_noticContent nav:self.navigationController isShowServer:NO];
}
- (IBAction)button1Action:(id)sender
{
    BCMServiceViewController *wd_serviceViewController = [[BCMServiceViewController alloc] initWithNibName:@"BCMServiceViewController" bundle:nil];
    [self.navigationController pushViewController:wd_serviceViewController animated:YES];
}
- (IBAction)button2Action:(id)sender
{
    BCMInvestmentViewController *wd_investmentViewController = [[BCMInvestmentViewController alloc] initWithNibName:@"BCMInvestmentViewController" bundle:nil];
    [self.navigationController pushViewController:wd_investmentViewController animated:YES];
}
- (IBAction)button3Action:(id)sender
{
    BCMRecreationViewController *wd_recreationViewController = [[BCMRecreationViewController alloc] initWithNibName:@"BCMRecreationViewController" bundle:nil];
    [self.navigationController pushViewController:wd_recreationViewController animated:YES];
}
- (IBAction)button4Action:(id)sender
{
    BCMPreferentialViewController *wd_preferentialViewController = [[BCMPreferentialViewController alloc] initWithNibName:@"BCMPreferentialViewController" bundle:nil];
    [self.navigationController pushViewController:wd_preferentialViewController animated:YES];
}
- (IBAction)teamNextButtonAction:(id)sender
{

}
- (IBAction)teamTopButtonAction:(id)sender
{

}
#pragma mark------collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.m_teamArray count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *wd_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BCMTeamListCell" forIndexPath:indexPath];
    UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
//    UIImageView *wd_backImageView = (UIImageView *)[wd_cellView viewWithTag:301];
    LDImageView *wd_headImageView = (LDImageView *)[wd_cellView viewWithTag:302];
    UILabel *wd_nameLabel = (UILabel *)[wd_cellView viewWithTag:303];
    UIImageView *wd_xing1 = (UIImageView *)[wd_cellView viewWithTag:304];
    UIImageView *wd_xing2 = (UIImageView *)[wd_cellView viewWithTag:305];
    UIImageView *wd_xing3 = (UIImageView *)[wd_cellView viewWithTag:306];
    UIImageView *wd_xing4 = (UIImageView *)[wd_cellView viewWithTag:307];
    UIImageView *wd_xing5 = (UIImageView *)[wd_cellView viewWithTag:308];
    UILabel *wd_infoLabel = (UILabel *)[wd_cellView viewWithTag:309];
    wd_xing1.hidden = YES;
    wd_xing2.hidden = YES;
    wd_xing3.hidden = YES;
    wd_xing4.hidden = YES;
    wd_xing5.hidden = YES;
    BCMContent *wd_content = [self.m_teamArray objectAtIndex:indexPath.row];
    wd_nameLabel.text = wd_content.name;
    wd_infoLabel.text = wd_content.remark;
    for(int i = 0;i < [wd_content.servLevel intValue];i++)
    {
        int wd_tag = 304+i;
        UIImageView *wd_xing = (UIImageView *)[wd_cell viewWithTag:wd_tag];
        wd_xing.hidden = NO;
    }
    wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon3.png"];
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
    return wd_cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH - 44, 114);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BCMContent *wd_content = [self.m_teamArray objectAtIndex:indexPath.row];
    BCMServiceInfoViewController *wd_serviceInfoViewController = [[BCMServiceInfoViewController alloc] initWithNibName:@"BCMServiceInfoViewController" bundle:nil];
    wd_serviceInfoViewController.m_serviceInfoContent = wd_content;
    [self.navigationController pushViewController:wd_serviceInfoViewController animated:YES];
}

#pragma mark -
#pragma mark LDImageCarouselViewDelegate

- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView loadImageForImageView:(LDImageView *)imageView index:(NSInteger)index
{
    BCMContent *wd_contentObject = [self.m_newsArray objectAtIndex:index];
    imageView.defaultImage = [UIImage imageNamed:@"default_image_icon9.png"];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *wd_picString;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,wd_contentObject.folderId,wd_contentObject.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:wd_contentObject.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:wd_contentObject.logohosturl];
    }
    if(!isStringEmpty(wd_picString))
    {
        NSString *wd_picPath = [BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
        NSString *wd_lastpath = [wd_picString lastPathComponent];
        NSString *wd_imagePath = [wd_picPath stringByAppendingPathComponent:wd_lastpath];
        [imageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [imageView setUrlAndPath:nil imagePath:nil];
    }
}
- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView didTapAtIndex:(NSInteger)index imageURL:(NSURL *)imageURL
{

}
- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView didTapAtIndex:(NSInteger)index
{
    BCMContent *wd_contentObject = [self.m_newsArray objectAtIndex:index];
    if([wd_contentObject.imgeType isEqualToString:@"service"])
    {
        BCMServiceInfoViewController1 *wd_serviceInfoViewController1 = [[BCMServiceInfoViewController1 alloc] initWithNibName:@"BCMServiceInfoViewController1" bundle:nil];
        wd_serviceInfoViewController1.m_serviceInfoContent = wd_contentObject;
        [self.navigationController pushViewController:wd_serviceInfoViewController1 animated:YES];
    }
    else
    {
        [BCMToolLib showResouceInfoAction:wd_contentObject nav:self.navigationController isShowServer:NO];
    }
}

@end
