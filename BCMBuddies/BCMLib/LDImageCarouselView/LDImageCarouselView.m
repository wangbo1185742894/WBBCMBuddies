//
//  LDImageCarouselView.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "LDImageCarouselView.h"

#define kStartTag   1000
#define kDefaultScrollInterval  3

@interface LDImageCarouselView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *m_scrollView;
@property (nonatomic, assign) NSInteger m_count;
@property (nonatomic, strong) NSTimer *m_autoScrollTimer;
@property (nonatomic, strong) UIPageControl *m_pageControl;
@property (nonatomic, strong) NSMutableArray *m_pageControlConstraints;
@property (nonatomic, assign) int m_iselectIndex;
@end

@implementation LDImageCarouselView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init
{
}
//
//- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<LDImageCarouselViewDelegate>)delegate
//{
//    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:UIEdgeInsetsZero];
//}
//
//- (void)initWithImageURLs:(NSArray *)imageURLs placeholder:(UIImage *)placeholder delegate:(id<LDImageCarouselViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
//{
//    [self initWithCount:imageURLs.count delegate:delegate edgeInsets:edgeInsets];
//}
//
- (void)removeImageCarouseView
{
    if(self.m_count == 0)
    {
        return;
    }
    for (int i = kStartTag; i < kStartTag + self.m_count + 2; i++) {
        LDImageView *imageView = (LDImageView *)[self.m_scrollView viewWithTag:i];
        [imageView removeFromSuperview];
    }
    self.m_scrollView = nil;
    self.m_pageControl = nil;
}
- (void)initWithCount:(NSInteger)count delegate:(id<LDImageCarouselViewDelegate>)delegate
{
    self.scrollInterval = kDefaultScrollInterval;
    self.m_scrollView = [[UIScrollView alloc] init];
    self.m_scrollView.pagingEnabled = YES;
    //    self.m_scrollView.bounces = NO;
    //    self.m_scrollView.scrollsToTop = NO;
    self.m_scrollView.showsHorizontalScrollIndicator = NO;
    self.m_scrollView.showsVerticalScrollIndicator = NO;
    self.m_scrollView.delegate = self;
    if(count <= 1)
    {
        self.m_scrollView.scrollEnabled = NO;
    }
    else
    {
        self.m_scrollView.scrollEnabled = YES;
    }
    self.m_scrollView.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height + self.m_isOpen);
    [self addSubview:self.m_scrollView];

    // UIPageControl
    self.m_pageControl = [[UIPageControl alloc] init];
    self.m_pageControl.numberOfPages = self.m_count;
    self.m_pageControl.currentPage = 0;
    self.m_pageControl.frame = CGRectMake((self.frame.size.width - 80)/2.0,self.frame.size.height - 30 + self.m_isOpen,80, 20);
    [self addSubview:self.m_pageControl];
    [self initWithCount:count delegate:delegate edgeInsets:UIEdgeInsetsZero];
    
    
}

- (void)initWithCount:(NSInteger)count delegate:(id<LDImageCarouselViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets
{
    self.delegate = delegate;
    self.m_count = count;
    if (count == 0) {
        return;
    }
    self.m_pageControl.numberOfPages = count;
    self.m_pageControl.currentPage = 0;
    CGFloat startX = self.m_scrollView.bounds.origin.x;
    CGFloat width = self.m_scrollView.bounds.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat height = self.m_scrollView.bounds.size.height - edgeInsets.top - edgeInsets.bottom;
//    if((int)count == 1)
//    {
//        self.m_scrollView.contentSize = CGSizeMake(width, height);
//        self.m_scrollView.contentInset = UIEdgeInsetsZero;
//        startX = 0;
//        LDImageView *imageView = [[LDImageView alloc] initWithFrame:CGRectMake(startX, 0, width, height)];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        imageView.tag = kStartTag;
//        imageView.userInteractionEnabled = YES;
//        imageView.translatesAutoresizingMaskIntoConstraints = NO;
//        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
//        
//        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width]];
//        [imageView addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:height]];
//        [self.delegate imageCarouselView:self loadImageForImageView:imageView index:0];
//        [self.m_scrollView addSubview:imageView];
//    }
//    else
//    {
        self.m_scrollView.contentSize = CGSizeMake(width * (self.m_count + 2),height);
        self.m_scrollView.contentInset = UIEdgeInsetsZero;
        for (int i = 0; i < (self.m_count + 2); i++) {
            startX = i * width;
            LDImageView *imageView = [[LDImageView alloc] initWithFrame:CGRectMake(startX, 0, width, height)];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.tag = kStartTag + i;
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)]];
            int mu_index = i - 1;
            if(i == 0)
            {
                mu_index = (int)self.m_count - 1;
            }
            if(i == self.m_count + 1)
            {
                mu_index = 0;
            }
            [self.delegate imageCarouselView:self loadImageForImageView:imageView index:mu_index];
//            imageView.frame = CGRectMake(i * self.bounds.size.width,0,self.frame.size.width, height);
            [self.m_scrollView addSubview:imageView];
        }
//    }
    
    NSMutableDictionary *viewsDictionary = [NSMutableDictionary dictionary];
    NSMutableArray *imageViewNames = [NSMutableArray array];
//    if((int)count == 1)
//    {
//        NSString *imageViewName = [NSString stringWithFormat:@"imageView%d",0];
//        [imageViewNames addObject:imageViewName];
//        LDImageView *imageView = (LDImageView *)[self.m_scrollView viewWithTag:0];
//        [viewsDictionary setObject:imageView forKey:imageViewName];
//    }
//    else
//    {
        for (int i = kStartTag; i < kStartTag + count + 2; i++) {
            NSString *imageViewName = [NSString stringWithFormat:@"imageView%d", i - kStartTag];
            [imageViewNames addObject:imageViewName];
            LDImageView *imageView = (LDImageView *)[self.m_scrollView viewWithTag:i];
            [viewsDictionary setObject:imageView forKey:imageViewName];
        }
//    }
    [self.m_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
//    if((int)count == 1)
//    {
//        [self.m_scrollView setContentOffset:CGPointMake(0, 0)];
//    }
//    else
    {
    }
}

- (void)handleTapGesture:(UIGestureRecognizer *)tapGesture
{
    LDImageView *imageView = (LDImageView *)tapGesture.view;
    NSInteger index = imageView.tag - kStartTag;
    if(index == 0)
    {
        index = self.m_count;
    }
    if(index == self.m_count + 1)
    {
        index = 1;
    }
    index = index - 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageCarouselView:didTapAtIndex:)]) {
        [self.delegate imageCarouselView:self didTapAtIndex:index];
    }
}

#pragma mark - auto scroll
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    
    if (autoScroll) {
        if (!self.m_autoScrollTimer || !self.m_autoScrollTimer.isValid) {
            self.m_autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
        }
    } else {
        if (self.m_autoScrollTimer && self.m_autoScrollTimer.isValid) {
            [self.m_autoScrollTimer invalidate];
            self.m_autoScrollTimer = nil;
        }
    }
}

- (void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval = scrollInterval;
    
    if (self.m_autoScrollTimer && self.m_autoScrollTimer.isValid) {
        [self.m_autoScrollTimer invalidate];
        self.m_autoScrollTimer = nil;
    }
    self.m_autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:NO];
}

- (void)handleScrollTimer:(NSTimer *)timer
{
    if (self.m_count <= 1) {
        return;
    }
    NSInteger currentPage = self.m_pageControl.currentPage;
    NSInteger nextPage = currentPage + 1;
    self.m_iselectIndex = (int)currentPage + 2;
    
    BOOL animated = YES;
    if (nextPage == 0) {
        animated = NO;
    }
    LDImageView *imageView = (LDImageView *)[self.m_scrollView viewWithTag:(self.m_iselectIndex + kStartTag)];
    [self.m_scrollView scrollRectToVisible:imageView.frame animated:YES];
    if (nextPage == self.m_count) {
        nextPage = 0;
    }
    self.m_pageControl.currentPage = nextPage;
}

#pragma mark - scroll delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.m_count <= 1) {
        return;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.m_count <= 1) {
        return;
    }
    CGFloat pageWidth = self.bounds.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.m_pageControl.currentPage = (page-1);
    self.m_iselectIndex = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.m_count <= 1) {
        return;
    }
    if (self.m_autoScrollTimer && self.m_autoScrollTimer.isValid) {
        [self.m_autoScrollTimer invalidate];
    }
    if (self.m_iselectIndex == 0) {
        
        [self.m_scrollView setContentOffset:CGPointMake(self.m_count*self.bounds.size.width, 0)];
    }
    if (self.m_iselectIndex == self.m_count + 1) {
        
        [self.m_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    }
    self.m_autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:NO];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.m_count <= 1) {
        return;
    }
    if (self.m_autoScrollTimer && self.m_autoScrollTimer.isValid) {
        [self.m_autoScrollTimer invalidate];
    }
    if (self.m_iselectIndex == 0) {
        
        [self.m_scrollView setContentOffset:CGPointMake(self.m_count*self.bounds.size.width, 0)];
    }
    if (self.m_iselectIndex == self.m_count + 1) {
        
        [self.m_scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    }
    self.m_autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:NO];
}
//#pragma mark -
//- (void)setPageControlPosition:(LDPageControlPosition)pageControlPosition
//{
//    NSString *vFormat = nil;
//    NSString *hFormat = nil;
//    
//    switch (pageControlPosition) {
//        case LDPageControlPosition_TopLeft: {
//            vFormat = @"V:|-0-[pageControl]";
//            hFormat = @"H:|-[pageControl]";
//            break;
//        }
//            
//        case LDPageControlPosition_TopCenter: {
//            vFormat = @"V:|-0-[pageControl]";
//            hFormat = @"H:|[pageControl]|";
//            break;
//        }
//            
//        case LDPageControlPosition_TopRight: {
//            vFormat = @"V:|-0-[pageControl]";
//            hFormat = @"H:[pageControl]-|";
//            break;
//        }
//            
//        case LDPageControlPosition_BottomLeft: {
//            vFormat = @"V:[pageControl]-0-|";
//            hFormat = @"H:|-[pageControl]";
//            break;
//        }
//            
//        case LDPageControlPosition_BottomCenter: {
//            vFormat = @"V:[pageControl]-0-|";
//            hFormat = @"H:|[pageControl]|";
//            break;
//        }
//            
//        case LDPageControlPosition_BottomRight: {
//            vFormat = @"V:[pageControl]-0-|";
//            hFormat = @"H:[pageControl]-|";
//            break;
//        }
//            
//        default:
//            break;
//    }
//    
//    [self removeConstraints:self.m_pageControlConstraints];
//    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat options:kNilOptions metrics:nil views:@{@"pageControl": self.m_pageControl}];
//    
//    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat options:kNilOptions metrics:nil views:@{@"pageControl": self.m_pageControl}];
//    
//    [self.m_pageControlConstraints removeAllObjects];
//    [self.m_pageControlConstraints addObjectsFromArray:pageControlVConstraints];
//    [self.m_pageControlConstraints addObjectsFromArray:pageControlHConstraints];
//    [self addConstraints:self.m_pageControlConstraints];
//}

- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.m_pageControl.hidden = hidePageControl;
}

@end

