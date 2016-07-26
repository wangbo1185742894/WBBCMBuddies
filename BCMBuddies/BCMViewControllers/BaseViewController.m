//
//  BaseViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BaseViewController.h"
#import "ModRootVCQueue.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [GlobalUser globalUser];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button setImage:[UIImage imageNamed:@"back_icon.png"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.wd_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    self.loadData = [LoadData singleLoadData];
    [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}

-(void)popViewController{

    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString *)userID{

    NSUserDefaults *userDe = [NSUserDefaults standardUserDefaults];
  
    return [userDe objectForKey:@"userID"];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refreshDataArray) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [self.timer invalidate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshDataArray{
    
    
    
    
    [_wd_delegate initURLPath:[self.wd_delegate isTIFServerInfo]?@"YES":@"NO"];
    NSString *strUrl;
    if ([_wd_delegate.m_isTFI isEqualToString:@"YES"]) {
        strUrl = [NSString stringWithFormat:@"%@%@/QueuingReminder/serv_getCounterType?userId=%@",self.wd_delegate.m_urlPath,self.wd_delegate.m_appId,self.userID];
    }else{
        strUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_getCounterType?userId=%@",self.wd_delegate.m_urlPath,self.userID];
        
    }
   
    if (self.user.dataArray.count==0) {
        ModRootVCQueue *queue = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"J",@"preServiceTime":@"0",@"counterList":@[]}];
        ModRootVCQueue *queue1 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"Q",@"preServiceTime":@"0",@"counterList":@[]}];
        ModRootVCQueue *queue2 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"W",@"preServiceTime":@"0",@"counterList":@[]}];
        [self.user.dataArray addObjectsFromArray:@[queue,queue1,queue2]];
    }
    
    
    NSDictionary *para = @{@"userId":self.userID};
    
    [self.loadData requsetWithString:strUrl isPost:NO andPara:para andComplete:^(id data, BOOL isSuccess) {
        
       
        
        if (isSuccess) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSDictionary *dic1;
            if ([self.wd_delegate.m_isTFI isEqualToString:@"YES"]) {
                dic1= dic;
                
            }else{
                dic1 = dic[@"data"];
            }
            NSString *result = [NSString stringWithFormat:@"%@",dic[@"status"]];
            if (![result isEqualToString:@"0"]) {
                
                NSArray *array = [dic1 objectForKey:@"counterTypeModelList"];
                for (NSDictionary *dic in array) {
                    ModRootVCQueue *queue = [[ModRootVCQueue alloc]initWithDic:dic];
                   
                    
                    
                    if ([queue.codeType isEqualToString:@"J"]) {
                        
                        [self.user.dataArray replaceObjectAtIndex:0 withObject:queue];
                    }else if([queue.codeType isEqualToString:@"Q"]){
                        
                        [self.user.dataArray replaceObjectAtIndex:1 withObject:queue];
                    }else if ([queue.codeType isEqualToString:@"W"]){
                        [self.user.dataArray replaceObjectAtIndex:2 withObject:queue];
                        
                    }
                    
                }
                
                [self.user.dataArray sortUsingComparator:^NSComparisonResult(ModRootVCQueue *obj1,ModRootVCQueue* obj2) {
                    
                    return [obj1.codeType localizedCompare:obj2.codeType];
                }];
            
                
                //                for (int i = 0 ; i<3; i++) {
                //                    ModRootVCQueue *quque = self.dataArray[i];
                //                    NSLog(@"%@",quque.codeType);
                //                }
                
            }else{
            
                [self.user.dataArray removeAllObjects]; 
                ModRootVCQueue *queue = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"J",@"preServiceTime":@"0",@"counterList":@[]}];
                ModRootVCQueue *queue1 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"Q",@"preServiceTime":@"0",@"counterList":@[]}];
                ModRootVCQueue *queue2 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"W",@"preServiceTime":@"0",@"counterList":@[]}];
                [self.user.dataArray addObjectsFromArray:@[queue,queue1,queue2]];
            }
        }
    }];
    
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
