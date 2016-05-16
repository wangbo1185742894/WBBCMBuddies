//
//  BCMInvestmentViewController.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/17.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"

@interface BCMInvestmentViewController : BaseViewController
@property (nonatomic,assign) BOOL m_showServer;
@property (nonatomic,strong) NSString *m_urlString;
@property (nonatomic,strong) BCMContent *m_content;
@end
