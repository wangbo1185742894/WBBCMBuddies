//
//  QueueListHeaderView.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueueListHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgClassQueue;
@property (weak, nonatomic) IBOutlet UILabel *labSerName;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *labQueueInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnDir;
@property (strong,nonatomic)NSString*isOpen;
@property (weak, nonatomic) IBOutlet UIButton *btnQueueIsBusy;




@end
