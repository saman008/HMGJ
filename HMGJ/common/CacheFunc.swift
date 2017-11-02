//
//  CacheFunc.swift
//  YCL
//
//  Created by Apple on 2017/3/23.
//  Copyright © 2017年 app. All rights reserved.
//

import UIKit
import Foundation
class CacheFunc: NSObject {
    /**
     *  获取沙盒路径
     */
    static func cachePath(proName:String)->String
    {

        let cachePath = NSHomeDirectory() + "/Library/Caches/proData/" + proName+"/"
        let FM:FileManager = FileManager.default
        //判断当前路径是否存在
        if !FM.fileExists(atPath: cachePath, isDirectory: nil)
        {
            do {
                try FM.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError
            {
                print("存储路径错误-->\(error)")
            }
        }
        return cachePath
    }
    //存储缓存
    static func saveDataToCache(proName:String,Data:NSData) -> ()
    {
       // let data11 = NSKeyedArchiver.archivedData(withRootObject: arra1)
        let pathStr = self.cachePath(proName: proName)+"\(proName)"
        print("存路径--->\(pathStr)")
        Data.write(toFile: pathStr, atomically: true)
    }
    //取缓存
    static func getDataFromCache(proName:String) -> NSData
    {
        let pathStr = self.cachePath(proName: proName)+"\(proName)"
        print("路径--->\(pathStr)")
        let data:NSData = NSData(contentsOfFile: pathStr)!
        //let arra2 = NSKeyedUnarchiver.unarchiveObject(with: data11)
        return data
          
    }
    
//    1.将数组转换成NSData
//    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:nil];
    
    
//    4.将NSData转换成(NSString, NSArray)
//    
//    id jsonObject = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingAllowFragments error:nil];
//    NSArray *array = (NSArray *)jsonObject;// 或者 NSString *string = (NSString *)jsonObject;
    
    
//    let data:NSData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    
//    // 默认为内容数据的十六进制编码
//    let dataFromNSData1 = data.description
//    
//    let dataFromNSData2:NSString? = NSString(data: data, encoding: NSUTF8StringEncoding)
//    
//    let dataFromNSData3:NSString? = NSString(bytes: data.bytes, length: data.length, encoding: NSUTF8StringEncoding)
//    回到顶部
//    4、NSData 的比较
//    
//    let data1:NSData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    let data2:NSData = NSData(data: data1)
//    
//    // 比较两个对象的地址是否一致
//    let bl1:Bool = data1 === data2
//    
//    // 比较两个对象的长度及每字节的数据是否相同
//    let bl2:Bool = data1.isEqualToData(data2)
//    回到顶部
//    5、NSData 的存储
//    
//    let data:NSData = "Hello World".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//    
//    // 将数据写入 file
//    let bl1:Bool = data.writeToFile(NSHomeDirectory().stringByAppendingString("/Desktop/test.txt"), atomically: true)
//    
//    // 将数据写入 URL，该方法只支持 file:// 路径的文件写入，并不能对远程如 http:// 等类型文件进行写入
//    let bl2:Bool = data.writeToURL(NSURL(string: "file://".stringByAppendingFormat("%@%@",
//                                                                                   NSHomeDirectory(), "/Desktop/test.txt"))!, atomically: true)
    
}
