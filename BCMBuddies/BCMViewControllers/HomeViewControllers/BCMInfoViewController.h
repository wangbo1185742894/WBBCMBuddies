//
//  BCMInfoViewController.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/3/3.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"
@interface BCMInfoViewController : UIViewController

@property (nonatomic,assign) BOOL m_showServer;
@property (nonatomic,strong) NSString *m_urlString;
@property (nonatomic,strong) BCMContent *m_content;

@end
