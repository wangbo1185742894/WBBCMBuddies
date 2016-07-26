//
//  QueueViewCell.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/12.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labNoTime;
@property (weak, nonatomic) IBOutlet UILabel *labWindowNumber;
@property (weak, nonatomic) IBOutlet UILabel *labSerName;
@property (weak, nonatomic) IBOutlet UILabel *labSerIng;
@property (weak, nonatomic) IBOutlet UILabel *labNumber;
@property (weak, nonatomic) IBOutlet UILabel *labQueueInfo;

@end
