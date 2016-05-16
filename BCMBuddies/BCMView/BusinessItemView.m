//
//  BusinessItemView.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/11.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BusinessItemView.h"
#import "BCMDefineFile.h"

@implementation BusinessItemView
-(id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        self.btnBackclick = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backgroundColor = [UIColor whiteColor];
        self.btnBackclick.frame = frame;
        [self addSubview:self.btnBackclick];
        [self.btnBackclick addTarget:self action:@selector(acitionItemClick:) forControlEvents:UIControlEventTouchUpInside];
        self.imgIcon = [[UIImageView alloc]initWithFrame:CGRectMake(8, 8, frame.size.width - 16, frame.size.height - 38)];
        [self addSubview:self.imgIcon];
        
        self.labTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imgIcon.frame.size.height + self.imgIcon.frame.origin.y, frame.size.width, 20)];
        [self addSubview:self.labTitle];
        self.labTitle.font = [UIFont systemFontOfSize:14];
        self.labTitle.textColor = RGBA(72, 72, 72, 1.0);
        
        self.labTitle.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


- (void)acitionItemClick:(UIButton *)sender {
    
    [self.delegate itemClick:sender];
    
}
@end
