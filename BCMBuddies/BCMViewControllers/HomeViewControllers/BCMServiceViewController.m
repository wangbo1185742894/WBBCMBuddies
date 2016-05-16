//
//  BCMServiceViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMServiceViewController.h"
#import "BCMDefineFile.h"
#import "AppDelegate.h"
#import "LDImageView.h"
#import "BCMZouShiView.h"
#import "JSONKit.h"
#import "BCMServiceInfoViewController.h"

@interface BCMServiceViewController ()

@property (nonatomic,weak) IBOutlet UIScrollView *ui_scrollView;
@property (nonatomic,weak) IBOutlet UIScrollView *ui_scrollView1;
@property (nonatomic,weak) IBOutlet UIButton *ui_counterButton;
@property (nonatomic,weak) IBOutlet UIButton *ui_mobileserviceButton;
@property (nonatomic,weak) IBOutlet UICollectionView *ui_typeCollectionView;
@property (nonatomic,weak) IBOutlet UICollectionView *ui_mobileCollectionView1;
@property (nonatomic,weak) IBOutlet UICollectionView *ui_serviceCollectionView;
@property (nonatomic,strong) IBOutlet UIView *ui_diagramView;
@property (nonatomic,weak) IBOutlet UILabel *ui_textLabel;

@property (nonatomic,weak) IBOutlet UIView *ui_zoushiView;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentTrailingConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentBottomConstraint1;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_contentTrailingConstraint1;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_collectionViewHeightConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_collectionViewHeightConstraint1;
@property (nonatomic,strong) BCMZouShiView *ui_zoushiBackViewView;



@property (nonatomic,strong) NSMutableArray *m_counterArray;
@property (nonatomic,strong) NSMutableArray *m_mobileserviceArray;
@property (nonatomic,strong) NSMutableArray *m_teamArray;
@property (nonatomic,strong) NSMutableArray *m_servPerDataArray;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)counterButtonAction:(id)sender;
- (IBAction)mobileserviceButtonAction:(id)sender;
- (IBAction)showBCMAppInfo:(id)sender;
@end

@implementation BCMServiceViewController

- (void)getBankMobileserviceinfo:(NSString *)folderID
{
    [self.m_mobileserviceArray removeAllObjects];
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
                [self.m_mobileserviceArray addObject:wd_manageObject];
            }
            int wd_count = (int)self.m_mobileserviceArray.count;
            int wd_index = wd_count/4;
            if(wd_count%4 > 0)
            {
                wd_index = wd_index + 1;
            }
            self.ui_collectionViewHeightConstraint1.constant = 94 *wd_index;
            [self.ui_mobileCollectionView1 reloadData];
        }
    }
    NSInteger wd_count = 0;
    if(self.m_mobileserviceArray.count%4)
    {
        wd_count = self.m_mobileserviceArray.count/4 + 1;
    }
    else
    {
        wd_count = self.m_mobileserviceArray.count/4;
    }
    self.ui_contentBottomConstraint1.constant = 94 * wd_count + 60;
}
- (void)getBankCounterinfo:(NSString *)folderID
{
    [self.m_counterArray removeAllObjects];
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
                [self.m_counterArray addObject:wd_manageObject];
            }
            int wd_count = (int)self.m_counterArray.count;
            int wd_index = wd_count/4;
            if(wd_count%4 > 0)
            {
                wd_index = wd_index + 1;
            }
            self.ui_collectionViewHeightConstraint.constant = 94 *wd_index;
            [self.ui_typeCollectionView reloadData];
        }
    }
    NSInteger wd_count = 0;
    if(self.m_counterArray.count%4)
    {
        wd_count = self.m_counterArray.count/4 + 1;
    }
    else
    {
        wd_count = self.m_counterArray.count/4;
    }
    self.ui_contentBottomConstraint.constant = 94 * wd_count + 338;
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
        {
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
- (NSString *)getServPerData:(NSString *)type
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
        return wd_manageObject.remark;
    }
    return nil;
}
-(NSString *)compareDateDay:(NSDate *)date{
    NSCalendar *wd_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *wd_comps = [[NSDateComponents alloc] init];
    wd_comps = [wd_calendar components:unitFlags fromDate:date];
    NSNumber *wd_dayNumber = [NSNumber numberWithInteger:[wd_comps day]];
    return [wd_dayNumber stringValue];
}
-(NSString *)compareDateWeek:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday,*houtian;
    tomorrow = [today dateByAddingTimeInterval: secondsPerDay];
    houtian = [today dateByAddingTimeInterval:(secondsPerDay + secondsPerDay)];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    
    NSCalendar *wd_calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *wd_comps = [[NSDateComponents alloc] init];
    wd_comps = [wd_calendar components:unitFlags fromDate:date];
    NSDateComponents *wd_comps1 = [[NSDateComponents alloc] init];
    wd_comps1 = [wd_calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger weekday = [wd_comps weekday];
    NSInteger weekday1 = [wd_comps1 weekday];
    if(weekday == weekday1)
    {
        return @"今天";
    }
    else
    {
        switch (weekday) {
            case 1:
            {
                if(weekday1 == 7)
                {
                    return @"明天";
                }
                if(weekday1 == 6)
                {
                    return @"后天";
                }
                return @"周天";
            }
                break;
            case 2:
            {
                if(weekday1 == 1)
                {
                    return @"明天";
                }
                if(weekday1 == 7)
                {
                    return @"后天";
                }
                return @"周一";
            }
                break;
            case 3:
            {
                if(weekday1 == 2)
                {
                    return @"明天";
                }
                if(weekday1 == 1)
                {
                    return @"后天";
                }
                return @"周二";
            }
                break;
            case 4:
            {
                if(weekday1 == 3)
                {
                    return @"明天";
                }
                if(weekday1 == 2)
                {
                    return @"后天";
                }
                return @"周三";
            }
                break;
            case 5:
            {
                if(weekday1 == 4)
                {
                    return @"明天";
                }
                if(weekday1 == 3)
                {
                    return @"后天";
                }
                return @"周四";
            }
                break;
            case 6:
            {
                if(weekday1 == 5)
                {
                    return @"明天";
                }
                if(weekday1 == 4)
                {
                    return @"后天";
                }
                return @"周五";
            }
                break;
            case 7:
            {
                if(weekday1 == 6)
                {
                    return @"明天";
                }
                if(weekday1 == 5)
                {
                    return @"后天";
                }
                return @"周六";
            }
                break;
            default:
                break;
        }
    }

//    NSString * todayString = [[today description] substringToIndex:10];
//    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
//    NSString * tomorrowString = [[tomorrow description] substringToIndex:10];
//    NSString * houtianString = [[houtian description] substringToIndex:10];
//
//    NSString * dateString = [[date description] substringToIndex:10];
//    
//    if ([dateString isEqualToString:todayString])
//    {
//        return @"今天";
//    } else if ([dateString isEqualToString:yesterdayString])
//    {
//        return @"昨天";
//    }else if ([dateString isEqualToString:tomorrowString])
//    {
//        return @"明天";
//    }
//    else if ([dateString isEqualToString:houtianString])
//    {
//        return @"后天";
//    }else
//    {
//    }
    return nil;
}

- (void)initServDataInfo
{
    NSArray *mu_viewArray = [[NSBundle mainBundle] loadNibNamed:@"BCMZouShiView" owner:self options:nil];
    self.ui_zoushiBackViewView = [mu_viewArray objectAtIndex:0];
    self.ui_zoushiBackViewView.frame = CGRectMake(0,0,self.ui_zoushiView.frame.size.width,236);
    [self.ui_zoushiView addSubview:self.ui_zoushiBackViewView];
    self.m_servPerDataArray = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
    NSString *wd_string = [self getServPerData:@"ServPerData"];
    NSData* decodeData = [[NSData alloc] initWithBase64EncodedString:wd_string options:0];
    NSString* decodeStr = [[NSString alloc] initWithData:decodeData encoding:NSASCIIStringEncoding];
    NSDictionary *wd_dic = [decodeStr objectFromJSONString];
    NSArray *wd_array = [wd_dic objectForKey:@"ServPerData"];
    if(wd_array)
    {
        [self.m_servPerDataArray addObjectsFromArray:wd_array];
    }
    BOOL wd_isShowView = NO;
    for(int i = 0;i < self.m_servPerDataArray.count;i++)
    {
        NSDictionary *wd_dic = [self.m_servPerDataArray objectAtIndex:i];
        NSString *wd_dateString = [wd_dic objectForKey:@"date"];
        wd_dateString = [wd_dateString substringToIndex:10];
        NSDateFormatter *wd_dateFormatter = [[NSDateFormatter alloc] init];
        [wd_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *wd_date = [wd_dateFormatter dateFromString:wd_dateString];
        NSString *wd_weekString = [self compareDateWeek:wd_date];
        NSString *wd_dayString = [self compareDateDay:wd_date];
        UIButton *wd_button = (UIButton *)[self.ui_diagramView viewWithTag:401+i];
        UILabel *wd_weekLabel = (UILabel *)[self.ui_diagramView viewWithTag:501+i];
        UILabel *wd_dayLabel = (UILabel *)[self.ui_diagramView viewWithTag:601+i];
        wd_weekLabel.text = wd_weekString;
        wd_dayLabel.text = wd_dayString;
        if([wd_weekString isEqualToString:@"今天"])
        {
            wd_isShowView = YES;
            [self showZoushiViewInfo:wd_button];
        }
    }
    if(wd_isShowView == NO)
    {
        UIButton *wd_button = (UIButton *)[self.ui_diagramView viewWithTag:401];
        [self showZoushiViewInfo:wd_button];
    }
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"业务向导";
    self.ui_contentTrailingConstraint.constant = SCREENWIDTH - 1;
    self.ui_contentTrailingConstraint1.constant = SCREENWIDTH - 1;
    self.ui_contentBottomConstraint.constant = SCREENHEIGHT;
    self.ui_contentBottomConstraint1.constant = SCREENHEIGHT;

    self.m_counterArray = [[NSMutableArray alloc] init];
    self.m_mobileserviceArray = [[NSMutableArray alloc] init];
    self.m_teamArray = [[NSMutableArray alloc] init];
    self.ui_scrollView.hidden = NO;
    self.ui_scrollView1.hidden = YES;
    self.ui_counterButton.selected = YES;
    self.ui_mobileserviceButton.selected = NO;
    
//    [self initServDataInfo];

    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMCounterListCell" bundle:nil];
    [self.ui_typeCollectionView registerNib:mu_cellNib forCellWithReuseIdentifier:@"BCMCounterListCell"];
    UINib *mu_cellNib1 = [UINib nibWithNibName:@"BCMCounterListCell" bundle:nil];
    [self.ui_mobileCollectionView1 registerNib:mu_cellNib1 forCellWithReuseIdentifier:@"BCMCounterListCell"];
    UINib *mu_cellNib2 = [UINib nibWithNibName:@"BCMServiceListCell" bundle:nil];
    [self.ui_serviceCollectionView registerNib:mu_cellNib2 forCellWithReuseIdentifier:@"BCMServiceListCell"];
//    赞无服务  毙掉这段
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getBankCounterinfo:[self getFolderInfoForType:@"bank_counter"]];
        [self getBankMobileserviceinfo:[self getFolderInfoForType:@"bank_mobileservice"]];
//        [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)counterButtonAction:(id)sender
{
    self.ui_scrollView.hidden = NO;
    self.ui_scrollView1.hidden = YES;
    self.ui_counterButton.selected = YES;
    self.ui_mobileserviceButton.selected = NO;
}
- (IBAction)mobileserviceButtonAction:(id)sender
{
    self.ui_scrollView.hidden = YES;
    self.ui_scrollView1.hidden = NO;
    self.ui_counterButton.selected = NO;
    self.ui_mobileserviceButton.selected = YES;
}
- (IBAction)showZoushiViewInfo:(id)sender
{
    UIButton *wd_clickButton = (UIButton *)sender;
    if(wd_clickButton.selected == NO)
    {
        NSInteger wd_index = ((UIButton *)sender).tag;
        NSDictionary *wd_dic = [self.m_servPerDataArray objectAtIndex:wd_index-401];
        for(int i = 0;i < 7;i++)
        {
            UIButton *wd_button = (UIButton *)[self.ui_diagramView viewWithTag:401+i];
            UILabel *wd_weekLabel = (UILabel *)[self.ui_diagramView viewWithTag:501+i];
            UILabel *wd_dayLabel = (UILabel *)[self.ui_diagramView viewWithTag:601+i];
            if(wd_index-401 == i)
            {
                wd_button.selected = YES;
                wd_button.backgroundColor = RGBA(16,100,166,1.0);
                wd_weekLabel.textColor = [UIColor whiteColor];
                wd_dayLabel.textColor = [UIColor whiteColor];
            }
            else
            {
                wd_button.selected = NO;
                wd_button.backgroundColor = [UIColor whiteColor];
                wd_weekLabel.textColor = RGBA(72,72,72,1.0);
                wd_dayLabel.textColor = RGBA(72,72,72,1.0);
            }
        }
        NSArray *wd_array = [wd_dic objectForKey:@"servData"];
        self.ui_zoushiBackViewView.m_array = wd_array;
//        [self.ui_zoushiBackViewView setNeedsLayout];
//        [self.ui_zoushiBackViewView layoutIfNeeded];
        [self.ui_zoushiBackViewView setNeedsDisplay];
    }
}
- (IBAction)showBCMAppInfo:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/jiao-tong-yin-xing/id337876534?mt=8"]];
}
#pragma mark------collectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView == self.ui_typeCollectionView)
    {
        return self.m_counterArray.count;
    }
    if(collectionView == self.ui_mobileCollectionView1)
    {
        return self.m_mobileserviceArray.count;
    }
    return [self.m_teamArray count];
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.ui_serviceCollectionView)
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
    else
    {
        UICollectionViewCell *wd_cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BCMCounterListCell" forIndexPath:indexPath];
        UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
        UILabel *wd_lineLabel1 = (UILabel *)[wd_cellView viewWithTag:301];
        UILabel *wd_lineLabel2 = (UILabel *)[wd_cellView viewWithTag:302];
        UILabel *wd_lineLabel3 = (UILabel *)[wd_cellView viewWithTag:303];
        UILabel *wd_lineLabel4 = (UILabel *)[wd_cellView viewWithTag:304];
        LDImageView *wd_headImageView = (LDImageView *)[wd_cell viewWithTag:305];
        UILabel *wd_nameLabel = (UILabel *)[wd_cellView viewWithTag:306];
        wd_lineLabel1.hidden = NO;
        wd_lineLabel2.hidden = NO;
        wd_lineLabel3.hidden = YES;
        wd_lineLabel4.hidden = NO;
        if(indexPath.row % 4 == 3)
        {
            wd_lineLabel4.hidden = YES;
        }
        if(indexPath.row >= 4)
        {
            wd_lineLabel1.hidden = YES;
        }
        BCMContent *wd_content;
        if(collectionView == self.ui_typeCollectionView)
        {
            wd_content = [self.m_counterArray objectAtIndex:indexPath.row];
        }
        if(collectionView == self.ui_mobileCollectionView1)
        {
            wd_content = [self.m_mobileserviceArray objectAtIndex:indexPath.row];
        }
        wd_nameLabel.text = wd_content.name;
        wd_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon6.png"];
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
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.ui_typeCollectionView)
    {
        float wd_counterWith = SCREENWIDTH/4.0;
//        float wd_counterheight = (wd_counterWith * 188/160.0);
        return CGSizeMake(wd_counterWith,94);
    }
    if(collectionView == self.ui_mobileCollectionView1)
    {
        float wd_counterWith = SCREENWIDTH/4.0;
        return CGSizeMake(wd_counterWith,94);
    }
    if(collectionView == self.ui_serviceCollectionView)
    {
        if(indexPath.row == 0)
        {
            return CGSizeMake(81,102);
        }
        return CGSizeMake(73,102);
    }
    return CGSizeMake(0,0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView == self.ui_typeCollectionView)
    {
        BCMContent *wd_content = [self.m_counterArray objectAtIndex:indexPath.row];
        [BCMToolLib showResouceInfoAction:wd_content nav:self.navigationController isShowServer:NO];
    }
    if(collectionView == self.ui_mobileCollectionView1)
    {
        BCMContent *wd_content = [self.m_mobileserviceArray objectAtIndex:indexPath.row];
        [BCMToolLib showResouceInfoAction:wd_content nav:self.navigationController isShowServer:NO];
    }
    if(collectionView == self.ui_serviceCollectionView)
    {
        BCMContent *wd_content = [self.m_teamArray objectAtIndex:indexPath.row];
        BCMServiceInfoViewController *wd_serviceInfoViewController = [[BCMServiceInfoViewController alloc] initWithNibName:@"BCMServiceInfoViewController" bundle:nil];
        wd_serviceInfoViewController.m_serviceInfoContent = wd_content;
        [self.navigationController pushViewController:wd_serviceInfoViewController animated:YES];
    }
}

@end
