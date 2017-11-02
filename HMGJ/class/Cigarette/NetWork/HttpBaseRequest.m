//
//  HttpRequest.m
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import "HttpBaseRequest.h"
#import <AFNetworking/AFNetworking.h>

#import "AppMacro.h"
#import "QZPToolHeader.h"
@implementation HttpBaseRequest

+ (void)requestWithURL:(NSString *)url params:(id)params method:(MethodType)method completion:(void (^)(NSInteger, NSString *, id))completion {
    
    NSString * bURL = MainURL;
    
    if ([url containsString:@"sso"]) {
        bURL = BaseURL;
    } else if ([url isEqualToString: @"customer/login"]) {
        bURL = XSMURL;
    }else if ([url containsString:@"micro"]){
        bURL = microURL;
    }
    else if ([url containsString: @"message"] || [url isEqualToString:@"inform/acquire"]) {
//        bURL = @"http://125.69.76.146:1473/";
        bURL = @"http://info.inlee.com.cn/";
    }
    else if ([params isKindOfClass:[NSString class]]) {
        if ([params isEqualToString: @"SUPER1"]) { //特殊请求
            bURL=@"";
        }
    }
    else if ([url containsString:@"baccy"]) {
        bURL = BACCY_URL;
    }
    else     if ([url containsString:@"merchant"]) { //商户中心店铺相关
        bURL =  MerchantURL;
    }
    
    if ([url isEqualToString:@"payment/transaction"]) {
//        bURL = @"http://payment.inlee.com.cn:8280/";
        bURL = @"http://payment.inlee.com.cn/";
        
    }

//    if ([url isEqualToString:@"http://www.zdepay.com/epay/order/pay/result/qryPhone"] ||
//        [url isEqualToString:@"http://www.zdepay.com/front/judgeByRefid"]) {//查询支付结果
    if ([url containsString:@"www.zdepay.com"]) {//查询支付结果
        bURL = @"";
    }
    
    NSString * allUrl = [NSString stringWithFormat: @"%@%@",bURL, url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    if ([url isEqualToString: @"shop/employee/swap"]) {
//        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//        [securityPolicy setAllowInvalidCertificates:YES];
//   
        //这里进行设置；
//        [manager setSecurityPolicy:securityPolicy];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
         manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    
    else  if ([url containsString: @"merchant"]) {
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
   else if (![url containsString:@"sso"]) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
   }
 
    if ([url isEqualToString:@"baccy/baccy/orgparm"] ||
        [url isEqualToString:@"http://www.zdepay.com/front/judgeByRefid"]||
        [url isEqualToString:@"baccy/baccy/allowforphone"]||
        [url  isEqualToString:@"http://www.zdepay.com/epay/pay/mobilepay"]||
        [url isEqualToString:@"http://www.zdepay.com/pay/epay/billcheck"]) { //提交参数不是JSON格式
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    
//    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
//    [manager setRequestSerializer:jsonRequestSerializer];
    
    if (method == MethodTypeGET) {
        [manager GET: allUrl parameters: params progress:^(NSProgress * _Nonnull downloadProgress) {
             QLog(@"请求URL=%@",allUrl);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            QLog(@"请求URL=%@",allUrl);
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        }];
    } else if (method == MethodTypePOST) {
        [manager POST: allUrl parameters: params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        }];
    } else if (method == MethodTypePUT) {
        [manager PUT: allUrl parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        }];
    } else if (method == MethodTypeDELETE) {
        [manager DELETE: allUrl parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2]);
        }];
    }
  
}

+ (void)requestWithURL:(NSString *)url params:(id)params method:(MethodType)method sign:(id)sign completion:(void (^)(NSInteger, NSString *, id, id))completion {
    NSString * bURL = MainURL;
    if ([url containsString:@"sso"]) {
        bURL = BaseURL;
    } else if ([url isEqualToString: @"customer/login"]) {
        bURL = XSMURL;
    }
    else if ([url containsString: @"message"]) {
//        bURL = @"http://125.69.76.146:1473/";
           bURL = @"http://info.inlee.com.cn/";
    }
    else if ([params isKindOfClass:[NSString class]]) {
        if ([params isEqualToString: @"SUPER1"]) { //特殊请求
            bURL=@"";
        }
    }
    
    if ([url isEqualToString:@"payment/transaction"]) {
//        bURL = @"http://payment.inlee.com.cn:8280/";
//        bURL = @"https://payment.inlee.com.cn/";
         bURL = @"http://payment.inlee.com.cn/";
    }
    if ([url containsString:@"merchant"]) { //商户中心店铺相关
        bURL =  MerchantURL;
    }
    
    NSString * allUrl = [NSString stringWithFormat: @"%@%@",bURL, url];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer =  [AFJSONResponseSerializer serializer];
    if ([url isEqualToString: @"shop/employee/swap"]) {
        //        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
        //        [securityPolicy setAllowInvalidCertificates:YES];
        //
        //这里进行设置；
        //        [manager setSecurityPolicy:securityPolicy];
        //        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    
    else  if ([url containsString: @"merchant"]) {
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    else if (![url containsString:@"sso"]) {
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
    
    
    
    //    AFJSONRequestSerializer *jsonRequestSerializer = [AFJSONRequestSerializer serializer];
    //    [manager setRequestSerializer:jsonRequestSerializer];
    
    if (method == MethodTypeGET) {
        [manager GET: allUrl parameters: params progress:^(NSProgress * _Nonnull downloadProgress) {
            QLog(@"请求URL=%@",allUrl);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            QLog(@"请求URL=%@",allUrl);
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
         completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        }];
    } else if (method == MethodTypePOST) {
        [manager POST: allUrl parameters: params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
           completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
          completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        }];
    } else if (method == MethodTypePUT) {
        [manager PUT: allUrl parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
            completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
         completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        }];
    } else if (method == MethodTypeDELETE) {
        [manager DELETE: allUrl parameters: params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSArray * resultArray = [self handlerResult: task responseObject: responseObject postURL:url];
        completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            NSArray * resultArray = [self handlerResult: task responseObject: nil postURL: url];
           completion([resultArray[0] integerValue], resultArray[1], resultArray[2], sign);
        }];
    }

}

+ (NSArray * ) handlerResult:(NSURLSessionDataTask *) task responseObject: (id) responseObject postURL: (NSString *) pURL {
    NSInteger code = 400;
    NSString * msg = @"请求失败";
    id result = @{};
    
    if ([pURL isEqualToString:@"http://www.zdepay.com/epay/order/pay/result/qryPhone"]
        || [pURL isEqualToString:@"http://www.zdepay.com/front/judgeByRefid"]
        || [pURL isEqualToString:@"http://www.zdepay.com/epay/pay/billcheck"]||
        [pURL isEqualToString:@"http://www.zdepay.com/epay/pay/mobilepay"]) {
    
        return @[[NSString stringWithFormat:@"%ld",(long)code],responseObject[@"result_msg"],responseObject];
    }
    
    
    if (task != nil) {
        if (task.response != nil) {
            code = ((NSHTTPURLResponse *)task.response).statusCode;
            NSLog(@"%ld",(long)code);
            
        }
    }
    
//    QLog(@"%@",responseObject);
    if (responseObject != nil) {
        
        if ([responseObject isKindOfClass: [NSDictionary class]]) {
            code = [[((NSDictionary *) responseObject) objectForKey: @"code"] integerValue];
            
            result = [((NSDictionary *) responseObject) objectForKey: @"data"] ;
            msg = [((NSDictionary *) responseObject) objectForKey: @"msg"] ;
            
         

            
        }
        
        
    }
    
    if (result == nil) {
        result = @[];
    }
    if(msg == nil) {
    msg = @"";
    }
    
    //    QLog(@"%d-%@-%@",code,msg,result);
    if (code == 0) {
        code = 200;
    }
    
    return @[[NSString stringWithFormat:@"%ld",(long)code],msg,result];
}


+ (void )postRequestWithURL: (NSString *)curl  // IN
                 postParems: (NSMutableDictionary *)postParems // IN
                  postImage: (UIImage *)img
                picFileName: (NSString *)picFileName
                complection: (void (^)(NSInteger index, NSString * msg, id content)) complection;
{
    static NSString * const FORM_FLE_INPUT = @"file";
 
    NSString * baseURL = FILEURL;
    NSString * url = [NSString stringWithFormat:@"%@%@",baseURL,curl];
    
    //    NSString *TWITTERFON_FORM_BOUNDARY = @"----WebKitFormBoundaryT1HoybnYeFOGFlBR";
    NSString *TWITTERFON_FORM_BOUNDARY = @"--26106d6a-2e40-4d39-9e4c-49359485e91d";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:30];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    
    
    NSData * data = UIImageJPEGRepresentation(img, 0.5);
    //QLog(@"%@",data);
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //参数的集合的所有key的集合
    NSArray *keys= [postParems allKeys];
    
    //遍历keys
    for(int i=0;i<[keys count];i++)
    {
        //得到当前key
        NSString *key=[keys objectAtIndex:i];
        
        //添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //添加字段名称，换2行
        [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
        //添加字段的值
        [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
        
        NSLog(@"添加字段的值==%@",[postParems objectForKey:key]);
    }
    //  QLog(@"%@",body);
    
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,picFileName];
    
    
    //[body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename="%@"\r\n",];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    
    QLog(@"%@",body);
    
    
    
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    // if(picFilePath){
    //将image的data加入
    [myRequestData appendData:data];
    // }
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    
    NSHTTPURLResponse *urlResponese = nil;
    NSError *error = [[NSError alloc]init];
    NSData* resultData = [NSURLConnection sendSynchronousRequest:request   returningResponse:&urlResponese error:&error];
    NSString* result= [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    NSString * msg = @"上传成功";
    NSInteger code = urlResponese.statusCode;
    QLog(@"request=%@",urlResponese);
    // QLog(@"%@error=%@",error);
    NSLog(@"返回结果=====%@",result);
    if([urlResponese statusCode] ==200){
        // NSLog(@"返回结果=====%@",result);
        
        
    } else {
        msg=@"上传失败";
    }
    
    id jsonData =  [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error: nil];
    QLog(@"%@",jsonData);
    
    complection(code,msg,jsonData);
    
    
}


@end
