//
//  backClickListener.m
//  Epay
//
//  Created by disancheng on 2017/6/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "backClickListener.h"

@implementation backClickListener
- (void)back {
    
    if (self.goback) {
        self.goback();
    }
}

@end
