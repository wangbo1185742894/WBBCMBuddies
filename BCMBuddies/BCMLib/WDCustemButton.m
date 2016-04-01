//
//  WDCustemButton.m
//  WeDance
//
//  Created by luzhixing on 15-18-10.
//  Copyright (c) 2015年 luzhixing. All rights reserved.
//

#import "WDCustemButton.h"

@implementation WDCustemButton

@synthesize m_index;
@synthesize m_sesion;
@synthesize m_class;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_index = 0;
        self.m_sesion = 0;
        self.m_class = 0;
    }
    return self;
}

@end
