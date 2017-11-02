//
//  HttpRequest.h
//  Yl
//
//  Created by qzp on 2017/2/14.
//  Copyright © 2017年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpBaseRequest : NSObject
typedef NS_ENUM(NSInteger, MethodType) {
    MethodTypePOST,
    MethodTypeGET,
    MethodTypePUT,
    MethodTypeDELETE
};
typedef NS_ENUM(NSInteger,HttpResponseCode) {
    HttpResponseCodeNoEmployee = 2001,
    HttpResponseCodeSuccess = 200,
    HttpResponseCodeNotJurisdiction = 2006
};

+ (void) requestWithURL: (NSString *) url
                 params: (id) params method: (MethodType) method
             completion: (void(^)(NSInteger code, NSString * msg, id anyobject)) completion;

+ (void) requestWithURL: (NSString *) url
                 params: (id) params method: (MethodType) method
                   sign: (id) sign
             completion: (void(^)(NSInteger code, NSString * msg, id anyobject, id rSign)) completion;

////文件上传
//+ (void )postRequestWithURL: (NSString *)url  // IN
//                 postParems: (NSMutableDictionary *)postParems // IN
//                  postImage: (UIImage *)img
//                picFileName: (NSString *)picFileName
//                complection: (void (^)(NSInteger index, NSString * msg, id content)) complection;


@end
