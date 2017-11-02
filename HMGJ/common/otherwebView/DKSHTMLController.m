//
//  DKSHTMLController.m
//  DKSWebView
//
//  Created by aDu on 2017/2/14.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "DKSHTMLController.h"
#import "JavaScriptinterface.h"
#import "hmgjBridge.h"
//#import "ScanShopQRCodeVC.h"


@interface DKSHTMLController ()<UIWebViewDelegate>

@property (nonatomic, strong) JSContext * jsContext;

@end

@implementation DKSHTMLController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self loadHTML:self.htmlUrl];
    [self.navigationController setNavigationBarHidden:NO animated:true];
}

//设置webview的title为导航栏的title

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    //[self setUpJSContext3: self.webView];
}

//- (void) setUpJSContext3:(UIWebView *) webView {
//    self.jsContext = [webView valueForKeyPath: @"documentView.webView.mainFrame.javaScriptContext"];
//    hmgjBridge * js = [hmgjBridge new];
//    @weakify(self);
//    js.scanqrcode = ^{
//        @strongify(self);
//        [self scan];
//    };
//    
//    self.jsContext[@"hmgjBridge"] = js;
//    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
//        context.exception = exception;
//        NSLog(@"异常信息：%@", exception);
//    };
//}

////和包积分方法调用
//- (void) scan {
//    NSLog(@"=======");
//    ScanShopQRCodeVC * vc = [[ScanShopQRCodeVC alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    @weakify(self);
//    vc.resultString = ^(NSString * str) {
//        @strongify(self);
//        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"scanQRCodeResult('%@')",str]];
//        QLog(@"%@",str);
//        
//    };
//    [self.navigationController pushViewController: vc animated: YES];
//}

@end
