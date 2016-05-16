//
//  GroupViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "GroupViewController.h"
#import "PersonInfoViewController.h"
#import "PersonDetailInfoViewCell.h"
#import "AppDelegate.h"
#import "BCMDefineFile.h"
#import "UIImage+ImageWithColor.h"
#import "OrderViewController.h"

@interface GroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIView *topButtonSelectView;
@property (weak, nonatomic) IBOutlet UITableView *tabPersonList;
@property(strong,nonatomic) NSMutableArray *m_teamArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSelectItems;


@end

@implementation GroupViewController


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
            [self.tabPersonList reloadData];
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
-(void)setBackColor:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageWithColor:RGBA(27, 120, 216, 1.0)] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [button.layer setBorderWidth:1];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"当值团队";
    self.tabPersonList.delegate = self;
    self.tabPersonList.dataSource = self;
    [self.tabPersonList registerClass:[PersonDetailInfoViewCell class] forCellReuseIdentifier:@"personInfoCell"];
    self.tabPersonList.rowHeight = 100;
    
    
    self.m_teamArray = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getCustomerServiceInfo:[self getFolderInfoForType:@"customer_service"]];
        
    });
    
    for (UIButton *item in self.btnSelectItems) {
        [self setBackColor:item];
        
        [item addTarget:self action:@selector(actionSelectItems:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)actionSelectItems:(UIButton*)btn{

    [self.tabPersonList reloadData];
    btn.selected = !btn.selected;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc]initWithNibName:@"PersonInfoViewController" bundle:nil];
    personInfoVC.modelContent = self.m_teamArray[indexPath.row];
    [self.navigationController pushViewController:personInfoVC animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.m_teamArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PersonDetailInfoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personInfoCell"];
    [cell setStateBackColor:YES];
    BCMContent *content = self.m_teamArray[indexPath.row];
    cell.modelContent = content;
    [cell reloadData];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIButton *btn in self.btnSelectItems) {
        if (btn.selected == YES){
        
            if (indexPath.row>=3) {
                [cell setStateBackColor:NO];
            }
            break;
        }
    }
    cell.controller = self;
    return cell;
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
