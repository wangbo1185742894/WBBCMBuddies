//
//  ResultInfoViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/19.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultInfoViewController : BaseViewController

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)NSString *strNumber;
@property(nonnull,strong)NSString *strMember;
@property(nonatomic,assign)BOOL on;

@property (weak, nonatomic) IBOutlet UILabel *labMyNumberInfo;

@property (weak, nonatomic) IBOutlet UILabel *labMyOrderInfoOnfInfo;

@property (weak, nonatomic) IBOutlet UISwitch *swiTFI;



- (IBAction)actionCloseCallMe:(UIButton *)sender;

- (IBAction)actionBackInfo:(UIButton *)sender;


@end
