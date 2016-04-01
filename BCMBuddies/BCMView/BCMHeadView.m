//
//  BCMHeadView.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/25.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMHeadView.h"
#import "BCMDefineFile.h"

@implementation BCMHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.m_scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.m_scrollView.showsHorizontalScrollIndicator = NO;
    self.m_scrollView.showsVerticalScrollIndicator = NO;
    self.m_selectedIndex = -1;
    [self addSubview:self.m_scrollView];
}
- (void)deSelectViewCell:(int)index
{
    for(int i = 0;i < self.m_count;i++)
    {
        UIButton *wd_button = (UIButton *)[self.m_scrollView viewWithTag:200 +i];
        UILabel *wd_label = (UILabel *)[self.m_scrollView viewWithTag:100 + i];
        if(index == i)
        {
            wd_button.selected = YES;
            wd_label.hidden = NO;
        }
        else
        {
            wd_button.selected = NO;
            wd_label.hidden = YES;
        }
    }
}
- (void)initViewWithTitleArray:(NSArray *)titleArray selected:(int)selectedIndex
{
    CGSize wd_size = self.frame.size;
    self.m_count = (int)titleArray.count;
    if(self.m_count > 0)
    {
        if(titleArray.count >= 5)
        {
            wd_size = CGSizeMake(wd_size.width/5,wd_size.height);
        }
        else
        {
            wd_size = CGSizeMake(wd_size.width/self.m_count,wd_size.height);
        }
    }
    self.m_scrollView.contentSize = CGSizeMake(wd_size.width * self.m_count,wd_size.height);
    for(int i = 0;i < self.m_count;i++)
    {
        BCMFolder *wd_folderInfo = [titleArray objectAtIndex:i];
        UIButton *wd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        wd_button.tag = 200+i;
        wd_button.frame = CGRectMake(i * wd_size.width,0,wd_size.width,wd_size.height);
        [wd_button setTitleColor:RGBA(72,72,72,1.0) forState:UIControlStateNormal];
        [wd_button setTitleColor:RGBA(27,120,216,1.0) forState:UIControlStateHighlighted];
        [wd_button setTitleColor:RGBA(27,120,216,1.0) forState:UIControlStateSelected];
        [wd_button setTitle:wd_folderInfo.name forState:UIControlStateNormal];
        wd_button.titleLabel.font = [UIFont systemFontOfSize: 16.0];
        [wd_button addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.m_scrollView addSubview:wd_button];
        UILabel *wd_label = [[UILabel alloc] initWithFrame:CGRectMake(i * wd_size.width,wd_size.height - 3,wd_size.width,2)];
        wd_label.tag = 100+i;
        wd_label.backgroundColor = RGBA(24,96,207,1.0);
        [self.m_scrollView addSubview:wd_label];
        if(i == selectedIndex)
        {
            self.m_selectedIndex = selectedIndex;
            wd_button.selected = YES;
            wd_label.hidden = NO;
        }
        else
        {
            wd_button.selected = NO;
            wd_label.hidden = YES;
        }
    }
    
}
- (IBAction)tabBarButtonClicked:(id)sender{
    UIButton *mu_button = (UIButton *)sender;
    if(self.m_selectedIndex == mu_button.tag - 200)
    {
        return;
    }
    [self deSelectViewCell:(int)mu_button.tag - 200];
    self.m_selectedIndex = (int)mu_button.tag - 200;
    [self.m_delegate headViewSelected:self didSelectIndex:(NSInteger)mu_button.tag - 200];
}

@end
