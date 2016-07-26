//
//  BaseViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadData.h"
#import "AppDelegate.h"
#import "GlobalUser.h"
@interface BaseViewController : UIViewController

-(void)refreshDataArray;
//@property(strong,nonatomic)NSMutableArray *dataArray;
@property(nonatomic,strong)LoadData *loadData;
@property(nonatomic,strong)AppDelegate*wd_delegate;
@property (nonatomic,strong)GlobalUser *user;
@property(nonatomic,strong)NSString*userID;
@property(nonatomic,strong)NSTimer *timer;

-(NSString*)userID;
@end
