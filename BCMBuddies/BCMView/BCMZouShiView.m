//
//  BCMZouShiView.m
//  BCMBuddies
//
//  Created by 鲁智星 on 16/2/16.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BCMZouShiView.h"
#import "BCMDefineFile.h"

@implementation BCMZouShiView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.m_buttonArray = [[NSMutableArray alloc] init];
        self.m_labelArray = [[NSMutableArray alloc] init];
        linesLayer = [[CALayer alloc] init];
        linesLayer.masksToBounds = YES;
        linesLayer.contentsGravity = kCAGravityLeft;
        linesLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        [self.layer addSublayer:linesLayer];
        //PopView
        popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [popView setAlpha:0.0f];
        
        disLabel = [[UILabel alloc]initWithFrame:popView.frame];
        [disLabel setTextAlignment:NSTextAlignmentCenter];
        
        [popView addSubview:disLabel];
        [self addSubview:popView];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.m_buttonArray = [[NSMutableArray alloc] init];
    self.m_labelArray = [[NSMutableArray alloc] init];
    self.backgroundColor = [UIColor clearColor];
    linesLayer = [[CALayer alloc] init];
    linesLayer.masksToBounds = YES;
    linesLayer.contentsGravity = kCAGravityLeft;
    linesLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    [self.layer addSublayer:linesLayer];
    //PopView
//    popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    [popView setAlpha:0.0f];
//    
//    disLabel = [[UILabel alloc]initWithFrame:popView.frame];
//    [disLabel setTextAlignment:NSTextAlignmentCenter];
//    
//    [popView addSubview:disLabel];
//    [self addSubview:popView];
}
- (double)getTitleValue:(NSString *)timeString
{
    NSDateFormatter *wd_date=[[NSDateFormatter alloc] init];
    wd_date.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *d1=[wd_date dateFromString:@"2015-01-01 09:00:00"];
    NSTimeInterval late1=[d1 timeIntervalSince1970];
    timeString = [NSString stringWithFormat:@"2015-01-01 %@%@",timeString,@":00"];
    NSDate *d2=[wd_date dateFromString:timeString];
    NSTimeInterval late2=[d2 timeIntervalSince1970];
    NSTimeInterval cha=late2-late1;
    return (double)(cha/60);
}
- (int)getLastTime
{
    int wd_index = -1;
    NSTimeInterval wd_time = 9999999999;
    for(int i = 0;i < self.m_array.count;i++)
    {
        NSDictionary *wd_dic1 = [self.m_array objectAtIndex:i];
        NSString *wd_timeString1 = [wd_dic1 objectForKey:@"servTime"];
        NSDateFormatter *wd_date=[[NSDateFormatter alloc] init];
        wd_date.dateFormat = @"HH:mm";
        NSDate *now = [NSDate date];
        NSString *wd_timeString2=[wd_date stringFromDate:now];
        NSDateFormatter *wd_date1=[[NSDateFormatter alloc] init];
        wd_date1.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *wd_cootime1 = [NSString stringWithFormat:@"2015-01-01 %@%@",wd_timeString1,@":00"];
        NSString *wd_cootime2 = [NSString stringWithFormat:@"2015-01-01 %@%@",wd_timeString2,@":00"];
        NSDate *d1 = [wd_date1 dateFromString:wd_cootime1];
        NSDate *d2 = [wd_date1 dateFromString:wd_cootime2];
        NSTimeInterval late1=[d1 timeIntervalSince1970];
        NSTimeInterval late2=[d2 timeIntervalSince1970];
        NSTimeInterval cha=late2-late1;
        if(cha > 0)
        {
            if(cha < wd_time)
            {
                wd_time = cha;
                wd_index = i;
            }
        }
    }
    if(wd_index == -1)
    {
        wd_index = (int)self.m_array.count - 1;
    }
    return wd_index;
}
#define ZeroPoint CGPointMake(30,200)

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    [self setClearsContextBeforeDrawing: YES];
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画背景线条------------------
    CGColorRef backColorRef = [UIColor whiteColor].CGColor;
    CGFloat backLineWidth = 0.5;
    CGFloat backMiterLimit = 0.f;
    CGContextSetLineWidth(context, backLineWidth);//主线宽度
    CGContextSetMiterLimit(context, backMiterLimit);//投影角度
    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, backColorRef);//设置双条线
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound );
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGFloat lengths[] = {1,1};
    CGContextSetLineDash(context,0,lengths,2);
    float x = self.frame.size.width - 15;
    float y = 175 ;
    float x1 = 76/320.0;
    float y1 = 175;
    for (int i=0; i<6; i++) {
        CGPoint bPoint = CGPointMake((self.frame.size.width *x1)/2.0, y);
        CGPoint ePoint = CGPointMake(x, y);
        CGContextMoveToPoint(context, bPoint.x, bPoint.y);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y);
        y -= 26;
    }
    for (int i=0; i<9; i++) {
        CGPoint bPoint = CGPointMake((self.frame.size.width *x1)/2.0,46);
        CGPoint ePoint = CGPointMake((self.frame.size.width *x1)/2.0,y1);
        CGFloat lengths[] = {1,1};
        CGContextSetLineDash(context,0,lengths,2);
        CGContextMoveToPoint(context, bPoint.x, bPoint.y);
        CGContextAddLineToPoint(context, ePoint.x, ePoint.y);
        x1 = x1 + 64/320.0;
    }
    CGContextStrokePath(context);
    //    //画点线条------------------
    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
    CGFloat pointLineWidth = 2.0;
    CGFloat pointMiterLimit = 5.0f;
    
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度
    CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, pointColorRef);//设置双条线
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound );
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    UIColor *wd_lineColor = RGBA(49,179,229,1.0);
    CGContextSetStrokeColorWithColor(context, wd_lineColor.CGColor);
    CGFloat lengths2[] = {1,0};
    CGContextSetLineDash(context,0,lengths2,2);
    NSArray *wd_array = self.subviews;
    for(int i = (int)wd_array.count - 1;i >= 0;i--)
    {
        UIView *wd_view = [wd_array objectAtIndex:i];
        if(wd_view.tag == 5023)
        {
            [wd_view removeFromSuperview];
        }
    }
    [self.m_buttonArray removeAllObjects];
    [self.m_labelArray removeAllObjects];
    //绘图
    int wd_index = [self getLastTime];
    if(self.m_array)
    {
        float x2 = 76/320.0;
        float y2 = 175;
        NSDictionary *wd_dic1 = [self.m_array objectAtIndex:0];
        NSString *wd_timeString1 = [wd_dic1 objectForKey:@"servTime"];
        double wd_timeDoubleValue1 = [self getTitleValue:wd_timeString1];
        if(wd_timeDoubleValue1 > 480)
        {
            wd_timeDoubleValue1 = 480;
        }
        int wd_waitcount1 = [[wd_dic1 objectForKey:@"waitTime"] intValue];
        if(wd_waitcount1 >= 50)
        {
            wd_waitcount1 = 50;
        }
        float wd_x2 = 76/320.0 + (512/320.0) * (wd_timeDoubleValue1/480.0);
        float wd_y2 = 175 - 130 * (wd_waitcount1/50.0);
        CGContextMoveToPoint(context,(self.frame.size.width *wd_x2)/2.0,wd_y2);
        
        UIButton *wd_button = [UIButton buttonWithType:UIButtonTypeCustom];
        wd_button.frame = CGRectMake(0,0,30,30);
        [wd_button setCenter:CGPointMake((self.frame.size.width *wd_x2)/2.0,wd_y2)];
        [wd_button setImage:[UIImage imageNamed:@"time_dian_icon.png"] forState:UIControlStateNormal];
        [wd_button setImage:[UIImage imageNamed:@"curent_time_dian_icon.png"] forState:UIControlStateSelected];
        [wd_button addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
        wd_button.tag = 5023;
        UILabel *wd_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,35,16)];
        CALayer * wd_layer = [wd_label layer];
        wd_layer.masksToBounds = YES;
        wd_layer.cornerRadius = 6;
        wd_label.backgroundColor = RGBA(254,231,74,1.0);
        wd_label.textColor = RGBA(16,100,166,1.0);
        wd_label.font = [UIFont systemFontOfSize:13];
        wd_label.textAlignment = NSTextAlignmentCenter;
        wd_label.text = [NSString stringWithFormat:@"%d分",wd_waitcount1];
        wd_label.center = CGPointMake((self.frame.size.width *wd_x2)/2.0,wd_y2 - 20);
        wd_label.tag = 5023;
        wd_button.selected = NO;
        wd_label.hidden = YES;
        [self.m_buttonArray addObject:wd_button];
        [self.m_labelArray addObject:wd_label];
        [self addSubview:wd_button];
        [self addSubview:wd_label];
        for (int i = 1; i<[self.m_array count]; i++)
        {
            NSDictionary *wd_dic = [self.m_array objectAtIndex:i];
            NSString *wd_timeString = [wd_dic objectForKey:@"servTime"];
            //        if([wd_timeString isEqualToString:@"17:00"])
            //        {
            //            wd_islast = YES;
            //        }
            double wd_timeDoubleValue = [self getTitleValue:wd_timeString];
            if(wd_timeDoubleValue > 480)
            {
                wd_timeDoubleValue = 480;
            }
            x2 = 76/320.0 + (512/320.0) * (wd_timeDoubleValue/480.0);
            int wd_waitcount = [[wd_dic objectForKey:@"waitTime"] intValue];
            if(wd_waitcount >= 50)
            {
                wd_waitcount = 50;
            }
            y2 = 175 - 130 * (wd_waitcount/50.0);
            CGContextAddLineToPoint(context,(self.frame.size.width *x2)/2.0,y2);
            UIButton *wd_button = [UIButton buttonWithType:UIButtonTypeCustom];
            wd_button.frame = CGRectMake(0,0,30,30);
            [wd_button setCenter:CGPointMake((self.frame.size.width *x2)/2.0,y2)];
            [wd_button setImage:[UIImage imageNamed:@"time_dian_icon.png"] forState:UIControlStateNormal];
            [wd_button setImage:[UIImage imageNamed:@"curent_time_dian_icon.png"] forState:UIControlStateSelected];
            [wd_button addTarget:self action:@selector(btAction:) forControlEvents:UIControlEventTouchUpInside];
            wd_button.tag = 5023;
//            UIImageView *wd_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,7,7)];
//            wd_imageView.image = [UIImage imageNamed:@"time_dian_icon.png"];
            UILabel *wd_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,35,16)];
            CALayer * wd_layer = [wd_label layer];
            wd_layer.masksToBounds = YES;
            wd_layer.cornerRadius = 6;
            wd_label.backgroundColor = RGBA(254,231,74,1.0);
            wd_label.textColor = RGBA(16,100,166,1.0);
            wd_label.font = [UIFont systemFontOfSize:13];
            wd_label.textAlignment = NSTextAlignmentCenter;
            wd_label.text = [NSString stringWithFormat:@"%d分",wd_waitcount];
            wd_label.center = CGPointMake((self.frame.size.width *x2)/2.0,y2 - 20);
            wd_label.tag = 5023;
            wd_button.selected = NO;
            wd_label.hidden = YES;
            [self.m_buttonArray addObject:wd_button];
            [self.m_labelArray addObject:wd_label];
            [self addSubview:wd_button];
            [self addSubview:wd_label];
        }
        UIButton *wd_seleteButton = [self.m_buttonArray objectAtIndex:wd_index];
        UILabel *wd_selecteLabel = [self.m_labelArray objectAtIndex:wd_index];
        wd_seleteButton.selected = YES;
        wd_selecteLabel.hidden = NO;
    }
    CGContextStrokePath(context);
}

- (void)btAction:(UIButton *)button{
    int wd_index = (int)[self.m_buttonArray indexOfObject:button];
    for(int i = 0;i < self.m_buttonArray.count;i++)
    {
        UIButton *wd_button = [self.m_buttonArray objectAtIndex:i];
        UILabel *wd_label = [self.m_labelArray objectAtIndex:i];
        if(wd_index == i)
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

@end
