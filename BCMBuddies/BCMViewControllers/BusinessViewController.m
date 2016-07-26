//
//  BusinessViewController.m
//  BCMBuddies
//
//  Created by 王博 on 16/5/6.
//  Copyright © 2016年 鲁智星. All rights reserved.
//

#import "BusinessViewController.h"
#import "UIImage+ImageWithColor.h"
#import "BCMDefineFile.h"
#import "BusinessItemView.h"

@interface BusinessViewController ()<BusinessItemDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContentView2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContentView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnSerClass;
@property (weak, nonatomic) IBOutlet UILabel *labSerNameTitle;
@property (weak, nonatomic) IBOutlet UIView *viewContentSerItem;
@property (weak, nonatomic) IBOutlet UILabel *labSerTitleSecond;
@property (weak, nonatomic) IBOutlet UIView *viewContentSerItem2;


@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"业务向导";
    for (UIButton *item in self.btnSerClass) {
        [self setBackColor:item];
        if ([item.currentTitle isEqualToString:@"柜台受理"]) {
            item.selected = YES;
        }
        [item addTarget:self action:@selector(acitonChangeBusiness:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    float width = ([UIScreen mainScreen].bounds.size.width-3)/4;
    for (int i = 0; i<8; i++) {
        
        BusinessItemView *itemView = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
        itemView.labTitle.text = @"开通网银";
        itemView.imgIcon.backgroundColor = [UIColor redColor];
        [self.viewContentSerItem addSubview:itemView];
        itemView.btnBackclick.tag = 10 +i;

        if (i<4) {
            BusinessItemView *itemView2 = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
            [self.viewContentSerItem2 addSubview:itemView2];
            itemView2.labTitle.text = @"结算业务";
            itemView2.imgIcon.backgroundColor = [UIColor grayColor];
            itemView2.btnBackclick.tag = 20 +i;
        }
        self.heightContentView.constant = 89*(7/4+1);
        
        
    }
    
    // Do any additional setup after loading the view from its nib.
}



-(void)itemClick:(UIButton*)sender{
    NSLog(@"%ld",(long)sender.tag);

}

-(void)acitonChangeBusiness:(UIButton*)btn{
    for (UIButton *item in self.btnSerClass) {
        item.selected = NO;
        
    }
    btn.selected = YES;
}

-(void)setBackColor:(UIButton *)button{
    [button setTitleColor:RGBA(27, 120, 216, 1.0) forState:UIControlStateSelected];
    [button setTitleColor:RGBA(72, 72, 72, 1.0)forState:UIControlStateNormal];
    [button setTitleColor:RGBA(72, 72, 72, 1.0) forState:UIControlStateHighlighted];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionBusinessSelect:(UIButton *)sender {
    
    for (UIButton *item in self.btnSerClass) {
        item.selected = NO;
    }
    sender.selected = YES;
    float width = ([UIScreen mainScreen].bounds.size.width-3)/4;
    switch (sender.tag) {
        case 3001:
            for (UIView*itemVIew in self.viewContentSerItem.subviews) {
                [itemVIew removeFromSuperview];
            }
            self.labSerNameTitle.hidden = NO;
            self.viewContentSerItem2.hidden = NO;
            self.labSerTitleSecond.hidden = NO;
            for (int i = 0; i<8; i++) {
                
                BusinessItemView *itemView = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
                itemView.labTitle.text = @"开通网银";
                itemView.imgIcon.backgroundColor = [UIColor redColor];
                [self.viewContentSerItem addSubview:itemView];
                itemView.btnBackclick.tag = 10 +i;
                
                if (i<4) {
                    BusinessItemView *itemView2 = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
                    [self.viewContentSerItem2 addSubview:itemView2];
                    itemView2.labTitle.text = @"结算业务";
                    itemView2.imgIcon.backgroundColor = [UIColor grayColor];
                    itemView2.btnBackclick.tag = 20 +i;
                    self.heightContentView2.constant = 90*(3/4+1);
                }
                
                
            }
            self.heightContentView.constant = 90*(7/4+1);
            break;
        case 3002:
            for (UIView*itemVIew in self.viewContentSerItem.subviews) {
                [itemVIew removeFromSuperview];
            }
            self.heightContentView.constant = 90*(9/4+1);
            self.labSerNameTitle.hidden = YES;
            self.viewContentSerItem2.hidden = YES;
            self.labSerTitleSecond.hidden = YES;
            for (int i = 0; i<9; i++) {
                
                BusinessItemView *itemView = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
                itemView.labTitle.text = @"开通网银";
                itemView.imgIcon.backgroundColor = [UIColor redColor];
                [self.viewContentSerItem addSubview:itemView];
                itemView.btnBackclick.tag = 10 +i;
              
                
                
            }
        
            break;
        case 3003:
            for (UIView*itemVIew in self.viewContentSerItem.subviews) {
                [itemVIew removeFromSuperview];
            }
            self.heightContentView.constant = 90*(13/4+1);
            self.labSerNameTitle.hidden = YES;
            self.viewContentSerItem2.hidden = YES;
            self.labSerTitleSecond.hidden = YES;
            for (int i = 0; i<13; i++) {
               
                BusinessItemView *itemView = [[BusinessItemView alloc]initWithFrame:CGRectMake((width+1)*(i%4), 90*(i/4), width, 89)];
                itemView.labTitle.text = @"开通网银";
                itemView.imgIcon.backgroundColor = [UIColor redColor];
                [self.viewContentSerItem addSubview:itemView];
                itemView.btnBackclick.tag = 10 +i;
            }
            
            break;
        default:
            break;
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
