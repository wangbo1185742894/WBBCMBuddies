//
//  DetailViewController.h
//  BCMBuddies
//
//  Created by 王博 on 16/5/27.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BCMDefineFile.h"
@interface DetailViewController : BaseViewController

@property(nonatomic,assign)NSInteger index;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (nonatomic,strong) BCMContent *m_content;
@end
