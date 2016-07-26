//
//  BCMInfoViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/3.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMInfoViewController.h"
#import "LDImageView.h"
#import "OrderViewController.h"

@interface BCMInfoViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) IBOutlet UIView *ui_serverView;
@property (nonatomic,weak) IBOutlet  UIWebView *ui_webView;
@property (nonatomic,weak) IBOutlet  UILabel *ui_titleLabel;
@property (nonatomic,weak) IBOutlet  UIActivityIndicatorView *ui_longdingView;
@property (nonatomic,strong) IBOutlet UIImageView *ui_xingImageView;
@property (nonatomic,strong) IBOutlet LDImageView *ui_headImageView;
@property (nonatomic,strong) IBOutlet UILabel *ui_nameLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_zhiweiLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_yewuLabel;
@property (nonatomic,strong) IBOutlet UILabel *ui_zhihangLabel;

@property (nonatomic,assign) BOOL m_istue;
@property (nonatomic,strong) BCMContent *serverContent;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_severViewHeightConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_severViewBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_webBottomConstraint;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)headButtonAction:(id)sender;
- (IBAction)callButtonAction:(id)sender;

@end

@implementation BCMInfoViewController

- (void)getCustomerServiceInfo:(NSString *)folderID
{
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
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
- (IBAction)actionOrder:(UIButton *)sender {
    OrderViewController *orderVC = [[OrderViewController alloc ]init];
    orderVC.modelContent = self.serverContent;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:orderVC animated:YES];
}
- (NSString *)getFolderInfoForType:(NSString *)type
{
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    wd_appDelegate.m_appId =[NSString stringWithFormat:@"%@",self.user.curBank.appid] ;
    wd_appDelegate.m_deptId = [NSString stringWithFormat:@"%@",self.user.curBank.deptid];
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
   
    self.ui_serverView.hidden = YES;
    if(self.m_showServer == YES)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
        });
    }
    
    
    self.ui_longdingView.hidden = YES;
    [self.ui_longdingView stopAnimating];
    self.ui_titleLabel.text = self.m_content.name;
    NSURL *url = [NSURL URLWithString:self.m_urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.ui_webView loadRequest:request];
    
//    self.ui_webView.scalesPageToFit = self.isSize;


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)callButtonAction:(id)sender
{
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",self.serverContent.servPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
}
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.ui_longdingView.hidden = NO;
    [self.ui_longdingView startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.ui_longdingView.hidden = YES;
    [self.ui_longdingView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    self.ui_longdingView.hidden = YES;
    [self.ui_longdingView stopAnimating];
}

@end
