//  BCMRootViewController.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMRootViewController.h"
#import "BCMDefineFile.h"
#import "BCMNavigationController.h"
#import "GroupViewController.h"
#import "BusinessViewController.h"
#import "BCMPreferentialViewController.h"
#import "CallMeViewController.h"
#import "BCMRecreationViewController.h"
#import "BCMInvestmentViewController.h"
#import "BCMServiceViewController.h"
#import "QueueUpViewController.h"
#import "BankListViewController.h"
#import "LoadData.h"
#import "ModRootVCQueue.h"
#import "SubmitPhoneNumberViewController.h"
#import "ResultInfoViewController.h"
#import "ListenViewController.h"

@interface BCMRootViewController ()<BCMTabBarViewDelegate,BCMSeverViewControllerDelegate>
{
    CGFloat angle;
}
@property (weak, nonatomic) IBOutlet UIButton *loginwifi;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *conItemTopMargin;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *conbottomItemMaigin;
@property (weak, nonatomic) IBOutlet UILabel *labMySelectNumber;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *conItemMarginH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTopviewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conMidViewHeight;
@property (weak, nonatomic) IBOutlet UIButton *btnRefresh;
- (IBAction)actionRefresh:(UIButton *)sender;
// 排队信息
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankNameLabWidth;
@property (weak, nonatomic) IBOutlet UIView *viewQueueInfo;
@property (weak, nonatomic) IBOutlet UILabel *labPersonQueue;
@property (weak, nonatomic) IBOutlet UILabel *labPublicQueue;
@property (weak, nonatomic) IBOutlet UILabel *labVipQueue;
@property (weak, nonatomic) IBOutlet UIImageView *imgRefresh;

//个人等候信息
@property (weak, nonatomic) IBOutlet UIView *viewTime;

@property (weak, nonatomic) IBOutlet UIView *viewPerson;
@property (weak, nonatomic) IBOutlet UILabel *labPersoninfo;

@property (weak, nonatomic) IBOutlet UIView *midView;

- (IBAction)actionTopVC:(UIButton *)sender;
- (IBAction)actionButtomVC:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet WBButton *changBank;

@property (weak, nonatomic) IBOutlet UILabel *labBackName;
@property (weak, nonatomic) IBOutlet UILabel *labCityName;
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;

@property(nonatomic,strong)UIButton *cover;

@property(nonatomic,assign)CGPoint lastPoint;
@property(nonatomic,assign)CGPoint firstPoint;

//@property(nonatomic,strong)NSMutableArray  *dataArray;



@end

@implementation BCMRootViewController


@synthesize m_tabBarView;
@synthesize m_homeViewController;
@synthesize m_severViewController;
@synthesize m_mySelfViewController;

- (void)setupViewControllers
{
//    self.tabBar.hidden = YES;
   

  
    self.m_homeViewController = [[BCMHomeViewController alloc] initWithNibName:@"BCMHomeViewController" bundle:nil];
    
    self.m_severViewController = [[BCMSeverViewController alloc] initWithNibName:@"BCMSeverViewController" bundle:nil];
    self.m_severViewController.m_delegate = self;
    UIViewController *wd_severViewController = [[UIViewController alloc] initWithNibName:@"BCMSeverViewController" bundle:nil];
    self.m_mySelfViewController = [[BCMMySelfViewController alloc] initWithNibName:@"BCMMySelfViewController" bundle:nil];
    
    BCMNavigationController *wd_homeNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_homeViewController];
    [wd_homeNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_homeNavigationController setToolbarHidden:YES animated:NO];

    BCMNavigationController *wd_severNavigationController = [[BCMNavigationController alloc] initWithRootViewController:wd_severViewController];
    [wd_severNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_severNavigationController setToolbarHidden:YES animated:NO];

    BCMNavigationController *wd_mySelfNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_mySelfViewController];
    [wd_mySelfNavigationController setNavigationBarHidden:YES animated:NO];
    [wd_mySelfNavigationController setToolbarHidden:YES animated:NO];

   
//    self.viewControllers = [NSArray arrayWithObjects:wd_homeNavigationController,wd_severNavigationController,wd_mySelfNavigationController,nil];
}

-(void)actionChangeBank{

    BankListViewController *bankListVC= [[BankListViewController alloc]init];
    bankListVC.title = @"网点切换";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:bankListVC animated:YES];
}


-(void)refreshDataArray{

    [super refreshDataArray];
    [self refreshQueueInfo];
//    [self.wd_delegate initURLPath:[self.wd_delegate isTIFServerInfo]?@"YES":@"NO"];
//    NSString *strUrl;
//    if ([self.wd_delegate.m_isTFI isEqualToString:@"YES"]) {
//        strUrl = [NSString stringWithFormat:@"%@%@/QueuingReminder/serv_getCounterType?userId=100",self.wd_delegate.m_urlPath,self.wd_delegate.m_appId];
//    }else{
//      strUrl = [NSString stringWithFormat:@"%@/QueuingReminder/serv_getCounterType?userId=100",self.wd_delegate.m_urlPath];
//    
//    }
//    self.dataArray = [[NSMutableArray alloc]init];
//    
//    
//    NSDictionary *para = @{@"userId":@"100"};
//        
//    [self.loadData requsetWithString:strUrl isPost:NO andPara:para andComplete:^(id data, BOOL isSuccess) {
//        ModRootVCQueue *queue = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"J",@"preServiceTime":@"0",@"counterList":@[]}];
//        ModRootVCQueue *queue1 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"Q",@"preServiceTime":@"0",@"counterList":@[]}];
//        ModRootVCQueue *queue2 = [[ModRootVCQueue alloc]initWithDic:@{@"codeList":@[],@"codeType":@"W",@"preServiceTime":@"0",@"counterList":@[]}];
//        [self.dataArray addObjectsFromArray:@[queue,queue1,queue2]];
//        
//        if (isSuccess) {
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            NSDictionary *dic1;
//            if ([self.wd_delegate.m_isTFI isEqualToString:@"YES"]) {
//                dic1= dic;
//                
//            }else{
//            dic1 = dic[@"data"];
//            }
//            NSString *result = [NSString stringWithFormat:@"%@",dic[@"status"]];
//            if (![result isEqualToString:@"0"]) {
////                self.viewTime.hidden = YES;
//                NSArray *array = [dic1 objectForKey:@"counterTypeModelList"];
//                for (NSDictionary *dic in array) {
//                    ModRootVCQueue *queue = [[ModRootVCQueue alloc]initWithDic:dic];
//                    
//                    if ([queue.codeType isEqualToString:@"J"]) {
//                        
//                        [self.dataArray replaceObjectAtIndex:0 withObject:queue];
//                    }else if([queue.codeType isEqualToString:@"Q"]){
//                    
//                        [self.dataArray replaceObjectAtIndex:1 withObject:queue];
//                    }else if ([queue.codeType isEqualToString:@"W"]){
//                    [self.dataArray replaceObjectAtIndex:2 withObject:queue];
//                    
//                    }
//                    
//                }
//                
//                [self.dataArray sortUsingComparator:^NSComparisonResult(ModRootVCQueue *obj1,ModRootVCQueue* obj2) {
//                    
//                    return [obj1.codeType localizedCompare:obj2.codeType];
//                }];
//
//                
////                for (int i = 0 ; i<3; i++) {
////                    ModRootVCQueue *quque = self.dataArray[i];
////                    NSLog(@"%@",quque.codeType);
////                }
//                
//            }
//            
//            
//            self.user.dataArray = self.dataArray;
//        }
//    }];
}

-(void)refreshQueueInfo{

    
    for (ModRootVCQueue  * queue in self.user.dataArray) {
        if ([queue .codeType isEqualToString:@"J"]) {
            
            self.labPersonQueue.text = [NSString stringWithFormat:@"个人业务，共%lu办理，需%@分钟",(unsigned long)queue.codeList.count,queue.preServiceTime];
        }else if ([queue.codeType isEqualToString:@"Q"]){
        self.labPublicQueue.text = [NSString stringWithFormat:@"对公业务，共%lu办理，需%@分钟",(unsigned long)queue.codeList.count,queue.preServiceTime];
        
        }else if ([queue .codeType isEqualToString:@"W"]){
        self.labVipQueue.text = [NSString stringWithFormat:@"贵宾业务，共%lu办理，需%@分钟",(unsigned long)queue.codeList.count,queue.preServiceTime];
        
        }
    }
    
    if ([self.user.callMeinfo isEqualToString:@""]||self.user.callMeinfo!=nil) {
        NSInteger index = 0;
        NSString *type =  [self.user.personNumber substringToIndex:1];
        if ([type isEqualToString:@"J"]) {
            index = 0;
        }
        if ([type isEqualToString:@"Q"]) {
            index = 1;
        }
        if ([type isEqualToString:@"W"]) {
            index = 2;
        }
        NSDictionary*tempDic;
        NSDictionary *temtDicIng;
        ModRootVCQueue*queue = self.user.dataArray[index];
        
        int i=0;
        for (;i<queue.codeList.count;i++) {
            
            NSDictionary *dic = queue.codeList[i];
            NSInteger number = [[self.user.personNumber substringFromIndex:2] integerValue];
            
            if ([dic[@"code"] integerValue] == number) {
                tempDic = dic;
                break;
            }
        }
        
        int j = 0;
        for (;j<queue.counterList.count;j++) {
            
            NSDictionary *dic = queue.counterList[j];
            NSInteger number = [[self.user.personNumber substringFromIndex:2] integerValue];
            
            if ([dic[@"currHandleCode"] integerValue] == number) {
                temtDicIng = dic;
                break;
            }
        }
        
        
        if (tempDic == nil||temtDicIng!=nil) {
            //                清空电话叫号信息
            self.viewQueueInfo.hidden = NO;
            self.viewPerson.hidden = YES;
            self.user.isOpenPhone = NO;
            self.user.strRemmber = nil;
            self.user.personNumber = nil;
            self.user.callMeinfo = nil;
        }else{
        
        NSString * queueInfo = [[self.user.callMeinfo componentsSeparatedByString:@",\n"] lastObject];
        self.user.selectIndex = i;
        self.labMySelectNumber.text = [NSString stringWithFormat:@"我的抽号：%@",self.user.personNumber];
        if ([self.user.strRemmber integerValue]<[tempDic[@"waitTime"] integerValue]) {
                self.user.callMeinfo = [NSString stringWithFormat:@"预计%@分钟到我,前方%d人等待,\n%@",tempDic[@"waitTime"],i,queueInfo];
        }else{
        
                self.user.callMeinfo = [NSString stringWithFormat:@"预计%@分钟到我,前方%d人等待,\n%@",tempDic[@"waitTime"],i,queueInfo];
        }
    
         self.labPersoninfo.text  = self.user.callMeinfo;
        }
    }

}

-(void)addRight{


    
    [self.btnMenu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}
- (IBAction)actionLookPersonQueueInfo:(UIButton *)sender {
    
    NSString *info = [[self.user.callMeinfo componentsSeparatedByString:@",\n"] lastObject];
    if (self.user.isOpenPhone) {
        ResultInfoViewController *resultVC = [[ResultInfoViewController alloc]init];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:resultVC animated:YES];
    }else if([info isEqualToString:@"未开启现场听号"]){
    
        ListenViewController *resultVC = [[ListenViewController alloc]init];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:resultVC animated:YES];
    }else{
    
        SubmitPhoneNumberViewController*submitVC = [[SubmitPhoneNumberViewController alloc]init];
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:submitVC animated:YES];
    
    }
    
    
}

-(void)click{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = CGRectMake(230, 0, self.view.frame.size.width, self.view.bounds.size.height);
    }completion:^(BOOL finished) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(converClick) forControlEvents:UIControlEventTouchUpInside];
        self.cover = button;
        
        UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
        //设置轻扫的方向
            swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
        [_btnMenu addGestureRecognizer:swipeGestureLeft];
        button.frame = CGRectMake(230, 0, self.view.frame.size.width, self.view.bounds.size.height);
        
        [self.navigationController.view.superview addSubview:button];
    }];
}
-(void)converClick{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = [UIScreen mainScreen].bounds;
    } completion:^(BOOL finished) {
        [self.cover removeFromSuperview];
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.wd_delegate.m_appId = @"8830609";
    self.wd_delegate.m_deptId = @"1782";
    self.view.backgroundColor = [UIColor whiteColor];
    self.user = [GlobalUser globalUser];

    [self refreshDataArray];
    [self.loginwifi addTarget:self action:@selector(connectWifi) forControlEvents:UIControlEventTouchUpInside];
    
//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(actionPanGes:)];
//    [self.view addGestureRecognizer:panGesture];
//   

    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    //设置轻扫的方向
//    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft; //默认向右
    [self.view addGestureRecognizer:swipeGestureLeft];

     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(converClick) name:@"rootViewMoveLeft" object:nil];
    self.loadData = [LoadData singleLoadData];
    self.wd_delegate = [UIApplication sharedApplication].delegate;
    self.viewPerson.hidden = YES;
    self.viewQueueInfo.hidden = YES;
    self.viewTime.hidden = YES;
    [self addRight];
        [self.changBank addTarget:self action:@selector(actionChangeBank) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnMoveToqueue addTarget:self action:@selector(actionMoveToQueue) forControlEvents:UIControlEventTouchUpInside];
    
    self.bankNameLabWidth.constant = self.labBackName.text.length *18;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
  
//    if ([defaults objectForKey:@"personNumber"]) {
//        
//        self.user.personNumber = [defaults objectForKey:@"personNumber"];
//        
//    }
//    
//    if ([defaults objectForKey:@"callMeinfo"]) {
//        
//        self.user.callMeinfo =[defaults objectForKey:@"callMeinfo"];
//    }
//    
//    if ([defaults objectForKey:@"isOpenPhone"]) {
//        
//        self.user.isOpenPhone =[[defaults objectForKey:@"isOpenPhone"] boolValue];
//    }
    
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"HH:mm"];
    NSDate *curDate = [NSDate date];
    NSString *dateStr = [forMatter stringFromDate:curDate];
    NSArray *timeArray = [dateStr componentsSeparatedByString:@":"];
    if (self.user.callMeinfo != nil && ![self.user.callMeinfo isEqualToString:@""]) {
        self.viewPerson.hidden = NO;
        
        
        self.labPersoninfo.text  = self.user.callMeinfo;
    }else if([timeArray[0] integerValue]<8|| [timeArray[0] integerValue]>17){
        

        self.viewTime.hidden = NO;
    
    
    }else {
    
        self.viewQueueInfo.hidden = NO;
    
    }
    
    if (MainHeight == 568) {
        
        self.conTopviewHeight.constant = 250;
        self.conMidViewHeight.constant = 100;
        for (NSLayoutConstraint *con in self.conItemMarginH) {
            con.constant = 55;
        }
        for (NSLayoutConstraint *con in self.conItemTopMargin) {
            con.constant = 30;
        }
        
        for (NSLayoutConstraint *con in self.conbottomItemMaigin) {
            con.constant = 25;
        }
        
        
    }else if(MainHeight == 667){
    
        self.conTopviewHeight.constant = 270;
        self.conMidViewHeight.constant = 120;
        for (NSLayoutConstraint *con in self.conItemMarginH) {
            con.constant = 60;
        }
        for (NSLayoutConstraint *con in self.conItemTopMargin) {
            con.constant = 40;
        }
        
        for (NSLayoutConstraint *con in self.conbottomItemMaigin) {
            con.constant = 30;
        }
    }
//    self.tabBar.hidden = YES;
//    [self setupViewControllers];
//    NSArray *mu_viewArray = [[NSBundle mainBundle] loadNibNamed:@"BCMTabBarView" owner:self options:nil];
//    self.m_tabBarView = [mu_viewArray objectAtIndex:0];
//    self.m_tabBarView.frame = CGRectMake(0,SCREENHEIGHT-70,SCREENWIDTH,70);
//    self.m_tabBarView.m_delegate = self;
//    [self.m_tabBarView selectTabAtIndex:0];
//    [self.view addSubview:self.m_tabBarView];
//    self.selectedIndex=0;
}

-(void)swipeGesture:(id)sender
{
    
    UISwipeGestureRecognizer *swipe = sender;
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft)
        
    {
        
       [self converClick];
        
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight)
        
    { 

        
         [self click];
        
    }
}


-(void)actionPanGes:(UIPanGestureRecognizer*)pan{


    
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        _firstPoint=[pan locationInView:self.view];
    }
    if (pan.state == UIGestureRecognizerStateEnded) {
        _lastPoint=[pan locationInView:self.view];
    }
    CGPoint center = pan.view.center;
    
    CGPoint translation = [pan translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    
    if (center.x + translation.x- MainWidth/2<=230&&center.x + translation.x- MainWidth/2>=0) {
        pan.view.center = CGPointMake(center.x + translation.x, center.y);
        [pan setTranslation:CGPointZero inView:self.view];
        
        if (pan.state == UIGestureRecognizerStateEnded) {
            
            if (_lastPoint.x > _firstPoint.x) {
                pan.view.center = CGPointMake(230+MainWidth/2, center.y);
                [pan setTranslation:CGPointZero inView:self.view];
            }else if (_firstPoint.x > _lastPoint.x) {
                pan.view.center = CGPointMake(MainWidth/2, center.y);
                [pan setTranslation:CGPointZero inView:self.view];
            }
        }
    }
}

//
-(void)connectWifi{
  [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.labMySelectNumber.text = [NSString stringWithFormat:@"我的抽号：%@",self.user.personNumber];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.viewPerson.hidden = YES;
    self.viewQueueInfo.hidden = YES;
    self.viewTime.hidden = YES;
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"HH:mm"];
    NSDate *curDate = [NSDate date];
    NSString *dateStr = [forMatter stringFromDate:curDate];
    NSArray *timeArray = [dateStr componentsSeparatedByString:@":"];
    if (self.user.callMeinfo != nil && ![self.user.callMeinfo isEqualToString:@""]) {
        self.viewPerson.hidden = NO;
        
        if ([self.user.callMeinfo isEqualToString:@""]|| self.user.callMeinfo!=nil) {
            NSInteger index = 0;
            NSString *type =  [self.user.personNumber substringToIndex:1];
            if ([type isEqualToString:@"J"]) {
                index = 0;
            }
            if ([type isEqualToString:@"Q"]) {
                index = 1;
            }
            if ([type isEqualToString:@"W"]) {
                index = 2;
            }
            NSDictionary*tempDic;
            ModRootVCQueue*queue = self.user.dataArray[index];
            
            int i=0;
            for (;i<queue.codeList.count;i++) {
                
                NSDictionary *dic = queue.codeList[i];
                NSInteger number = [[self.user.personNumber substringFromIndex:2] integerValue];
                
                if ([dic[@"code"] integerValue] == number) {
                    tempDic = dic;
                    break;
                }
            }
            if (tempDic == nil) {
//                清空电话叫号信息
                self.viewQueueInfo.hidden = NO;
                self.viewPerson.hidden = YES;
                self.user.isOpenPhone = NO;
                self.user.strRemmber = nil;
                self.user.personNumber = nil;
                self.user.callMeinfo = nil;
            }else{ 
            NSString * queueInfo = [[self.user.callMeinfo componentsSeparatedByString:@",\n"] lastObject];
            self.user.selectIndex = i;
            self.labMySelectNumber.text = [NSString stringWithFormat:@"我的抽号：%@",self.user.personNumber];
            if ([self.user.strRemmber integerValue]<[tempDic[@"waitTime"] integerValue]) {
                self.user.callMeinfo = [NSString stringWithFormat:@"预计%@分钟到我,前方%d人等待,\n%@",tempDic[@"waitTime"],i,queueInfo];
            }else{
                
                self.user.callMeinfo = [NSString stringWithFormat:@"预计%@分钟到我,前方%d人等待,\n%@",tempDic[@"waitTime"],i,@"马上到你，请留意柜台叫号"];
            }
            
            self.labPersoninfo.text  = self.user.callMeinfo;
            }
        }

        
    }else if([timeArray[0] integerValue]<8 || [timeArray[0] integerValue]>17){
        self.viewTime.hidden = NO;
        
        
    }else {
        
        self.viewQueueInfo.hidden = NO;
        
    }
    if (self.user.curBank != nil) {
        self.labBackName.text = self.user.curBank.name;
    }
    self.bankNameLabWidth.constant = self.labBackName.text.length *18;
//    AppDelegate *wd_appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    if([wd_appDelegate isTIFServerInfo])
//    {
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateNormal];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateHighlighted];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"tab_for_tifi_icon.png"] forState:UIControlStateSelected];
//    }
//    else
//    {
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateNormal];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateHighlighted];
//        [self.m_tabBarView.ui_button2 setImage:[UIImage imageNamed:@"no_tifi_sever_icon.png"] forState:UIControlStateSelected];
//    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)actionMoveToQueue{
    QueueUpViewController *queueVC = [[QueueUpViewController alloc]initWithNibName:@"QueueUpViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:queueVC animated:YES];
}

#pragma mark -
#pragma mark MURootTabBarDelegate

//- (void)tabBar:(BCMTabBarView *)tabBar didSelectIndex:(NSInteger)index;
//{
//    if(index == 1)
//    {
//        BCMNavigationController *wd_severNavigationController = [[BCMNavigationController alloc] initWithRootViewController:self.m_severViewController];
//        [wd_severNavigationController setNavigationBarHidden:YES animated:NO];
//        [wd_severNavigationController setToolbarHidden:YES animated:NO];
//        [self presentViewController:wd_severNavigationController animated:YES completion:^(void) {
//        }];
//    }
//    else
//    {
////        self.selectedIndex = index;
//    }
//    self.m_tabBarView.hidden = NO;
//}

//- (void)severViewController:(BCMSeverViewController *)tabBar didSelectIndex:(NSInteger)index
//{
//    [self dismissViewControllerAnimated:YES completion:^(void) {
//    }];
//    if(index != 1)
//    {
//        [self.m_tabBarView selectTabAtIndex:index];
//    }
//    else
//    {
//        [self.m_tabBarView selectTabAtIndex:self.selectedIndex];
//    }
//}
- (IBAction)actionBusiness:(UIButton *)sender {
}

- (IBAction)actionGroup:(UIButton *)sender {
}

- (IBAction)actionPhone:(UIButton *)sender {
}
- (IBAction)actionTopVC:(UIButton *)sender {
    switch (sender.tag) {
        case 1001:
            [self moveToBusinessVC];
            break;
        case 1002:
            [self moveToGroupVC];
            break;
            
        case  1003:
            
            [self moveToCallMe];
            break;
        default:
            break;
    }
}

-(void)moveToCallMe{
    
    NSString *info = [[self.user.callMeinfo componentsSeparatedByString:@",\n"] lastObject];
    if (([self.user.callMeinfo isEqualToString:@""] || self.user.callMeinfo ==nil)&&self.user.isOpenPhone==NO ) {
        CallMeViewController *cellMeVC = [[CallMeViewController alloc]initWithNibName:@"CallMeViewController" bundle:nil];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        
        [self.navigationController pushViewController:cellMeVC animated:YES];
    }else if (self.user.isOpenPhone == YES){
        
        ResultInfoViewController *resultVC = [[ResultInfoViewController alloc]init];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:resultVC animated:YES];
    
        
    
    }else if([info isEqualToString:@"未开启现场听号"]){
        
        ListenViewController *resultVC = [[ListenViewController alloc]init];
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:resultVC animated:YES];
    }else{
        
        SubmitPhoneNumberViewController*submitVC = [[SubmitPhoneNumberViewController alloc]init];
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.navigationController pushViewController:submitVC animated:YES];
    }
   
}

-(void)moveToBusinessVC{

    
    BCMServiceViewController*businessVC = [[BCMServiceViewController alloc]initWithNibName:@"BCMServiceViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.navigationController pushViewController:businessVC animated:YES];

}

-(void)moveToGroupVC{
    
    GroupViewController *groupVC = [[GroupViewController alloc]initWithNibName:@"GroupViewController" bundle:nil];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController pushViewController:groupVC animated:YES];
    
}

- (IBAction)actionButtomVC:(UIButton *)sender {
     BCMPreferentialViewController *wd_preferentialViewController = [[BCMPreferentialViewController alloc] initWithNibName:@"BCMPreferentialViewController" bundle:nil];
    BCMRecreationViewController *wd_recreationViewController = [[BCMRecreationViewController alloc] initWithNibName:@"BCMRecreationViewController" bundle:nil];
    BCMInvestmentViewController *wd_investmentViewController = [[BCMInvestmentViewController alloc] initWithNibName:@"BCMInvestmentViewController" bundle:nil];
    QueueUpViewController *queueVC = [[QueueUpViewController alloc]initWithNibName:@"QueueUpViewController" bundle:nil];
    switch (sender.tag) {
        case 2003:
            [self.navigationController pushViewController:wd_preferentialViewController animated:YES];
            break;
        case 2004:
            
            [self.navigationController pushViewController:wd_recreationViewController animated:YES];
            break;
        case 2002:
            
            [self.navigationController pushViewController:wd_investmentViewController animated:YES];
            break;
        case 2001:
            
            [self.navigationController setNavigationBarHidden:NO animated:NO];
            [self.navigationController pushViewController:queueVC animated:YES];
            break;
        default:
            break;
    }
}
- (IBAction)actionRefresh:(UIButton *)sender {
    angle = 0;
    [self refreshDataArray];
    [self startAnimation];
    
}
-(void) startAnimation
{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.0001];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.imgRefresh.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView commitAnimations];
}

-(void)endAnimation
{
    angle += 20;
    if (angle <360 *5) {
        [self startAnimation];
    }else {
        [self.wd_delegate alterView:self.view andTitle:@"刷新成功" isGround:NO];
        [self.wd_delegate hideWithLong:1.7];
    
    }
    
}
@end
