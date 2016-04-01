//
//  BCMTabBarView.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMTabBarView.h"
#import "BCMDefineFile.h"

@implementation BCMTabBarView

@synthesize m_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self selectTabAtIndex:1];
}

- (void)selectTabAtIndex:(NSInteger)index;
{
    self.ui_label1.textColor = RGBA(72.0,72.0,72.0,1.0);
    self.ui_label2.textColor = RGBA(72.0,72.0,72.0,1.0);
    self.ui_label3.textColor = RGBA(72.0,72.0,72.0,1.0);
    self.ui_button1.selected = NO;
    self.ui_button2.selected = NO;
    self.ui_button3.selected = NO;
    switch (index) {
        case 0:
            self.ui_button1.selected = YES;
            self.ui_label1.textColor = RGBA(43.0,110.0,203.0,1.0);
            break;
        case 1:
            self.ui_button2.selected = YES;
            self.ui_label2.textColor = RGBA(43.0,110.0,203.0,1.0);
            break;
        case 2:
            self.ui_button3.selected = YES;
            self.ui_label3.textColor = RGBA(43.0,110.0,203.0,1.0);
            break;
        default:
            break;
    }
    if ([self.m_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
    {
        [self.m_delegate tabBar:self didSelectIndex:index];
    }
}
- (IBAction)tabBarButtonClicked:(id)sender{
    
    UIButton *mu_button = (UIButton *)sender;
    [self selectTabAtIndex:mu_button.tag];
}
@end
