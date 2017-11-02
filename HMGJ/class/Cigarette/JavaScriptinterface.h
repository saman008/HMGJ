//
//  JavaScriptinterface.h
//  Epay
//
//  Created by disancheng on 2017/7/10.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol MyJSObjectProtocol <JSExport>

- (void)back;

@end


@interface JavaScriptinterface :  NSObject <MyJSObjectProtocol>

typedef void (^goBack) ();
@property (nonatomic, copy) goBack goback;

@end
