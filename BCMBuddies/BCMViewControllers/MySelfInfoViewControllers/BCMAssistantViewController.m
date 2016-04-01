//
//  BCMAssistantViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMAssistantViewController.h"
#import "BCMDefineFile.h"
#import "AppDelegate.h"
#import "LDImageView.h"
#import "WDCustemButton.h"
#import "BCMServiceInfoViewController.h"
#import "BCMAssistantListCell.h"

@interface BCMAssistantViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UITableView *ui_tableView;
@property (nonatomic,weak) IBOutlet UIButton *ui_deleteButton;
@property (nonatomic,weak) IBOutlet UIButton *ui_deleteSelectedButton;
@property (nonatomic,weak) IBOutlet UIButton *ui_deleteAllButton;
@property (nonatomic,weak) IBOutlet UIView *ui_deleteView;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_deleteViewBottomConstraint;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *ui_tableViewBottomConstraint;

@property (nonatomic,strong) NSMutableArray *ui_assistantArray;
@property (nonatomic,strong) NSMutableArray *ui_selectedAssistantArray;
@property (nonatomic,assign) BOOL m_isEdit;

- (IBAction)backButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)callButtonAction:(id)sender;
- (IBAction)clickAssistantCellButtonAction:(id)sender;
- (IBAction)selectAssistantCellButtonAction:(id)sender;
- (IBAction)deleteSelectedButtonAction:(id)sender;
- (IBAction)deleteAllButtonAction:(id)sender;

@end

@implementation BCMAssistantViewController

- (void)getAssistantList:(NSString *)folderID
{
    [self.ui_assistantArray removeAllObjects];
    if(folderID)
    {
        AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
        NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
        NSFetchRequest *request = [NSFetchRequest new];
        [request setEntity:wd_entityDescription];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"folderId=%@ AND isAdd=%@",folderID,@"YES"];
        [request setPredicate:predicate];
        NSArray *studentAry = [context executeFetchRequest:request error:nil];
        if (studentAry.count>0)
        {
            for(int i = 0;i < studentAry.count;i++)
            {
                BCMContent *wd_manageObject = [studentAry objectAtIndex:i];
                [self.ui_assistantArray addObject:wd_manageObject];
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
        BCMFolder *wd_folderInfo = [studentAry objectAtIndex:0];
        [self getAssistantList:wd_folderInfo.id];
    }
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ui_assistantArray = [[NSMutableArray alloc] init];
    self.ui_selectedAssistantArray = [[NSMutableArray alloc] init];
    UINib *mu_cellNib = [UINib nibWithNibName:@"BCMAssistantListCell" bundle:nil];
    [self.ui_tableView registerNib:mu_cellNib forCellReuseIdentifier:@"BCMAssistantListCell"];
    
    CALayer * wd_layer = [self.ui_deleteSelectedButton layer];
    wd_layer.masksToBounds = YES;
    wd_layer.cornerRadius = 4;
    CALayer * wd_layer1 = [self.ui_deleteAllButton layer];
    wd_layer1.masksToBounds = YES;
    wd_layer1.cornerRadius = 4;
    
    self.ui_deleteView.hidden = YES;
    self.ui_deleteViewBottomConstraint.constant = -55;
    self.ui_tableViewBottomConstraint.constant = 0;

    self.m_isEdit = NO;
    [self.ui_selectedAssistantArray removeAllObjects];
    [self.ui_deleteButton setImage:[UIImage imageNamed:@"delete_button_image.png"] forState:UIControlStateNormal];
    [self.ui_deleteButton setTitle:nil forState:UIControlStateNormal];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self getFolderInfoForType:@"customer_service"];
    });
}

- (void)deleteServiceInfo:(BCMContent *)content
{
    AppDelegate *wd_appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = wd_appDelegate.managedObjectContext;
    NSEntityDescription *wd_entityDescription = [NSEntityDescription entityForName:@"BCMContent" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:wd_entityDescription];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%@",content.id];
    if(predicate)
    {
        [request setPredicate:predicate];
    }
    NSArray *studentAry = [context executeFetchRequest:request error:nil];
    if (studentAry.count > 0)
    {        //更新里面的值
        BCMContent *wd_manageObject = studentAry[0];
        wd_manageObject.isAdd = @"NO";
        NSError *error;
        if ([context save:&error])
        {
        }
        else
        {
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)deleteButtonAction:(id)sender
{
    if(self.m_isEdit)
    {
        self.ui_deleteView.hidden = YES;
        self.ui_deleteViewBottomConstraint.constant = -55;
        self.ui_tableViewBottomConstraint.constant = 0;
        self.m_isEdit = NO;
        [self.ui_selectedAssistantArray removeAllObjects];
        [self.ui_deleteButton setImage:[UIImage imageNamed:@"delete_button_image.png"] forState:UIControlStateNormal];
        [self.ui_deleteButton setTitle:nil forState:UIControlStateNormal];
    }
    else
    {
        self.ui_deleteView.hidden = NO;
        self.ui_deleteViewBottomConstraint.constant = 0;
        self.ui_tableViewBottomConstraint.constant = 55;
        [self.ui_selectedAssistantArray removeAllObjects];
        [self.ui_deleteButton setImage:nil forState:UIControlStateNormal];
        [self.ui_deleteButton setTitle:@"完成" forState:UIControlStateNormal];
        self.m_isEdit = YES;
    }
    [self.ui_tableView reloadData];
}
- (IBAction)callButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    if(self.m_isEdit == NO)
    {
        BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:wd_button.m_index];
        NSString *wd_phoneString = [NSString stringWithFormat:@"tel://%@",wd_content.servPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:wd_phoneString]];
    }
}
- (IBAction)clickAssistantCellButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    if(self.m_isEdit == NO)
    {
        BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:wd_button.m_index];
        BCMServiceInfoViewController *wd_serviceInfoViewController = [[BCMServiceInfoViewController alloc] initWithNibName:@"BCMServiceInfoViewController" bundle:nil];
        wd_serviceInfoViewController.m_serviceInfoContent = wd_content;
        [self.navigationController pushViewController:wd_serviceInfoViewController animated:YES];
    }
}
- (IBAction)selectAssistantCellButtonAction:(id)sender
{
    WDCustemButton *wd_button = (WDCustemButton *)sender;
    BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:wd_button.m_index];
    if(wd_button.selected == YES)
    {
        [self.ui_selectedAssistantArray removeObject:wd_content];
    }
    else
    {
        [self.ui_selectedAssistantArray addObject:wd_content];
    }
    wd_button.selected = !wd_button.selected;
//    [self.ui_tableView reloadData];
}
- (IBAction)deleteSelectedButtonAction:(id)sender
{
    if(self.ui_selectedAssistantArray.count <= 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您还没有选择要删除的助理，请选择后再删除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        for(NSUInteger i = self.ui_selectedAssistantArray.count;i > 0;i--)
        {
            BCMContent *wd_content = [self.ui_selectedAssistantArray objectAtIndex:i-1];
            [self deleteServiceInfo:wd_content];
            [self.ui_selectedAssistantArray removeObject:wd_content];
            [self.ui_assistantArray removeObject:wd_content];
        }
        [self deleteButtonAction:nil];
    }
}
- (IBAction)deleteAllButtonAction:(id)sender
{
    for(NSUInteger i = self.ui_assistantArray.count;i > 0;i--)
    {
        BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:i-1];
        [self deleteServiceInfo:wd_content];
    }
    [self.ui_selectedAssistantArray removeAllObjects];
    [self.ui_assistantArray removeAllObjects];
    [self.ui_tableView reloadData];
    [self deleteButtonAction:nil];
}
#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ui_assistantArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BCMAssistantListCell *wd_cell = [tableView dequeueReusableCellWithIdentifier:@"BCMAssistantListCell"];
    if(wd_cell == nil)
    {
        wd_cell = [[BCMAssistantListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BCMAssistantListCell"];
    }
    UIView *wd_cellView = (UIView *)[wd_cell viewWithTag:300];
    UILabel *wd_lineLabel = (UILabel *)[wd_cellView viewWithTag:301];
    LDImageView *wd_headImageView = (LDImageView *)[wd_cellView viewWithTag:302];
    UILabel *wd_nameLabel = (UILabel *)[wd_cellView viewWithTag:303];
    UIImageView *wd_imageView1 = (UIImageView *)[wd_cellView viewWithTag:304];
    UIImageView *wd_imageView2 = (UIImageView *)[wd_cellView viewWithTag:305];
    UIImageView *wd_imageView3 = (UIImageView *)[wd_cellView viewWithTag:306];
    UIImageView *wd_imageView4 = (UIImageView *)[wd_cellView viewWithTag:307];
    UIImageView *wd_imageView5 = (UIImageView *)[wd_cellView viewWithTag:308];
    UILabel *wd_messageLabel = (UILabel *)[wd_cellView viewWithTag:309];
    WDCustemButton *wd_callButton = (WDCustemButton *)[wd_cellView viewWithTag:310];
    WDCustemButton *wd_cellButton = (WDCustemButton *)[wd_cellView viewWithTag:312];
    UILabel *wd_lineLabel1 = (UILabel *)[wd_cellView viewWithTag:311];
    WDCustemButton *wd_selecteButton = (WDCustemButton *)[wd_cellView viewWithTag:314];
    wd_callButton.m_index = indexPath.row;
    wd_cellButton.m_index = indexPath.row;
    wd_selecteButton.m_index = indexPath.row;
    wd_imageView1.hidden = YES;
    wd_imageView2.hidden = YES;
    wd_imageView3.hidden = YES;
    wd_imageView4.hidden = YES;
    wd_imageView5.hidden = YES;
    wd_lineLabel.hidden = YES;
    wd_lineLabel1.hidden = NO;
    BCMContent *wd_content = [self.ui_assistantArray objectAtIndex:indexPath.row];
    if(self.m_isEdit == YES)
    {
        wd_selecteButton.hidden = NO;
        wd_selecteButton.selected = NO;
        wd_cell.ui_imageLeftConstraint.constant = 44;
        if([self.ui_selectedAssistantArray containsObject:wd_content])
        {
            wd_selecteButton.selected = YES;
        }
    }
    else
    {
        wd_selecteButton.hidden = YES;
        wd_cell.ui_imageLeftConstraint.constant = 14;
    }
    wd_nameLabel.text = wd_content.name;
    wd_messageLabel.text = [@"职务：" stringByAppendingString:wd_content.servPosition];
    for(int i = 0;i < [wd_content.servLevel intValue];i++)
    {
        int wd_tag = 304+i;
        UIImageView *wd_xing = (UIImageView *)[wd_cell viewWithTag:wd_tag];
        wd_xing.hidden = NO;
    }
    CALayer * wd_layer1 = [wd_headImageView layer];
    wd_layer1.masksToBounds = YES;
    wd_layer1.cornerRadius = wd_headImageView.bounds.size.height/2;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
