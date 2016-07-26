//
//  DetailViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/27.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "DetailViewController.h"
#import "LDImageView.h"
#import "OrderViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet LDImageView *ui_headImageView;
@property (nonatomic,strong)BCMContent*serverContent;
@property (weak, nonatomic) IBOutlet UILabel *ui_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ui_positionLable;
@property (weak, nonatomic) IBOutlet UIView *ui_serverView;

@end

@implementation DetailViewController
- (IBAction)actionQuestion:(UIButton *)sender {
    NSString *wd_phoneString = [NSString stringWithFormat:@"tel://18888888888"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
}
- (IBAction)actionOrder:(UIButton *)sender {
    OrderViewController *orderVC = [[OrderViewController alloc ]init];
    orderVC .modelContent = self.serverContent;
    [self.navigationController pushViewController:orderVC animated:YES];
}

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
        NSString *wd_nameString = @"李晓丽";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"folderId=%@ AND servName=%@",folderID,wd_nameString];
        [request setPredicate:predicate];
        NSArray *studentAry = [context executeFetchRequest:request error:nil];
        if (studentAry.count>0)
        {
            self.serverContent = [studentAry objectAtIndex:0];
            [self initSubView:self.serverContent];
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
    self.ui_positionLable.text = contentSever.servPosition;
        self.ui_serverView.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_index == 1) {
        self.title = @"得利宝天添利C款";
        
    }else{
        self.title = @"中油核心竞争灵活配置混合";
    
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
    });
    self.detailImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"detail%d",_index]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
