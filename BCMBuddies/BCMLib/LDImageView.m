//
//  LDImageView.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "LDImageView.h"

@implementation LDImageView

@synthesize delegate;
@synthesize url;
@synthesize imagePath;
@synthesize image;
@synthesize defaultImage;
@synthesize autoresizesToImage;
@synthesize isShow;
@synthesize grayBack;
@synthesize grayFrame;
@synthesize imageFit;
@synthesize defaultFit;
@synthesize imageFill;
@synthesize enable;
@synthesize m_type;
@synthesize m_imageNewFill;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		_request = nil;
		self.url = nil;
		self.image = nil;
		self.defaultImage = nil;
        self.m_type = 0;
		self.autoresizesToImage = NO;
		self.opaque = YES;
		self.grayBack = NO;
		self.grayFrame = NO;
		self.imageFit = YES;
		self.enable = YES;
        self.defaultFit = YES;
        self.imageFill = YES;
        self.m_imageNewFill = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
		self.backgroundColor = [UIColor clearColor];
		m_activeView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        m_activeView.backgroundColor = [UIColor clearColor];
		[self addSubview: m_activeView];
    }
    return self;
}
- (void)awakeFromNib
{
    _request = nil;
    self.url = nil;
    self.image = nil;
    self.defaultImage = nil;
    self.m_type = 0;
    self.autoresizesToImage = NO;
    self.opaque = YES;
    self.grayBack = NO;
    self.grayFrame = NO;
    self.imageFit = YES;
    self.enable = YES;
    self.defaultFit = YES;
    self.imageFill = YES;
    self.m_imageNewFill = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    m_activeView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    m_activeView.backgroundColor = [UIColor clearColor];
    [self addSubview: m_activeView];
    
}
- (void)layoutSubviews
{
	[super layoutSubviews];
	[m_activeView sizeToFit];
	CGRect rcView = m_activeView.frame;
	CGRect rcWnd = self.bounds;
	m_activeView.frame = CGRectMake(rcWnd.size.width/2 - rcView.size.width/2, rcWnd.size.height/2 - rcView.size.height/2, 
								   rcView.size.width, rcView.size.height);
}

- (CGRect)GetAptlySize: (CGSize)size frame:(CGRect)rect
{
    CGRect mySize;
    if(self.m_imageNewFill)
    {
        float fOrg = rect.size.width / rect.size.height;
        float fTar = size.width / size.height;
        if (fTar > fOrg)
        {
            mySize.origin.x = (fTar * rect.size.height - rect.size.width)/2 * -1;
            mySize.origin.y = rect.origin.y;
            mySize.size.width = fTar * rect.size.height;
            mySize.size.height = rect.size.height;

        }
        else if ( fTar < fOrg )
        {
            mySize.origin.x = rect.origin.x;
            mySize.origin.y = (rect.size.width/fTar - rect.size.height)/2 * -1;
            mySize.size.width = rect.size.width;
            mySize.size.height = rect.size.width/fTar;
        }
        else
        {
            mySize = rect;
        }
    }
    else
    {
        if ( size.width < rect.size.width && size.height < rect.size.height )
        {
            mySize = CGRectMake(rect.origin.x + (rect.size.width - size.width)/2,
                                rect.origin.y + (rect.size.height - size.height)/2,
                                size.width,
                                size.height);
            
            return mySize;
        }
        
        float fOrg = rect.size.width / rect.size.height;
        float fTar = size.width / size.height;
        
        if (fTar > fOrg)
        {
            mySize = CGRectMake(rect.origin.x,rect.origin.y, rect.size.width, size.height*rect.size.width/size.width);
            mySize.origin.y += (rect.size.height - mySize.size.height)/2;
        }
        else if ( fTar < fOrg )
        {
            mySize = CGRectMake(rect.origin.x,rect.origin.y, size.width*rect.size.height/size.height, rect.size.height);
            mySize.origin.x += (rect.size.width - mySize.size.width)/2;
        }
        else
        {
            mySize = rect;
        }
    }
	return mySize;
}


- (void)drawRect:(CGRect)rect 
{
	if (self.image && self.isShow)
	{
		if (self.grayBack)
		{
			if ( self.imageFill )
			{
				[self.image drawInRect:rect ];
				return;
			}
			CGRect rcImg = [self GetAptlySize:self.image.size frame:rect];
			if (self.grayFrame)
			{
				CGContextRef myContext = UIGraphicsGetCurrentContext();
				CGContextSetRGBFillColor (myContext, 192.0/255, 192.0/255, 192.0/255, 1);
				CGContextFillRect (myContext, rect);
				rcImg = CGRectOffset(rect,1,1);
				rcImg.size.width -= 2;
				rcImg.size.height -= 2;
			}
			[self.image drawInRect:rcImg];
		}
		else
		{
			CGRect rcImg = rect;
			if (self.imageFit)
			{
				rcImg = [self GetAptlySize:self.image.size frame:rect];
			}
			[self.image drawInRect:rcImg ];
		}
	} 
	else 
	{
		if (self.grayBack)
		{
			CGContextRef myContext = UIGraphicsGetCurrentContext();
			CGContextSetRGBFillColor (myContext, 192.0/255, 192.0/255, 192.0/255, 1);
			CGContextFillRect (myContext, rect);
			CGRect rcImg = CGRectOffset(rect,1,1);
			rcImg.size.width -= 2;
			rcImg.size.height -= 2;
			CGContextSetRGBFillColor (myContext, 234.0/255, 234.0/255, 234.0/255, 1);
			CGContextFillRect (myContext, rcImg);
		}
		else if (self.defaultImage)
		{
			CGRect rcImg = rect;
			if (self.defaultFit)
			{
				rcImg = [self GetAptlySize:self.defaultImage.size frame:rect];
			}
			[self.defaultImage drawInRect:rcImg ];
		}
	}
}
- (void)setUrlAndPath:(NSString*)imageURL imagePath:(NSString *)imageFilePath
{
	if (self.url && [imageURL isEqualToString:self.url])
	{
        if([UIImage imageWithContentsOfFile:imageFilePath])
        {
            [self.delegate imageViewFinishLoad:self];
            [m_activeView stopAnimating];
        }
        [self setNeedsDisplay];
		return;
	}
	self.isShow = NO;
	[self setNeedsDisplay];
	self.url = imageURL;
    self.imagePath = imageFilePath;
	if (!self.url || !self.url.length) 
	{
		[self imageViewWillLoadImage];
        [self setImage:self.defaultImage];
	}
	else
	{
		[self reload];
	}
}
- (void)setImage:(UIImage*)newImage {
	if (newImage != self.image)
	{
		image = newImage;
		CGRect wk_frame = self.frame;
		if ( self.grayBack == NO )
		{
			if (self.autoresizesToImage) {
				self.frame = CGRectMake(wk_frame.origin.x, wk_frame.origin.y, self.image.size.width, self.image.size.height);
			} else {
				if (!wk_frame.size.width && !wk_frame.size.height) {
					self.frame = CGRectMake(wk_frame.origin.x, wk_frame.origin.y, self.image.size.width, self.image.size.height);
				} else if (wk_frame.size.width && !wk_frame.size.height) {
					self.frame = CGRectMake(wk_frame.origin.x, wk_frame.origin.y,
											wk_frame.size.width, floor((self.image.size.height/self.image.size.width) * wk_frame.size.width));
				} else if (wk_frame.size.height && !wk_frame.size.width) {
					self.frame = CGRectMake(wk_frame.origin.x, wk_frame.origin.y,
											floor((self.image.size.width/self.image.size.height) * wk_frame.size.height), wk_frame.size.height);
				}
			}
		}
		[self imageViewDidLoadImage:self.image];
		if (!self.defaultImage || self.image != self.defaultImage) {
			if ([self.delegate respondsToSelector:@selector(imageView:didLoadImage:)]) {
				[self.delegate imageView:self didLoadImage:self.image];
			}
		}
		self.isShow = YES;
		[self setNeedsDisplay];
	}
}
- (BOOL)isLoading {
	return !!_request;
}
- (BOOL)isLoaded {
	return self.image && self.image != self.defaultImage;
}

- (void)reload {
    if (self.url)
    {
        if ([UIImage imageWithContentsOfFile:self.imagePath] == nil) {
            NSString *wk_string = self.url;
//            if(self.m_type == 0)
//            {
//                wk_string = [self.url stringByAppendingString:@"!200.jpg"];
//                
//            }
//            else
//            {
//                if(self.m_type == 1)
//                {
//                    wk_string = [self.url stringByAppendingString:@"!100.jpg"];
//                }
//                else
//                {
//                    if(self.m_type == 5)
//                    {
//                        wk_string = [self.url stringByAppendingString:@"!560x300.jpg"];
//                    }
//                    else
//                    {
//                        if(self.m_type == 4)
//                        {
//                            wk_string = [self.url stringByAppendingString:@"!200x200.jpg"];
//                        }
//                        else
//                        {
//                            wk_string = self.url;
//                        }
//                        
//                    }
//                }
//            }
            wk_string = [wk_string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSMutableURLRequest *wk_request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:wk_string]];
            [wk_request setHTTPMethod:@"GET"];
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            [m_activeView startAnimating];
            [NSURLConnection sendAsynchronousRequest:wk_request queue:queue completionHandler:
             ^(NSURLResponse *response,NSData *data,NSError *error){
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     if(error == nil)
                     {
                         [data writeToFile:self.imagePath atomically:YES];
                         if([UIImage imageWithContentsOfFile:self.imagePath])
                         {
                             UIImage *wk_newimage = [UIImage imageWithContentsOfFile:self.imagePath];
                             [self setImage:wk_newimage];
                             [self.delegate imageViewFinishLoad:self];
                         }
                         else
                         {
                             if (self.defaultImage) {
                                 [self setImage:self.defaultImage];
                             }
                         }
                     }
                     else
                     {
                         if (self.defaultImage) {
                             [self setImage:self.defaultImage];
                         }
                     }
                     [m_activeView stopAnimating];
                 });
             }];
        }
        else 
        {
            [self.delegate imageViewFinishLoad:self];
            UIImage *wk_newimage = [UIImage imageWithContentsOfFile:self.imagePath];
            [self setImage:wk_newimage];
            [m_activeView stopAnimating];
        }
    }else
    {
        if (self.defaultImage) {
            [self setImage:self.defaultImage];
        }
    }
}

- (void)stopLoading {
    [m_activeView stopAnimating];
}

- (void)imageViewWillLoadImage
{
	
}
- (void)imageViewDidStartLoad {
}

- (void)imageViewDidLoadImage:(UIImage*)image {
}

- (void)imageViewDidFailLoadWithError:(NSError*)error {
}
@end
