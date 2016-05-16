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

@interface CallMeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak,nonatomic)AppDelegate *delegate;
@property (nonatomic,assign)NSInteger strQueueType;

@property (nonatomic,assign)NSInteger orderNumber;
@property (nonatomic,strong)NSString *rememberStr;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnsTime;
@property (nonatomic,strong)NSArray *items;
@end

@implementation CallMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"电话叫我";
    self.items = @[@"J",@"Q",@"W"];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.orderNumber = 26;
    self.rememberStr = @"10分钟";
    for (UIButton *button in _btnsTime) {
    
        [self setBackColor:button];
        if ([button.currentTitle isEqualToString:self.rememberStr]) {
            button.selected = YES;
        }
    
    }
    self.strQueueType = 0;
    self.segSelectQueue.selectedSegmentIndex = self.strQueueType;
    [self.swiTFI setOn:NO];
    self.viewMyOrderInfo.hidden = YES;
    self.viewSelect.hidden = YES;
//    self.btnSure.enabled = [self.delegate isTIFServerInfo];
    self.labNumber.text = [NSString stringWithFormat:@"%@%04ld",self.items[self.strQueueType],(long)self.orderNumber];
    if ([self.delegate isTIFServerInfo]) {
        self.labPleaseOrder.text = @"输入排队号码";
        
    }else{
    
        self.labPleaseOrder.text = @"请链接TFI网络开启电话叫我";
    }
    
    [self.segSelectQueue addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)setBackColor:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageWithColor:RGBA(27, 120, 216, 1.0)] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateHighlighted];

}

-(void)segmentChange:(UISegmentedControl*)seg{
    self.strQueueType = seg.selectedSegmentIndex;
    NSString *str = [self.labNumber.text substringWithRange:NSMakeRange(1, self.labNumber.text.length-1)];
    NSInteger number =[str integerValue];
    
    self.labNumber.text = [NSString stringWithFormat:@"%@%04ld",self.items[seg.selectedSegmentIndex],(long)number];

}

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

- (IBAction)actionAddNumber:(UIButton *)sender {
    NSString *str = [self.labNumber.text substringWithRange:NSMakeRange(1, self.labNumber.text.length - 1)];
    
    NSInteger number =[str integerValue];
    
    self.labNumber.text = [NSString stringWithFormat:@"%@%04ld",self.items[self.segSelectQueue.selectedSegmentIndex],(long)--number];
}

- (IBAction)actionSubNumber:(UIButton *)sender {
    NSString *str = [self.labNumber.text substringWithRange:NSMakeRange(1, self.labNumber.text.length - 1)];
    
    NSInteger number =[str integerValue];
    self.labNumber.text = [NSString stringWithFormat:@"%@%04ld",self.items[self.segSelectQueue.selectedSegmentIndex],(long)++number];
}

- (IBAction)actionSubmit:(UIButton *)sender {
    
    self.viewSelect.hidden = NO;
    self.labMyNumber.text = [NSString stringWithFormat:@"我的抽号：%@",self.labNumber.text];
    self.labMyOrderInfo.text = [NSString stringWithFormat:@"前方%d人等待，预计%d分钟到您",4,33];
}
- (IBAction)actionSelectTime:(UIButton *)sender {
    
    for (UIButton  *button in self.btnsTime) {
        [button setSelected:NO] ;
    }
    self.rememberStr = sender.currentTitle;
    [sender setSelected:YES];
}

- (IBAction)actionOpenCallMe:(UIButton *)sender {
    self.viewMyOrderInfo.hidden = NO;
    self.labMyNumberInfo.text = self.labMyNumber.text;
    
    self.labMyOrderInfoOnfInfo.text = [NSString stringWithFormat:@"%@\n办理前%@提醒您",self.labMyOrderInfo.text,self.rememberStr];
}

- (IBAction)actionBack:(UIButton *)sender {
    self.viewSelect.hidden = YES;
    
}
- (IBAction)actionCloseCallMe:(UIButton *)sender {
    self.viewMyOrderInfo.hidden = YES;
}

- (IBAction)actionBackInfo:(UIButton *)sender {
    
    self.viewMyOrderInfo.hidden = YES;
}
@end
