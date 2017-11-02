//
//  hmgjBridge.h
//  Epay
//
//  Created by disancheng on 2017/7/26.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol HmgjObjectProtocol <JSExport>

- (void)scanQRCode;

@end
@interface hmgjBridge : NSObject <HmgjObjectProtocol>
typedef void (^scan) ();
@property (nonatomic, copy) scan scanqrcode;
@end
