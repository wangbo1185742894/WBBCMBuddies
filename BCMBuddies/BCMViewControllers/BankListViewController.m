//
//  BankListViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BankListViewController.h"
#import "BackViewCell.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "ModBank.h"
#import "BCMToolLib.h"
#import "BCMFirstViewController.h"
#import "ZipArchive.h"
#import "BCMNavigationController.h"
#define  downPath @"http://tfi.11max.com/Department/GetAreaDepartList"

@interface BankListViewController ()<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong) MBProgressHUD *m_hud;

@property (nonatomic,assign) BOOL m_isFirstParse;



@end

@implementation BankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [GlobalUser globalUser];
    self.dataArray = [[NSMutableArray alloc]init];
    self.tabBankList.delegate = self;
    self.tabBankList.dataSource  =self;
    [self.tabBankList registerClass:[BackViewCell class] forCellReuseIdentifier:@"bankListCell"];
    self.tabBankList.rowHeight = 62;
    
//    ModBank *bank1 = [[ModBank alloc]initWithBankName:@"西安高新科技支行(当前)" andRemark:@"锦业路38号粤汉国际D座1层101"];
//    ModBank *bank2 = [[ModBank alloc]initWithBankName:@"唐延路支行" andRemark:@"唐延路35号旺座现代城D座1层"];
//    ModBank *bank3 = [[ModBank alloc]initWithBankName:@"西安长安科技园支行" andRemark:@"紫薇田园都市E区33114-33115号"];
//    ModBank *bank4 = [[ModBank alloc]initWithBankName:@"软件园支行" andRemark:@"西安市高新区科技二路68号"];
//    ModBank *bank5 = [[ModBank alloc]initWithBankName:@"长安南路支行" andRemark:@"西安市雁塔区长安南路439号"];
//    ModBank *bank6 = [[ModBank alloc]initWithBankName:@"西安高新科技支行" andRemark:@"锦业路38号粤汉国际D座1层10101"];
//    ModBank *bank7 = [[ModBank alloc]initWithBankName:@"交通银行小伙伴测试" andRemark:@"顶级机构自动创建"];
//
//    [self.dataArray addObjectsFromArray:@[bank1,bank2,bank3,bank4,bank5,bank6,bank7]];
    
//    if (self.user.curBank != nil) {
//        self.labTitle.text = self.user.curBank.name;
//        self.labAddress.text = self.user.curBank.remark
//        ;
//    }else{
//    
//        self.labAddress.text = bank1.remark;
//        self.labTitle.text = bank1.name;
//    }
    
    NSDictionary *para = @{@"lon":@"108.123",@"lat":@"34.456"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:downPath parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *tempArray = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
    
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *plistPath1= [paths objectAtIndex:0];
        
        NSLog(@"%@",plistPath1);
        //得到完整的路径名
//        NSString *fileName = [plistPath1 stringByAppendingPathComponent:@"bankList.plist"];
        //NSMutableDictionary *myDic = [[NSMutableDictionary alloc]init];
        //[myDic setValuesForKeysWithDictionary:cityDic];
        NSFileManager *fm = [NSFileManager defaultManager];
        for (NSDictionary *dic in tempArray) {
            
            ModBank *bank = [[ModBank alloc]initWithDic:dic];
            [self.dataArray addObject:bank];
        }
        [self.tabBankList reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    self.wd_delegate = [[UIApplication sharedApplication]delegate];

    [self.tabBankList reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    GlobalUser *user = [GlobalUser globalUser];
    ModBank *bank = self.dataArray[indexPath.row];
    user.curBank =bank;
    self.wd_delegate.m_appId =[NSString stringWithFormat:@"%@",bank.appid] ;
    self.wd_delegate.m_deptId = [NSString stringWithFormat:@"%@",bank.deptid];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"NSNotificationChangeCurBack" object:nil];
    BCMFirstViewController *wd_firstViewController = [[BCMFirstViewController alloc] initWithNibName:@"BCMFirstViewController" bundle:nil];
    BCMNavigationController *wd_navigationController = [[BCMNavigationController alloc] initWithRootViewController:wd_firstViewController];
    [wd_navigationController setNavigationBarHidden:YES animated:NO];
    [wd_navigationController setToolbarHidden:YES animated:NO];
    self.view.window.rootViewController = wd_navigationController;
  }

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    BackViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankListCell"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ModBank *bank = self.dataArray[indexPath.row];
    cell.labBankName.text  = bank.name;
    cell.labBankAddress.text = bank.remark;
  
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
