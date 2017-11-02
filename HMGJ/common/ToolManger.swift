//
//  ToolManger.swift
//  FunLife
//
//  Created by Forever on 2017/6/19.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit
import MBProgressHUD

let APPkey = "38c285d7254da04ea2199585"//"fae7fd212942ec1f2078f707"//

let APIKey = "d7bd68be3e05fc84ad656bafd665339b"
var typeA = 1
let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height



var IDStr = "ae8e2c-9c2d-4fbf-98f6-a4473a85b9ee"
var PORTRAIT = ""
var PHONE = ""
var NICKNAME = ""

var shopID = "0d8abdbc-dc58-449e-a960-9e602dabd442"
var SHOPMASTER = ""
var SHOPICON = ""

//全局sh判断是否入驻
var SH = ""

//全图登录参数
var LOGINSTR = ""
//var shopID = "1"
//黑色颜色
let NColor = UIColor.init(red: 49/255, green: 50/255, blue: 54/255, alpha: 1)
let BColor = UIColor.init(red: 52/255, green: 55/255, blue: 64/255, alpha: 1)
let TColor = UIColor.init(red: 33/255, green: 34/255, blue: 38/255, alpha: 1)
//白色颜色
let WColor = UIColor.init(red: 235/255, green: 238/255, blue: 245/255, alpha: 1)
let wColor = UIColor.init(red: 116/255, green: 120/255, blue: 131/255, alpha: 1)
//红色颜色
let RColor = UIColor.init(red: 214/255, green: 48/255, blue: 92/255, alpha: 1)
let rColor = UIColor.init(red: 255/255, green: 0, blue: 0, alpha: 1)
//蓝色
let LColor = UIColor.init(red: 61/255, green: 148/255, blue: 176/255, alpha: 1)
//let rColor - UIColor.init(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
class ToolManger: NSObject {
    
    //    //弹窗
    //    static func LA(Str:String,PStr:String,T:AnyObject) -> String{
    //        var aa = ""
    //        let alertController = UIAlertController(title: Str,
    //                                                message: "", preferredStyle: .alert)
    //        alertController.addTextField {
    //            (textField: UITextField!) -> Void in
    //            textField.placeholder = PStr
    //        }
    //        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
    //        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
    //            action in
    //            //也可以用下标的形式获取textField let login = alertController.textFields![0]
    //            let login = alertController.textFields!.first!
    //
    //            aa = login.text!
    //
    //
    //        })
    //        alertController.addAction(cancelAction)
    //        alertController.addAction(okAction)
    //        T.present(alertController, animated: true, completion: nil)
    //        return aa
    //    }
    
    
    ///计算指定字符串的大小
    static func calculateStringSize(str:String,maxW:CGFloat,maxH:CGFloat,fontSize:CGFloat) -> CGSize{
        //1.将字符串转换成OC的字符串
        let ocStr = str as NSString
        //2.计算
        return ocStr.boundingRect(with: CGSize.init(width: maxW, height: maxH), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)], context: nil).size
        
    }
    
    static func strendstart(aa:String,startInt:Int,endInt:Int) -> String{
        let startIndex = aa.index(aa.startIndex, offsetBy:startInt)
        let endIndex = aa.index(startIndex, offsetBy:endInt)
        let result = aa.substring(with: startIndex..<endIndex)
        
        return result
    }
    //    ///计算指定时间戳对应的时间到当前时间的时间差
    //    static func stringtoTimeStamp(string:String) -> String{
    //        var dfmatter = DateFormatter()
    //
    //        dfmatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
    //        let timeInterval:TimeInterval = String.timein
    //    }
    static func transtimeStr(timeStamp:String,Str:String) -> String{
        
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp)!
        let date = Date(timeIntervalSince1970: timeInterval)
        
        //格式话输出
        let dformatter = DateFormatter()
        //dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dformatter.dateFormat = Str
        
        return dformatter.string(from: date)
    }
    
}


//JSON
extension ToolManger{
    static func toJSONString(dict:[String : String])->String{
        
        let data1 = try! JSONSerialization.data(withJSONObject: dict, options:[])
        let strJson:String=String(data: data1, encoding: String.Encoding.utf8)!
        
        return strJson
        
    }
    
}

//加减时间
extension ToolManger{
    static func dateTime(currentDate:Date,ii:Int) -> Date{
        //获取当前时间
        let calendar = Calendar.current
        //let currentDate = Date()
        
        var newDateComponents = DateComponents()
        //newDateComponents.month = 2
        newDateComponents.day = ii
        let calculatedDate = calendar.date(byAdding: newDateComponents, to: currentDate)
        print(calculatedDate)
        return calculatedDate!
    }
    static func monthTime(currentDate:Date,ii:Int) -> Date{
        //获取当前时间
        let calendar = Calendar.current
        //let currentDate = Date()
        
        var newDateComponents = DateComponents()
        newDateComponents.month = ii
        //newDateComponents.day = ii
        let calculatedDate = calendar.date(byAdding: newDateComponents, to: currentDate)
        print(calculatedDate)
        return calculatedDate!
    }
}

//MARK: - 颜色的拓展
extension UIColor{
    
    ///通过0-255的RGB值去创建一个颜色对象
    static func RGBColor(R:CGFloat,G:CGFloat,B:CGFloat,A:CGFloat) -> UIColor{
        
        return UIColor.init(red: R/255, green: G/255, blue: B/255, alpha: A)
    }
    
    static func randomColor()->UIColor{
        
        let colorValue = [(108,209,0),(255,128,0),(204,102,155),(102,255,255),(255,240,70)]
        let i = Int(arc4random()%5)
        let rgbValue = colorValue[i]
        return self.RGBColor(R: CGFloat(rgbValue.0), G:CGFloat(rgbValue.1), B: CGFloat(rgbValue.2), A: 1)
        
    }
}


//菊花圈
extension ToolManger{
    
    //延迟隐藏
    static func yanchiShow(T:AnyObject,Str:String){
        var hud = MBProgressHUD.showAdded(to: T.view, animated: true)
        hud.labelText = Str
        //背景渐变效果
        hud.dimBackground = true
        
        //延迟隐藏
        hud.hide(true, afterDelay: 20)
      
    }
    
    //隐藏
    static func hideShow(T:AnyObject){
        
        MBProgressHUD.hide(for: T.view, animated: true)
        
    }
    
    static func MBShow(Str:String,T:AnyObject){
        
        //创建网络活动指示器,在实际使用的时候，在所有控件之后进行创建，并且添加到self.view上，否则会被覆盖
        var hud = MBProgressHUD.showAdded(to: T.view, animated: true)
        //设置加载的文字
        hud.labelText = Str
        //设置文字的颜色
        hud.labelColor = UIColor.white
        //设置小菊花的颜色
        hud.activityIndicatorColor = UIColor.white
        //设置背景色
        hud.color = UIColor(white: 0, alpha: 2.0)
        T.view.addSubview(hud)
    }
    
    static func defaultShow1(Str:String,T:AnyObject){
        let hud = MBProgressHUD.showAdded(to: T.view, animated: true)
        
        hud.mode = MBProgressHUDMode.text
        
        hud.label.text = Str
        
        hud.label.font = UIFont.systemFont(ofSize: 14)
        
        hud.label.textColor = UIColor.red
        
        hud.bezelView.color = UIColor.black
        
        hud.removeFromSuperViewOnHide = true
        
        hud.hide(animated: true, afterDelay: 3)
        
    }
    
    static func defaultShow(Str:String,T:AnyObject){
        var hud = MBProgressHUD.showAdded(to: T.view, animated: true)
        hud.labelText = Str
        //背景渐变效果
        hud.dimBackground = true
        
        //延迟隐藏
        hud.hide(true, afterDelay: 1.5)
    }
    static func rmksignParame(dict:[String:String]) -> [String:String]{
        var ddict = dict
        for (key,value) in ddict{
            if value.characters.count == 0{
                ddict.removeValue(forKey: key)
            }
        }
        let str1 = ddict.signParame()
        return str1
    }
}

extension Dictionary{
    func signParame () ->[String : String]
    {
        
        var sign = ""
        let secretkey:String="xQbZV3GItKLvTUrAqRRHppNvsjfDcxT8"
        var result = [String : String]()
        //把其参数按key升序排序
        let signParameters =  self.sorted { (s1, s2) -> Bool in
            return String(describing: s1.0).compare(String(describing: s2.0)) == ComparisonResult.orderedAscending
        }
        
        //遍历字典数组，拼接字符串（secretkey+key1value1key2velue2key3value3）
        print(signParameters)
        for(key,value) in signParameters
        {
            
            result[String(describing: key)] = value as? String
            
            
            if sign == ""{
                
                sign="\(key)=\(value)"
            }else{
                
                sign="\(sign)&\(key)=\(value)"
            }
            
            //sign="\(sign)&\(sign)"
        }
        sign = "\(sign)\(secretkey)"
        print("sign---\(sign)")
        
        //将sign插入到传递给接口的参数parameters
        result["sign"] = sign.md5()
        print(result)
        
        return result
    }
}
