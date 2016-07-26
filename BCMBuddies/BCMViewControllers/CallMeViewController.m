  //
//  CallMeViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/9.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "CallMeViewController.h"
#import "AppDelegate.h"
#import "BCMDefineFile.h"
#import "UIImage+ImageWithColor.h"
#import "LoadData.h"
#import "SubmitPhoneNumberViewController.h"
#import "ModRootVCQueue.h"
#import "GlobalUser.h"
#import "ResultInfoViewController.h"

#import "ListenViewController.h"

@interface CallMeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak,nonatomic)AppDelegate *delegate;
@property (nonatomic,assign)NSInteger strQueueType;

@property (nonatomic,assign)NSInteger orderNumber;


@property(nonatomic,strong)NSString * maxCode;
@property(nonatomic,strong)NSString * minCode;

@property(nonatomic,assign)NSInteger selectIndex;


@property (nonatomic,strong)NSArray *items;
@end

@implementation CallMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"到号提醒";
    self.items = @[@"J2",@"Q3",@"W1"];
    self.selectIndex = -1;
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
 NSString * requserUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_setSceneListenNum",self.delegate.m_urlPath];
    self.maxCode=self.minCode=@"000";
    if (self.user.dataArray.count != 0) {
        ModRootVCQueue *queue = self.user.dataArray[0];
        if (queue.codeList.count>0) {
            NSDictionary *dictemp = [queue.codeList firstObject];
            
            self.minCode = dictemp[@"code"]==nil?@"000":[queue.lastCodeNumber substringFromIndex:1];
            
            NSDictionary *dictempl = [queue.codeList lastObject];
            
            self.maxCode = dictempl[@"code"]==nil?@"000":[dictempl[@"code"] substringFromIndex:1];
        }else if (queue.codeList.count == 0){
        
          self.minCode =queue.lastCodeNumber == nil?@"000":[queue.lastCodeNumber substringFromIndex:1];
         
        }else{
            
            self.minCode=self.maxCode =@"000";
        }
    }
    
    
   
   
    self.strQueueType = 0;
    [self.swiTFI setOn:[self.delegate isTIFServerInfo]];

//    self.btnSure.enabled = [self.delegate isTIFServerInfo];
//    if ([self.delegate isTIFServerInfo]) {
        self.labPleaseOrder.text = @"输入排队号码，马上知道何时到我";
        self.labPleaseOrder.textColor = RGBA(72, 72, 72, 1.0);
        self.btnSure.enabled = YES;
        
//    }else{
//    
//        self.labPleaseOrder.text = @"请链接TFI网络开启电话叫我";
//        self.labPleaseOrder.textColor = RGBA(250, 130, 46, 1.0);
//        self.segSelectQueue.enabled = NO;
//        self.btnSure.enabled = NO;
//    }
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear: animated];
    [self.swiTFI setOn:[self.wd_delegate isTIFServerInfo]];
        
}

//-(void)segmentChange:(UISegmentedControl*)seg{
//    self.strQueueType = seg.selectedSegmentIndex;
//    
//    ModRootVCQueue *queue = self.user.dataArray[seg.selectedSegmentIndex];
//    if (queue.codeList.count>0) {
//        NSDictionary *dictemp = [queue.codeList firstObject];
//        
//        self.minCode = dictemp[@"code"]==nil?@"000":[dictemp[@"code"]substringFromIndex:1];
//        NSDictionary *dictempl = [queue.codeList lastObject];
//        
//        self.maxCode = dictempl[@"code"]==nil?@"000":[dictempl[@"code"] substringFromIndex:1];
//    }else if (queue.codeList.count == 0){
//        
//       self.minCode =queue.lastCodeNumber == nil?@"000":[queue.lastCodeNumber substringFromIndex:1];
//        
//    }else{
//        
//     self.minCode=self.maxCode =@"000";
//    }
//    self.labNumber.text = [NSString stringWithFormat:@"%@%@",self.items[seg.selectedSegmentIndex],self.minCode];
//    self.selectIndex = 0;
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ActionSelectWIfi:(UISwitch *)sender {
    if (sender.isOn) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionSelectBeforeTime:(UIButton *)sender {
}

//- (IBAction)actionAddNumber:(UIButton *)sender {
//    ModRootVCQueue *queue = self.user.dataArray[self.segSelectQueue.selectedSegmentIndex];
//    if (queue.codeList.count==0) {
//        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
//        [self.delegate hideWithLong:1.7];
//        return;
//    }
//    if (self.selectIndex>0) {
//        self.selectIndex --;
//    }else{
//        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
//        [self.delegate hideWithLong:1.7];
//        return;
//    }
//    
// 
//    NSDictionary *queueDic = queue.codeList[self.selectIndex];
//    self.labNumber.text = [NSString stringWithFormat:@"%@%@",self.items[self.segSelectQueue.selectedSegmentIndex],[queueDic[@"code"] substringFromIndex:1]];
//}

//- (IBAction)actionSubNumber:(UIButton *)sender {
//    
//    ModRootVCQueue *queue = self.user.dataArray[self.segSelectQueue.selectedSegmentIndex];
//    
//    if (queue.codeList.count==0) {
//        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
//        [self.delegate hideWithLong:1.7];
//        return;
//    }
//    if (self.selectIndex<queue.codeList.count-1) {
//        self.selectIndex ++;
//    }else{
//    
//        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
//        [self.delegate hideWithLong:1.7];
//        return;
//    }
//    
//   NSDictionary *queueDic = queue.codeList[self.selectIndex];
//    self.labNumber.text = [NSString stringWithFormat:@"%@%@",self.items[self.segSelectQueue.selectedSegmentIndex],[queueDic[@"code"] substringFromIndex:1]];
//}

- (IBAction)actionSubmit:(UIButton *)sender {
    
    NSInteger index;
    
    if (self.txtNumber.text.length != 4) {
        [self.delegate alterView:self.view andTitle:@"请输入您的抽号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    NSString *type = [self.txtNumber.text substringToIndex:1];
    
    if ([type isEqualToString:@"2"]) {
        index = 0;
    }else if ([type isEqualToString:@"3"]){
        index = 1;
        
    }else if([type isEqualToString:@"1"]){
        index = 2;
    }
    
    ModRootVCQueue *queue = self.user.dataArray[index];
    if (queue.codeList.count==0) {
        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    for (int i = 0; i<queue.codeList.count; i++) {
        NSDictionary *dic = queue.codeList[i];
        
        NSString *strCode = dic[@"code"];
        if ([[strCode substringFromIndex:1] isEqualToString:[self.txtNumber.text substringFromIndex:1]]) {
            self.selectIndex = i;
            break;
        }
        
    }
    
    if (self.selectIndex == -1) {
        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
    NSDictionary *dic = queue.codeList[self.selectIndex];
    NSInteger waitTime = [dic[@"waitTime"] integerValue];
    if (self.selectIndex<=1&&self.selectIndex !=-1){
        
        NSString *codeType;
        if ([queue.codeType isEqualToString:@"J"]) {
            codeType = @"J2";
        }else if ([queue.codeType isEqualToString:@"W"]){
            
            codeType = @"W1";
            
        }else if ([queue.codeType isEqualToString:@"Q"]){
            
            codeType = @"Q3";
        }
        ListenViewController *listenVC = [[ListenViewController alloc]init];
         self.user.personNumber =[NSString stringWithFormat:@"%@%@",codeType,[dic[@"code"] substringFromIndex:1]] ;
        
        self.user.callMeinfo = [NSString stringWithFormat:@"预计%ld分钟到我,前方%ld人等待",(long)waitTime,(long)self.selectIndex];
        [self.navigationController pushViewController:listenVC animated:YES];
//        [self.delegate alterView:self.view andTitle:@"您的号码无需开启到号提醒业务，\n已经到你办理" isGround:YES];
//        [self.delegate hideWithLong:1.7];
        return;
    
    }
//    else if(self.selectIndex == 1){
//        
//        ResultInfoViewController *result = [[ResultInfoViewController alloc]init];
//        
//        NSString *codeType;
//        if ([queue.codeType isEqualToString:@"J"]) {
//            codeType = @"J2";
//        }else if ([queue.codeType isEqualToString:@"W"]){
//            
//            codeType = @"W1";
//            
//        }else if ([queue.codeType isEqualToString:@"Q"]){
//            
//            codeType = @"Q3";
//        }
//        self.user.personNumber =[NSString stringWithFormat:@"%@%@",codeType,[dic[@"code"] substringFromIndex:1]] ;
//        self.user.callMeinfo = [NSString stringWithFormat:@"预计%ld分钟到我,前方%ld人等待,\n未开启电话叫号",(long)waitTime,(long)self.selectIndex];
//        
//        NSString * requserUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_setSceneListenNum",self.delegate.m_urlPath];
//        
//        NSDictionary *para = @{@"codeType":[codeType substringToIndex:1],@"callNum":dic[@"code"],@"phoneNo":@"15929443992",@"userId":@"100"};
//        
//        [self.loadData requsetWithString:requserUrl isPost:YES andPara:para andComplete:^(id data, BOOL isSuccess) {
//            
//            
//            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//            
////           开启
//            
//            NSLog(@"%@",str);
//            
//        }];
//        self.user.selectIndex = self.selectIndex;
//        [self.navigationController pushViewController:result animated:YES];
//     self.user.isOpenPhone = YES;
//    }
    
    else{
    if (queue.codeList.count==0) {
        [self.delegate alterView:self.view andTitle:@"请输入正确的抽号" isGround:YES];
        [self.delegate hideWithLong:1.7];
        return;
    }
    
      SubmitPhoneNumberViewController *submitNumberVC = [[SubmitPhoneNumberViewController alloc]initWithNibName:@"SubmitPhoneNumberViewController" bundle:nil];
    self.user.selectIndex = self.selectIndex;
    
    submitNumberVC.on =self.swiTFI.on;
   
        NSString *codeType;
        if ([queue.codeType isEqualToString:@"J"]) {
            codeType = @"J2";
        }else if ([queue.codeType isEqualToString:@"W"]){
            
            codeType = @"W1";
            
        }else if ([queue.codeType isEqualToString:@"Q"]){
            
            codeType = @"Q3";
        }
     self.user.personNumber =[NSString stringWithFormat:@"%@%@",codeType,[dic[@"code"] substringFromIndex:1]] ;
      submitNumberVC.strNumber  =[NSString stringWithFormat:@"%@%@",codeType,[dic[@"code"] substringFromIndex:1]] ;
    [self.navigationController pushViewController:submitNumberVC animated:YES];
    
    
    
//    self.viewSelect.hidden = NO;
//    self.labMyNumber.text = [NSString stringWithFormat:@"我的抽号：%@",self.labNumber.text];
//    self.labMyOrderInfo.text = [NSString stringWithFormat:@"前方%d人等待，预计%d分钟到您",4,33];
    }
}


//- (IBAction)actionOpenCallMe:(UIButton *)sender {
//    self.viewMyOrderInfo.hidden = NO;
//    
//    
////    self.labMyOrderInfoOnfInfo.text = [NSString stringWithFormat:@"%@\n办理前%@提醒您",self.labMyOrderInfo.text,self.rememberStr];
//}
//
//- (IBAction)actionBack:(UIButton *)sender {
////    self.viewSelect.hidden = YES;
//    
//}
//- (IBAction)actionCloseCallMe:(UIButton *)sender {
//    self.viewMyOrderInfo.hidden = YES;
//}
//
//- (IBAction)actionBackInfo:(UIButton *)sender {
//    
//    self.viewMyOrderInfo.hidden = YES;
//}
@end
