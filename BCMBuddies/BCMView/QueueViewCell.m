
//
//  QueueViewCell.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/12.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "QueueViewCell.h"

@implementation QueueViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style  reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"QueueViewCell" owner:nil options:nil] lastObject];
    }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
