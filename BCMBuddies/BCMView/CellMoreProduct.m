//
//  CellMoreProduct.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/27.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "CellMoreProduct.h"

@implementation CellMoreProduct

-(id )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CellMoreProduct" owner:nil options:nil] lastObject];
        self.btnBack.userInteractionEnabled = NO;
    }
    return self;

}

-(void)reloadData{


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
