//
//  BCMInvestmentViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMInvestmentViewController.h"
#import "BCMGoldViewController.h"
#import "BCMFundViewController.h"
#import "BCMFinancingViewController.h"
#import "BCMDefineFile.h"
#import "LDImageView.h"
#import "CellMoreProduct.h"
#import "DetailViewController.h"
@interface BCMInvestmentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)BOOL m_istue;

@property (nonatomic,strong) IBOutlet UIView *ui_serverView;
@property (weak, nonatomic) IBOutlet UITableView *tabMoreProduct;

@property (nonatomic,strong) IBOutlet UIImageView *ui_xingImageView;
@property (nonatomic,strong) IBOutlet LDImageView *ui_headImageView;
@property (nonatomic,strong) IBOutlet UILabel *ui_nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_zhiweiLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_yewuLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_zhihangLabel;

@property (nonatomic,strong) BCMContent *serverContent;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)button1Action:(id)sender;
- (IBAction)button2Action:(id)sender;
- (IBAction)button3Action:(id)sender;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_severViewHeightConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_severViewBottomConstraint;



- (IBAction)headButtonAction:(id)sender;
- (IBAction)callButtonAction:(id)sender;


@end

@implementation BCMInvestmentViewController

- (void)getCustomerServiceInfo:(NSString *)folderID
{
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
        wd_appDelegate.m_appId =[NSString stringWithFormat:@"%@",self.user.curBank.appid] ;
        wd_appDelegate.m_deptId = [NSString stringWithFormat:@"%@",self.user.curBank.deptid];
        NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
        NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
        NSFetchRequest *request = [NSFetchRequest new];
        [request setEntity:wd_entityDescription];
        NSArray *wd_serverArray = [self.m_content.servername componentsSeparatedByString:@","];
        NSString *wd_nameString = [wd_serverArray objectAtIndex:0];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"folderId=%@ AND servName=%@",folderID,wd_nameString];
        [request setPredicate:predicate];
        NSArray *studentAry = [context executeFetchRequest:request error:nil];
        if (studentAry.count>0)
        {
            self.serverContent = [studentAry objectAtIndex:0];
            [self initSubView:self.serverContent];
        }
        else
        {
            self.ui_serverView.hidden = YES;
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

- (void)initSubView:(BCMContent *)contentSever
{
    CALayer * wd_layer = [self.ui_headImageView layer];
    wd_layer.masksToBounds = YES;
    wd_layer.cornerRadius = self.ui_headImageView.bounds.size.width/2.0;
    self.ui_headImageView.defaultImage = [UIImage imageNamed:@"default_image_icon2.png"];
    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *wd_picString;
    if([wd_appDelegate.m_isTFI isEqualToString:@"YES"])
    {
        NSString *wd_tfiUrlPath = [wd_appDelegate.m_urlPath stringByAppendingFormat:@"%@/%@/%@/",wd_appDelegate.m_appId,contentSever.folderId,contentSever.id];
        wd_picString = [wd_tfiUrlPath stringByAppendingString:contentSever.logo];
    }
    else
    {
        wd_picString = [wd_appDelegate.m_urlPath stringByAppendingString:contentSever.logohosturl];
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
    self.ui_nameLabel.text = contentSever.servName;
    self.ui_zhiweiLabel.text = contentSever.servPosition;
    self.ui_yewuLabel.text = contentSever.servRespbusiness;
    float wd_height = 202;
    wd_height = wd_height + self.ui_yewuLabel.frame.size.height;
    self.ui_severViewHeightConstraint.constant = wd_height;
    self.ui_severViewBottomConstraint.constant = (self.ui_serverView.frame.size.height - 86)* -1;
    switch ([contentSever.servLevel intValue]) {
        case 1:
            self.ui_xingImageView.image = [UIImage imageNamed:@"xing_small_icon1.png"];
            break;
        case 2:
            self.ui_xingImageView.image = [UIImage imageNamed:@"xing_small_icon2.png"];
            break;
        case 3:
            self.ui_xingImageView.image = [UIImage imageNamed:@"xing_small_icon3.png"];
            break;
        case 4:
            self.ui_xingImageView.image = [UIImage imageNamed:@"xing_small_icon4.png"];
            break;
        case 5:
            self.ui_xingImageView.image = [UIImage imageNamed:@"xing_small_icon5.png"];
            break;
        default:
            break;
    }
    
    self.ui_serverView.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.m_istue = NO;
    self.ui_severViewBottomConstraint.constant = self.ui_serverView.frame.size.height * -1;
    self.ui_serverView.hidden = YES;
//    if(self.m_showServer == YES)
//    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
        });
//    }
    
self.title = @"投资理财";
    
    [self.tabMoreProduct registerClass:[CellMoreProduct class] forCellReuseIdentifier:@"CellMoreProduct"];
    self.tabMoreProduct.delegate = self;
    self.tabMoreProduct.dataSource = self;
    [self.tabMoreProduct reloadData];
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSeverView:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [self.ui_serverView addGestureRecognizer:recognizer];
    UISwipeGestureRecognizer *recognizer1;
    recognizer1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(hidenSeverView:)];
    [recognizer1 setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.ui_serverView addGestureRecognizer:recognizer1];
}

- (void)showSeverView:(UISwipeGestureRecognizer *)swipeGesture
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        float wd_height = 202;
        wd_height = wd_height + self.ui_yewuLabel.frame.size.height;
        self.ui_severViewHeightConstraint.constant = wd_height;
        self.ui_severViewBottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.m_istue = YES;
    }];
}
- (void)hidenSeverView:(UISwipeGestureRecognizer *)swipeGesture
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.ui_severViewBottomConstraint.constant = (self.ui_serverView.frame.size.height - 86)* -1;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.m_istue = NO;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)button1Action:(id)sender
{
    BCMFundViewController *wd_fundViewController = [[BCMFundViewController alloc] initWithNibName:@"BCMFundViewController" bundle:nil];
    [self.navigationController pushViewController:wd_fundViewController animated:YES];
}
- (IBAction)button2Action:(id)sender
{
    BCMGoldViewController *wd_goldViewController = [[BCMGoldViewController alloc] initWithNibName:@"BCMGoldViewController" bundle:nil];
    [self.navigationController pushViewController:wd_goldViewController animated:YES];
}
- (IBAction)button3Action:(id)sender
{
    BCMFinancingViewController *wd_financingViewController = [[BCMFinancingViewController alloc] initWithNibName:@"BCMFinancingViewController" bundle:nil];
    [self.navigationController pushViewController:wd_financingViewController animated:YES];
}

- (IBAction)headButtonAction:(id)sender
{
    if(self.m_istue == NO)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            float wd_height = 202;
            wd_height = wd_height + self.ui_yewuLabel.frame.size.height;
            self.ui_severViewHeightConstraint.constant = wd_height;
            self.ui_severViewBottomConstraint.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.m_istue = YES;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            self.ui_severViewBottomConstraint.constant = (self.ui_serverView.frame.size.height - 86)* -1;
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            self.m_istue = NO;
        }];
    }
}
- (IBAction)callButtonAction:(id)sender
{
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",self.serverContent.servPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CellMoreProduct *cell = [tableView dequeueReusableCellWithIdentifier:@"CellMoreProduct"];
    
    cell.btnBack.image = [UIImage imageNamed:[NSString stringWithFormat:@"item%ld",(long)indexPath.row+1]];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 1) {
        return 150;
    }else{
        return 100;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DetailViewController *detailVC = [[DetailViewController alloc]init];
    detailVC.index = indexPath.row%2+1;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:detailVC animated:YES];
    

}
@end
