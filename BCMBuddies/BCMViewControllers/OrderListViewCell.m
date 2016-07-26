//
//  OrderListViewCell.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/20.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "OrderListViewCell.h"

@implementation OrderListViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"OrderListViewCell" owner:nil options:nil] lastObject];
    }
    return self;
}

-(void)reloadData:(ModOrderList *)model{

    self.labOrderInfo.text= model.orderInfo;
    self.labOrderTitle.text = model.orderTitle;
    self.imagePerson.image = [UIImage imageNamed:@"personImage"];
}

@end
