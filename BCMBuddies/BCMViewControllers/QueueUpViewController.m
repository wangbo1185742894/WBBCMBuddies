//
//  QueueUpViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "QueueUpViewController.h"
#import "QueueListHeaderView.h"
#import "QueueViewCell.h"

#import "ModRootVCQueue.h"

@interface QueueUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labCurQueueUp;
@property (weak, nonatomic) IBOutlet UILabel *labNeedWaite;
@property (weak, nonatomic) IBOutlet UITableView *tabQueueList;
@property (weak, nonatomic) IBOutlet UILabel *labWillQueue;
@property (weak, nonatomic) IBOutlet UILabel *labCurTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conTimeBacktImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgTimeBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constTimeLab;
@property (weak, nonatomic) IBOutlet UIImageView *timeGuaPi;

@property (strong,nonatomic)NSMutableArray *selectArray;
@property(strong,nonatomic)NSMutableArray *timeArray;

@end

@implementation QueueUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabQueueList.delegate = self;
    self.tabQueueList.dataSource = self;
    self.title = @"排队详情";
    
    [self.tabQueueList registerClass:[QueueViewCell class] forCellReuseIdentifier:@"queueViewCell"];
    self.tabQueueList.rowHeight = 65;
    
    [self.tabQueueList reloadData];
    
    self.selectArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"HH:mm"];
    NSDate *curDate = [NSDate date];
    NSString *dateStr = [forMatter stringFromDate:curDate];
   
 
   
    self.timeGuaPi.userInteractionEnabled = YES;
  
    self.timeArray = [[NSMutableArray alloc]initWithArray:@[@"11",@"13",@"16",@"18",@"19",@"12",@"11",@"13",@"12",@"10"]];
    self.labCurTime.text = dateStr;
   NSArray *timeArray = [dateStr componentsSeparatedByString:@":"];
    NSInteger number = [timeArray[0] integerValue];
    NSString *time;
    if (number<8||number>17) {
        time =@"0";
    }else{
        time =self.timeArray[number-8];
    }
    

    self.labNeedWaite.text = [NSString stringWithFormat:@"等待时长：%@分钟",time];
    CGFloat curTimeMM = 0;
    CGFloat totalTimeMM = 8*60;
    CGFloat curTimeMM_totalTimeMM = 0.0;
    
    UIPanGestureRecognizer * panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(timePan:)];
    [self.timeGuaPi addGestureRecognizer:panGesture];
    
    
    if ([timeArray[0] integerValue]>=8&&[timeArray[0] integerValue]<=17) {
        
        if ([timeArray[0] integerValue]==8) {
            if ([timeArray [1] integerValue]>=30) {
                curTimeMM = [timeArray [1] integerValue]-30;
                curTimeMM_totalTimeMM =curTimeMM/totalTimeMM;
                
                
            }else{
            
                curTimeMM_totalTimeMM = 0.0;
            }
        }else if ([timeArray[0] integerValue]==17) {
            if ([timeArray [1] integerValue]<30) {
                curTimeMM = ([timeArray[0] integerValue]- 9)*60 + [timeArray [1] integerValue]+30;
                curTimeMM_totalTimeMM =curTimeMM/totalTimeMM;
            
            }else{
            
                curTimeMM_totalTimeMM = 1.0;
            }
        }else{
            curTimeMM = ([timeArray[0] integerValue]- 9)*60 + [timeArray [1] integerValue]+30;
            curTimeMM_totalTimeMM =curTimeMM/totalTimeMM;
        
        }
    }else if([timeArray[0] integerValue] < 8 || [timeArray[0] integerValue] >17){
    
        
        curTimeMM_totalTimeMM = 1.0;
        
    }else{
    
        curTimeMM = ([timeArray[0] integerValue]- 9)*60 + [timeArray [1] integerValue]+30;
        curTimeMM_totalTimeMM =curTimeMM/totalTimeMM;
    }

    
    self.constTimeLab.constant = (MainWidth - 70)*curTimeMM_totalTimeMM+15;
    self.conTimeBacktImage.constant =self.constTimeLab.constant-18;
    
    
}


-(void)refreshDataArray{

    [super refreshDataArray];
    
    [self.tabQueueList reloadData];

}

-(void)timePan:(UIPanGestureRecognizer *)recognizer{

    CGPoint center = recognizer.view.center;
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));

    
    if (center.x + translation.x>=self.constTimeLab.constant &&center.x + translation.x<=MainWidth-15) {
        recognizer.view.center = CGPointMake(center.x + translation.x, center.y);
        [recognizer setTranslation:CGPointZero inView:self.view];
    }

    NSInteger hourWidth = (MainWidth-30)/9;
    NSInteger number = recognizer.view.center.x/hourWidth;
    NSString *time =self.timeArray[number];
    self.labNeedWaite.text = [NSString stringWithFormat:@"等待时长：%@分钟",time];
//    if (recognizer.state == UIGestureRecognizerStateEnded){
//    
//        
//    
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 60;

}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    QueueListHeaderView *headerView = [[QueueListHeaderView alloc]init];
    NSString*isop = self.selectArray[section];
    
    headerView.btnDir.selected = [isop isEqualToString:@"0"]?NO:YES;
    
    [headerView.btnDir addTarget:self action:@selector(changeOpen:) forControlEvents:UIControlEventTouchUpInside];
    headerView.frame = CGRectMake(0, 0, MainWidth, 60);
    switch (section) {
        case 0:
            for (ModRootVCQueue *queue in self.user.dataArray) {
                if ([queue.codeType isEqualToString:@"J"]) {
                    headerView.labSerName.text = @"个人业务";
//                    for (NSDictionary *dic in queue.codeList) {
//                        time = time + [dic[@"preTime"] integerValue]- [dic[@"useTime"] integerValue];
//                    }
                    headerView.labQueueInfo.text = [NSString stringWithFormat:@"%lu人办理，%lu人等待，共%@分钟",(unsigned long)(queue.counterList.count==0?0:queue.counterList.count),(unsigned long)queue.codeList.count-queue.counterList.count,queue.preServiceTime];
                    headerView.btnDir.tag = 5000;
                    if (queue.codeList.count==0) {
                         headerView.btnQueueIsBusy.selected = NO;
                    }else{
                     headerView.btnQueueIsBusy.selected = YES;
                    
                    }
                   
                    
                    [headerView.btnQueueIsBusy setTitle:@"J" forState:UIControlStateNormal];
                }
            }
            
            break;
        case 1:
            for (ModRootVCQueue *queue in self.user.dataArray) {
                if ([queue.codeType isEqualToString:@"Q"]) {
                    headerView.labSerName.text = @"对公业务";
                    //                    for (NSDictionary *dic in queue.codeList) {
                    //                        time = time + [dic[@"preTime"] integerValue]- [dic[@"useTime"] integerValue];
                    //                    }
                    headerView.labQueueInfo.text = [NSString stringWithFormat:@"%lu人办理，%lu人等待，共%@分钟",(unsigned long)(queue.counterList.count==0?0:queue.counterList.count),(unsigned long)queue.codeList.count-queue.counterList.count,queue.preServiceTime];
                    headerView.btnDir.tag = 5001;
                    if (queue.codeList.count==0) {
                        headerView.btnQueueIsBusy.selected = NO;
                    }else{
                        headerView.btnQueueIsBusy.selected = YES;
                        
                    }
                    
                    
                    [headerView.btnQueueIsBusy setTitle:@"Q" forState:UIControlStateNormal];
                }
            }
            break;
        case 2:
            for (ModRootVCQueue *queue in self.user.dataArray) {
                if ([queue.codeType isEqualToString:@"W"]) {
                    headerView.labSerName.text = @"贵宾业务";
                    //                    for (NSDictionary *dic in queue.codeList) {
                    //                        time = time + [dic[@"preTime"] integerValue]- [dic[@"useTime"] integerValue];
                    //                    }
                    headerView.labQueueInfo.text = [NSString stringWithFormat:@"%lu人办理，%lu人等待，共%@分钟",(unsigned long)(queue.counterList.count==0?0:queue.counterList.count),(unsigned long)queue.codeList.count-queue.counterList.count,queue.preServiceTime];
                    headerView.btnDir.tag = 5002;
                    if (queue.codeList.count==0) {
                        headerView.btnQueueIsBusy.selected = NO;
                    }else{
                        headerView.btnQueueIsBusy.selected = YES;
                        
                    }
                    
                    
                    [headerView.btnQueueIsBusy setTitle:@"W" forState:UIControlStateNormal];
                }
            }
            break;
            
        default:
            break;
    }
    return headerView;
}


-(void)changeOpen:(UIButton *)btn{
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 3)];
    [self.selectArray removeAllObjects];
    
    [self.selectArray insertObjects:@[@"0",@"0",@"0"]  atIndexes:set];
    btn.selected = !btn.selected;
    [self.selectArray removeObjectAtIndex:btn.tag-5000];
    [self .selectArray insertObject:btn.selected== YES?@"1":@"0" atIndex:btn.tag - 5000];
    
    [self.tabQueueList reloadData];

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
//    if (self.dataArray.count == 0)
    return self.user.dataArray.count;

    

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   QueueViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"queueViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labNoTime.hidden = YES;
    ModRootVCQueue *queue =  self.user.dataArray[indexPath.section];
    if (queue.counterList.count== 0 && queue.codeList.count==0) {
//        UILabel *nobody = [[UILabel alloc]initWithFrame:cell.frame];
//        nobody.backgroundColor = RGBA(244, 244, 244, 1.0);
//        nobody.text = @"无需等待";
//        nobody.textAlignment = NSTextAlignmentCenter;
//        nobody.font = [UIFont systemFontOfSize:15];
//        nobody.textColor = RGBA(72, 72, 72, 1.0);
//        [cell addSubview:nobody];
        cell.labNoTime.text = @"无需等待";
        cell.labNoTime.hidden = NO;
        return cell;
    }
    if (queue.counterList.count== 0 && queue.codeList.count!=0) {
        cell.labNoTime.text = @"当前没有专类窗口办理该业务";
        cell.labNoTime.hidden = NO;
        return cell;
    }
   
   
    NSDictionary *dic = queue.counterList[indexPath.row];
        cell.labSerName.text = @"储蓄业务";
        cell.labSerIng.text = @"正在受理";
        cell.labWindowNumber.text = [NSString stringWithFormat:@"%ld号窗口",indexPath.row+1];
    
    
    NSDictionary *dicTemp1 = queue.counterList[indexPath.row];
    
    NSString *codeType;
    if ([queue.codeType isEqualToString:@"J"]) {
        codeType = @"J2";
    }else if ([queue.codeType isEqualToString:@"W"]){
    
        codeType = @"W1";
    
    }else if ([queue.codeType isEqualToString:@"Q"]){
    
        codeType = @"Q3";
    }
    
    
    cell.labNumber.text = [NSString stringWithFormat:@"%@%@",codeType,[dicTemp1[@"currHandleCode"] substringFromIndex:1]];

  NSDictionary *dictemp =  queue.codeList[indexPath.row] ;
    NSString*startTime = dictemp[@"startTime"];
    
    startTime = [[startTime componentsSeparatedByString:@" "] lastObject];
    startTime = [startTime substringToIndex:startTime.length-3];
    
    NSString*preEndTime = dictemp[@"preEndTime"];
    preEndTime = [[preEndTime componentsSeparatedByString:@" "] lastObject];
    preEndTime = [preEndTime substringToIndex:startTime.length];
    
    cell.labQueueInfo.text = [NSString stringWithFormat:@"受理%@，预计结束%@，已办理%@分钟", startTime,preEndTime,dictemp[@"useTime"]];
   
    
    
    
    
    
//    cell.labNumber.text = [NSString stringWithFormat:@"%@%@",queue.codeType,];
    return cell;
    
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.user.dataArray .count != 0) {
       ModRootVCQueue *queue = self.user.dataArray[section];
        if ([self.selectArray[section] isEqualToString:@"0"]) {
           return 0;
        }else if(queue.codeList.count ==0||queue.counterList.count==0){
    
            return 1;
            
        }else{
        return queue.counterList.count;
        }
    }else{
    
        return 0;
    
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

@end
