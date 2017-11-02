//
//  backClickListener.h
//  Epay
//
//  Created by disancheng on 2017/6/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjectProtocol <JSExport>

- (void)back;

@end

@interface backClickListener : NSObject <JSObjectProtocol>

typedef void (^goBack) ();
@property (nonatomic, copy) goBack goback;

@end
