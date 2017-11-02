//
//  JavaScriptinterface.m
//  Epay
//
//  Created by disancheng on 2017/7/10.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "JavaScriptinterface.h"

@implementation JavaScriptinterface
- (void)back {
    
    if (self.goback) {
        self.goback();
    }
}
@end
