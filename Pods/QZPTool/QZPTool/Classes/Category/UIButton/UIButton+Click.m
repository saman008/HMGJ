//
//  UIButton+Click.m
//  TestPesc
//
//  Created by disancheng on 2017/5/3.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "UIButton+Click.h"
#import <objc/runtime.h>
@implementation UIButton (Click)
static void * q_buttonKey = &q_buttonKey;
- (void)setClick:(void (^)())Click {
    if (Click) {
        objc_removeAssociatedObjects(self);
        objc_setAssociatedObject(self, q_buttonKey, Click, OBJC_ASSOCIATION_COPY);
        [self addTarget:self action:@selector(q_buttonClick:) forControlEvents: UIControlEventTouchUpInside];
        
    }
}
- (void (^)())Click {
    return objc_getAssociatedObject(self, q_buttonKey);
}
- (void)q_buttonClick: (UIButton *) btn {
    self.Click();
}
@end
