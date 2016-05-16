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

@interface QueueUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labCurQueueUp;
@property (weak, nonatomic) IBOutlet UITableView *tabQueueList;
@property (weak, nonatomic) IBOutlet UILabel *labWillQueue;
@property (weak, nonatomic) IBOutlet UILabel *labCurTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgTimeBack;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constTimeLab;

@property (strong,nonatomic)NSArray *dataArray;

@property (strong,nonatomic)NSMutableArray *selectArray;

@end

@implementation QueueUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabQueueList.delegate = self;
    self.tabQueueList.dataSource = self;
    
    
    [self.tabQueueList registerClass:[QueueViewCell class] forCellReuseIdentifier:@"queueViewCell"];
    self.tabQueueList.rowHeight = 65;
    
    [self.tabQueueList reloadData];
    self.selectArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",nil];
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"HH:mm"];
    NSDate *curDate = [NSDate date];
    NSString *dateStr = [forMatter stringFromDate:curDate];
   
    
    self.labCurTime.text = dateStr;
   NSArray *timeArray = [dateStr componentsSeparatedByString:@":"];
    CGFloat curTimeMM = 0;
    CGFloat totalTimeMM = 8*60;
    CGFloat curTimeMM_totalTimeMM = 0.0;
    
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

    
    self.constTimeLab.constant = (MainWidth - 50)*curTimeMM_totalTimeMM+15;
    
    
    
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
            headerView.labSerName.text = @"个人业务";
            headerView.labQueueInfo.text = @"当前0人正在柜台办理，0人等待，共0分钟";
            headerView.btnDir.tag = 5000;
            headerView.btnQueueIsBusy.selected = YES;
            
            [headerView.btnQueueIsBusy setTitle:@"J" forState:UIControlStateNormal];
            break;
        case 1:
            headerView.labSerName.text = @"对公业务";
            headerView.labQueueInfo.text = @"当前0人正在柜台办理，0人等待，共0分钟";
            headerView.btnDir.tag = 5001;
            headerView.btnQueueIsBusy.selected = YES;
            [headerView.btnQueueIsBusy setTitle:@"Q" forState:UIControlStateNormal];
            break;
        case 2:
            headerView.labSerName.text = @"贵宾业务";
            headerView.labQueueInfo.text = @"当前0人正在柜台办理，0人等待，共0分钟";
            headerView.btnDir.tag = 5002;
            headerView.btnQueueIsBusy.selected = YES;
            [headerView.btnQueueIsBusy setTitle:@"W" forState:UIControlStateNormal];
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

    
    return 3;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    QueueViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"queueViewCell"];
    cell.labWindowNumber.text  = @"一号窗口";
    cell.labSerName.text = @"储蓄业务";
    cell.labSerIng.text = @"正在受理";
    cell.labNumber.text = @"J0003";
    cell.labQueueInfo.text = @"10:13开始受理，2人等待，共15分钟";
    return cell;
    
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.selectArray[section] isEqualToString:@"0"]) {
        return 0;
    }else{
    
        return 1;
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
