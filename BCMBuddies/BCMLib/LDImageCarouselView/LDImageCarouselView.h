//
//  LDImageCarouselView.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LDImageView.h"

typedef NS_ENUM(NSInteger, LDPageControlPosition) {
    LDPageControlPosition_TopLeft,
    LDPageControlPosition_TopCenter,
    LDPageControlPosition_TopRight,
    LDPageControlPosition_BottomLeft,
    LDPageControlPosition_BottomCenter,
    LDPageControlPosition_BottomRight
};

@protocol LDImageCarouselViewDelegate;

@interface LDImageCarouselView : UIView

@property (nonatomic, assign) id<LDImageCarouselViewDelegate> delegate;
@property (nonatomic, assign) BOOL autoScroll;  // default is YES
@property (nonatomic, assign) NSUInteger scrollInterval;    //default is 2 seconds
@property (nonatomic, assign) LDPageControlPosition pageControlPosition;
@property (nonatomic, assign) BOOL hidePageControl;
@property (nonatomic, assign) BOOL fitPicture;
@property (nonatomic,assign) float m_isOpen;

- (void)initWithCount:(NSInteger)count delegate:(id<LDImageCarouselViewDelegate>)delegate;

- (void)initWithCount:(NSInteger)count delegate:(id<LDImageCarouselViewDelegate>)delegate edgeInsets:(UIEdgeInsets)edgeInsets;
- (void)removeImageCarouseView;

@end

@protocol LDImageCarouselViewDelegate <NSObject>

@required

- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView loadImageForImageView:(LDImageView *)imageView index:(NSInteger)index;

@optional

- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView didTapAtIndex:(NSInteger)index imageURL:(NSURL *)imageURL;
- (void)imageCarouselView:(LDImageCarouselView *)imageCarouselView didTapAtIndex:(NSInteger)index;

@end
