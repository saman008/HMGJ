//
//  WebVC.m
//  YLProject
//
//  Created by qzp on 2017/3/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "WebVC.h"
#import "backClickListener.h"
#import "JavaScriptinterface.h"
#import "hmgjBridge.h"
//#import "ScanShopQRCodeVC.h"

@interface WebVC () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, strong) JSContext * jsContext;
@end

@implementation WebVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:NO animated:true];
//    if (self.hideNav == YES) {
//        [self.navigationController setNavigationBarHidden: YES animated: animated];
//    } else {
//        [self.navigationController setNavigationBarHidden: NO animated: animated];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView.delegate = self;
    if(self.type == WebTypeUrl|| self.type == WebTypeNormalWeb) {
        if (![self.urlStr containsString:@"http"]) {
            self.urlStr = [NSString stringWithFormat:@"http://%@", self.urlStr];
        }
    
        NSURL * url = [NSURL URLWithString: [self.urlStr stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
        NSURLRequest * request = [NSURLRequest requestWithURL: url];
        [self.webView loadRequest: request];
    }
    else if (self.type == WebTypeFile) {
        self.title = @"用户协议";
        if ([self.urlStr isEqualToString:@"serviceAgreement_dzzh"]) {
            UIBarButtonItem * nextItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(next)];
            self.navigationItem.rightBarButtonItem = nextItem;
        }
        NSString * resourceName ;
        resourceName =  [[NSBundle mainBundle] pathForResource: self.urlStr ofType:@"html"];
        NSString *txt=[NSString stringWithContentsOfFile:resourceName encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [self.webView loadHTMLString: txt baseURL: baseURL];
    }
    
 
    
}
- (void) next {
    WebVC * webVC = [[WebVC alloc]init];
    webVC.type = WebTypeFile;
    webVC.urlStr = @"serviceAgreement_yelc";
    [self.navigationController pushViewController: webVC animated: YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setUpJSContext:(UIWebView *) webView {
    self.jsContext = [webView valueForKeyPath: @"documentView.webView.mainFrame.javaScriptContext"];
    backClickListener * js = [backClickListener new];
    js.goback = ^{
        [self.navigationController popViewControllerAnimated: YES];
    };
    self.jsContext[@"backClickListener"] = js;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@", exception);
    };
}
- (void) setUpJSContext2:(UIWebView *) webView {
    self.jsContext = [webView valueForKeyPath: @"documentView.webView.mainFrame.javaScriptContext"];
    JavaScriptinterface * js = [JavaScriptinterface new];
    js.goback = ^{
        [self.navigationController popViewControllerAnimated: YES];
    };
    self.jsContext[@"JavaScriptinterface"] = js;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@", exception);
    };
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
//         [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"scanQRCodeResult('%@')",str]];
//        QLog(@"%@",str);
// 
//    };
//    [self.navigationController pushViewController: vc animated: YES];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@",request);
    NSLog(@"%ld",(long)navigationType);
 
    return YES;
}
//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    QLog(@"startLoad");
//}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
//    QLog(@"%@", error);
//}

//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    NSLog(@"finish");
//    //设置标题与webview的标题一致
//    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    if (self.type == WebTypeNormalWeb) {
//        [self setUpJSContext3: self.webView];
//        return;
//    }
//    
//    if (self.hideNav) {
//        if (self.isPay) {
//            [self setUpJSContext2: self.webView];
//        } else {
//            [self setUpJSContext: self.webView];
//        }
//    }
//    
//}

@end
