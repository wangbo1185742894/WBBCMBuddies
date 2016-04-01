//
//  LDImageView.h
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LDImageViewDelegate;

@interface LDImageView : UIView
{
	NSMutableURLRequest*				_request;
	UIActivityIndicatorView*	 m_activeView;
}

@property(nonatomic,weak) id<LDImageViewDelegate> delegate;
@property(nonatomic,strong) NSString* url;
@property(nonatomic,strong) NSString* imagePath;
@property(nonatomic,strong) UIImage* image;
@property(nonatomic,strong) UIImage* defaultImage;
@property(nonatomic,assign) BOOL autoresizesToImage;
@property(nonatomic,assign) BOOL isShow;
@property(nonatomic,assign) BOOL grayBack;
@property(nonatomic,assign) BOOL grayFrame;
@property(nonatomic,assign) BOOL imageFit;
@property(nonatomic,assign) BOOL defaultFit;
@property(nonatomic,assign) BOOL imageFill;
@property(nonatomic,assign) BOOL enable;
@property(nonatomic,assign) BOOL isLoading;
@property(nonatomic,assign) BOOL isLoaded;
@property(nonatomic,assign) int  m_type;
@property(nonatomic,assign) BOOL  m_imageNewFill;

- (void)setUrlAndPath:(NSString*)imageURL imagePath:(NSString *)imageFilePath;
- (void)reload;
- (void)stopLoading;

- (void)imageViewWillLoadImage;
- (void)imageViewDidStartLoad;
- (void)imageViewDidLoadImage:(UIImage*)image;
- (void)imageViewDidFailLoadWithError:(NSError*)error;

- (CGRect)GetAptlySize: (CGSize)size frame:(CGRect)rect;

@end


///////////////////////////////////////////////////////////////////////////////////

@protocol LDImageViewDelegate <NSObject>

@optional
- (void)imageView:(LDImageView*)imageView didLoadImage:(UIImage*)image;
- (void)imageViewDidStartLoad:(LDImageView*)imageView;
- (void)imageView:(LDImageView*)imageView didFailLoadWithError:(NSError*)error;
- (void)imageViewFinishLoad:(LDImageView*)imageView;
@end