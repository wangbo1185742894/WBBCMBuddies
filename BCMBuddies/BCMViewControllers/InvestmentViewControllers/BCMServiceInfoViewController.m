//
//  BCMServiceInfoViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/18.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMServiceInfoViewController.h"
#import "BCMDefineFile.h"
#import "AppDelegate.h"
#import "LDImageView.h"
#import "MBProgressHUD.h"

@interface BCMServiceInfoViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) IBOutlet UIScrollView *ui_scrollerView;
@property (nonatomic,weak) IBOutlet LDImageView *ui_headImageView;
@property (nonatomic,weak) IBOutlet UILabel *ui_nameLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_yewuKindLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_nianxianLabel;
@property (nonatomic,weak) IBOutlet UILabel *ui_yewuInfoLabel;
@property (nonatomic,weak) IBOutlet UICollectionView *ui_serviceCollectionView;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentTrailingConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_viewHeightConstraint;

@property (nonatomic,strong) NSMutableArray *m_teamArray;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)andServiceButtonAction:(id)sender;
- (IBAction)callServiceButtonAction:(id)sender;

@end

@implementation BCMServiceInfoViewController

- (void)getCustomerServiceInfo:(NSString *)folderID
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
        {        //更新里面的值
            for(int i = 0;i < studentAry.count;i++)
            {
                BCMContent *wd_manageObject = [studentAry objectAtIndex:i];
                [self.m_teamArray addObject:wd_manageObject];
            }
            [self.ui_serviceCollectionView reloadData];
        }
    }
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
- (void)refreshView
{
    
    float wd_height = 150;
    wd_height = wd_height + self.ui_yewuKindLabel.frame.size.height;
    wd_height = wd_height + self.ui_yewuInfoLabel.frame.size.height;
    self.ui_viewHeightConstraint.constant = wd_height;
    self.ui_contentTrailingConstraint.constant = SCREENWIDTH - 1;
    self.ui_contentBottomConstraint.constant = 270 + wd_height;

}
- (void)initSubViews
{
    CALayer * wd_layer = [self.ui_headImageView layer];
    wd_layer.masksToBounds = YES;
    wd_layer.cornerRadius = self.ui_headImageView.bounds.size.width/2.0;
    self.ui_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon4.png"];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *wd_picString;
    if([wd_appDelegate isTIFServerInfo])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,self.m_serviceInfoContent.folderId,self.m_serviceInfoContent.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:self.m_serviceInfoContent.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:self.m_serviceInfoContent.logohosturl];
    }
    if(!isStringEmpty(wd_picString))
    {
        NSString *wd_picPath = [BCMToolLib getAPPPicturePath:wd_appDelegate.m_appId depdeptId:wd_appDelegate.m_deptId];
        NSString *wd_lastpath = [wd_picString lastPathComponent];
        NSString *wd_imagePath = [wd_picPath stringByAppendingPathComponent:wd_lastpath];
        [self.ui_headImageView setUrlAndPath:wd_picString imagePath:wd_imagePath];
    }
    else
    {
        [self.ui_headImageView setUrlAndPath:nil imagePath:nil];
    }
    NSString *wd_nameString = self.m_serviceInfoContent.servName;
    NSString *wd_servPosition = self.m_serviceInfoContent.servPosition;
    if(isStringEmpty(wd_nameString))
    {
        wd_nameString = @"";
    }
    if(isStringEmpty(wd_servPosition))
    {
        wd_servPosition = @"";
    }
    self.ui_nameLabel.text = [NSString stringWithFormat:@"姓名：%@    职务：%@",wd_nameString,wd_servPosition,nil];
    self.ui_yewuKindLabel.text = self.m_serviceInfoContent.servRespbusiness;
    self.ui_nianxianLabel.text = self.m_serviceInfoContent.servWorkyears;
    self.ui_yewuInfoLabel.text = self.m_serviceInfoContent.servIntroduce;
    float wd_height = 150;
    wd_height = wd_height + self.ui_yewuKindLabel.frame.size.height;
    wd_height = wd_height + self.ui_yewuInfoLabel.frame.size.height;
    self.ui_viewHeightConstraint.constant = wd_height;
    self.ui_contentTrailingConstraint.constant = SCREENWIDTH - 1;
    self.ui_contentBottomConstraint.constant = 270 + wd_height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_teamArray = [[NSMutableArray alloc] init];
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMServiceListCell" bundle:nil];
    [self.ui_serviceCollectionView registerNib:mu_cellNib forCellWithReuseIdentifier:@"BCMServiceListCell"];
    [self initSubViews];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
        [self initSubViews];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)andServiceButtonAction:(id)sender
{
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
    NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:wd_entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%@",self.m_serviceInfoContent.id];
    if(predicate)
    {
        [request setPredicate:predicate];
    }
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count > 0)
    {
        BCMContent *wd_manageObject = studentAry[0];
        wd_manageObject.isAdd = @"YES";
        NSError *error;
        if ([context save:&error])
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"添加成功";
            [hud hideAnimated:YES afterDelay:2.f];
        }
        else
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"添加失败";
            [hud hideAnimated:YES afterDelay:2.f];
        }
    }
}
- (IBAction)callServiceButtonAction:(id)sender
{
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",self.m_serviceInfoContent.servPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
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
    UICollectionViewCell *wd_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BCMServiceListCell" forIndexPath:indexPath];
    UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
    LDImageView *wd_headImageView = (LDImageView *)[wd_cell viewWithTag:301];
    UILabel *wd_nameLabel = (UILabel *)[wd_cellView viewWithTag:302];
    BCMContent *wd_content = [self.m_teamArray objectAtIndex:indexPath.row];
    CALayer * wd_layer = [wd_headImageView layer];
    wd_layer.masksToBounds = YES;
    wd_layer.cornerRadius = wd_headImageView.bounds.size.width/2.0;
    wd_nameLabel.text = wd_content.name;
    wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon4.png"];
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
    if(indexPath.row == 0)
    {
        return CGSizeMake(81,102);
    }
    return CGSizeMake(73,102);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BCMContent *wd_content = [self.m_teamArray objectAtIndex:indexPath.row];
    self.m_serviceInfoContent = wd_content;
    [self initSubViews];
}

@end
