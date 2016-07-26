//
//  OrderListViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/20.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListViewCell.h"

@interface OrderListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabOrderList;
@property(nonatomic,strong)GlobalUser *cUser;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cUser = [GlobalUser globalUser];
    self.title = @"我的预约";
    self.tabOrderList.delegate = self;
    [self.tabOrderList registerClass:[OrderListViewCell class] forCellReuseIdentifier:@"OrderListViewCell"];
    self.tabOrderList.dataSource = self;
    [self.tabOrderList reloadData];
    self.tabOrderList.rowHeight = 90;
    

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (self.cUser.orderDateArray==nil || self.cUser.orderDateArray.count == 0) {
        return 1;
    }
    else{
        return self.cUser.orderDateArray.count;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListViewCell"];
    if (self.cUser.orderDateArray.count==0 || self.cUser.orderDateArray == nil) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MainWidth, 90)];
        lab.textAlignment = NSTextAlignmentCenter;
        
    
        lab.text = @"当前暂无预约";
        [cell addSubview:lab];
        return cell;
    }else{

        OrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderListViewCell"];
        
        [cell reloadData:self.cUser.orderDateArray[indexPath.row]];
        return cell;
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
