//
//  UIView+Xib.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIView+Xib.h"

@implementation UIView (Xib)
+ (instancetype)loadFromNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil];
    return [nibs firstObject];
}
+ (instancetype)loadFromNibWithName:(NSString*)aName
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:aName owner:self options:nil];
    return [nibs firstObject];
    
}
+ (instancetype)loadFromNibWithFrame:(CGRect)frame
{
    UIView * nibView = [self loadFromNib];
    nibView.frame = frame;
    return nibView;
}
+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class])
                          bundle:[NSBundle mainBundle]];
}

@end
