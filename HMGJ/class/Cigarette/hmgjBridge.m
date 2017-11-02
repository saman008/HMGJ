//
//  hmgjBridge.m
//  Epay
//
//  Created by disancheng on 2017/7/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "hmgjBridge.h"

@implementation hmgjBridge

- (void)scanQRCode {
    if (self.scanqrcode) {
        self.scanqrcode();
    }
}

@end
