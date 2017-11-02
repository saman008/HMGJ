//
//  CigaretteGoodsCell.m
//  Epay
//
//  Created by qzp on 2017/6/18.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "CigaretteGoodsCell.h"

#import <YYWebImage/YYWebImage.h>
#import "QZPToolHeader.h"
@interface CigaretteGoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel2;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end

@implementation CigaretteGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCigartte:(Cigarette *)cigartte {
    NSString * urlStr = [NSString stringWithFormat:@"http://gz.xinshangmeng.com/xsm6/resource/ec/cgtpic/%@_middle_face.png",cigartte.cgtCode];
    [self.iconIV yy_setImageWithURL:[NSURL URLWithString: urlStr]  placeholder: GetImage(@"no_pic")];
    self.nameLabel.text = [self URLDecodedString: cigartte.cgtName];
    self.bottomLabel1.text = cigartte.cgtCode;
    if (self.type == CigaretteGoodsTypeCollect) {
        self.bottomLabel2.hidden =
        self.numberLabel.hidden = YES;
    }
    else if (self.type == CigaretteGoodsTypeHistoyList) {
        self.bottomLabel2.hidden = YES;
        self.bottomLabel1.text = [NSString stringWithFormat:@"%.2f/条",[cigartte.price floatValue]];
        self.numberLabel.text = cigartte.ordQty;
    }
    else if (self.type == CigaretteGoodsTypeGoodsList) {
        self.bottomLabel1.text = [NSString stringWithFormat:@"%.2f/条",[cigartte.price floatValue]];
        self.numberLabel.text = cigartte.ordQty?:@"0" ;
        self.numberLabel.hidden = NO;
    }

}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

@end
