//
//  MeVersionTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire

class MeVersionTableViewController: TabBaseTableViewController {

    
    @IBOutlet weak var cellPhoneLabel: UILabel!
    
    @IBOutlet weak var zhifuCell: UITableViewCell!
    var settleAcount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "系统设置"
        if let aa = UserDefaults.standard.string(forKey: "role"){
            
            if aa == "0"{
                self.zhifuCell.isHidden = true
            }else{
             
                self.checkGeNetData()
            }
            
        }
        
        self.cellPhoneLabel.text = PhoneNumber
        
    }
    //推送
    //http://blog.csdn.net/studying_ios/article/details/53114461

    
}
extension MeVersionTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            
            //更换手机号
            if indexPath.row == 0{
                
                let MeChangePhoneSB = UIStoryboard.init(name: "MeChangePhoneSB", bundle: nil).instantiateViewController(withIdentifier: "MeChangePhoneSB") as! MeChangePhoneTableViewController
                
                MeChangePhoneSB.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(MeChangePhoneSB, animated: true)
                
            }
            //修改登录密码
            else if indexPath.row == 1{
    
                let changePasswordVC = UIStoryboard(name: "changePasswordSB", bundle: nil).instantiateViewController(withIdentifier: "changePasswordVC") as! changePasswordTableViewController
    
                
                changePasswordVC.hidesBottomBarWhenPushed = true
    
                self.navigationController?.pushViewController(changePasswordVC, animated: true)
                
//                let MeChangePasswordSB = UIStoryboard.init(name: "MeChangePasswordSB", bundle: nil).instantiateViewController(withIdentifier: "MeChangePasswordSB") as! MeChangePasswordTableViewController
//                
//                MeChangePasswordSB.hidesBottomBarWhenPushed = true
//                
//                self.navigationController?.pushViewController(MeChangePasswordSB, animated: true)
            }
            //修改支付密码
            else if indexPath.row == 2{
                

                if settleAcount == "1"{
                    let changeBankVC = UIStoryboard.init(name: "changeBankSB", bundle: nil).instantiateViewController(withIdentifier: "changeBankVC") as! changeBankTableViewController
                    changeBankVC.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(changeBankVC, animated: true)
                    
                    
                }else{
                    ToolManger.defaultShow(Str: "请去开通红码钱包业务", T: self)
                }
                
            }
            
            
        }
        if indexPath.section == 1{
            
            if indexPath.row == 0{
                
                
                //设置推送及推送语音播报跳转到系统
                 UIApplication.shared.openURL(URL.init(string: UIApplicationOpenSettingsURLString)!)
                
            }
            
            //意见反馈
            if indexPath.row == 1{
                
                let MeadviceVC = UIStoryboard.init(name: "adviceSB", bundle: nil).instantiateViewController(withIdentifier: "MeadviceVC") as! MeadviceTableViewController
                
                
                MeadviceVC.hidesBottomBarWhenPushed = true
                
                
                self.navigationController?.pushViewController(MeadviceVC, animated: true)
                
            }
            
            //版本信息
            else if indexPath.row == 2{
                ToolManger.defaultShow(Str: "已经是最新版", T: self)
                //            //http://www.jianshu.com/p/25b008874360
                //            //            let cigareteVC = UIStoryboard(name: "CigaretteStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CigaretteLoginVC")
                //            //            cigareteVC.hidesBottomBarWhenPushed = true
                //            //
                //            //            self.navigationController?.pushViewController(cigareteVC, animated: true)
                //            self.checkUpdateForAppID(ID: "1", newVersionHandler: {_,_ in
                //                let alert = UIAlertController(title: "", message: "有新版本", preferredStyle: UIAlertControllerStyle.alert)
                //
                //
                //                let okAction = UIAlertAction(title: "更新", style: UIAlertActionStyle.default, handler: { (Action) in
                //                    if let URL = NSURL(string: "https://itunes.apple.com/us/app/idinlee_apple@qq.com?ls=1&mt=8") {
                //                        UIApplication.shared.openURL(URL as URL)
                //                    }
                //
                //                })
                //
                //                let noAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                //                
                //                alert.addAction(okAction)
                //                
                //                alert.addAction(noAction)
                //                
                //                self.present(alert, animated: true, completion: nil)
                //                
                //            })
            }
            
        }
        
        //退出登录
        if indexPath.section == 2{
            
            //两句代码删除所有userdefault缓存
            let appDomain = Bundle.main.bundleIdentifier
            
            UserDefaults.standard.removePersistentDomain(forName: appDomain!)
            
            //增加这句 广告页面不自动跳转
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
            
            let logon = UIStoryboard.init(name: "LoginSB", bundle: nil).instantiateViewController(withIdentifier: "loginVC") as! loginTableViewController
            self.view!.window?.rootViewController = logon
            
            self.present(logon, animated: true, completion: nil)
        }
    }
    
    
    
}

extension MeVersionTableViewController{
    
    //1.1.1	E账户详细信息查询******************
    func checkGeNetData(){

        NetworkTools.requestAnyData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.acount.info","version":"1.0","memberId":memberId], encoding: "post", T: self, ShowStr: false, error: false, finishedCallback: { (data) in
            self.settleAcount = "1"
            
        }) { (error) in
            
            
        }

        
        
        
    }
    //inlee_apple@qq.com
    func checkUpdateForAppID(ID: String, newVersionHandler: @escaping (_ thisVerion: String, _ newVersion: String) -> Void) {
        Alamofire.request("http://itunes.apple.com/lookup?id=inlee_apple@qq.com", method: .get, parameters: ["":""], encoding: JSONEncoding.default, headers: nil).responseJSON { (data) in
            
            if let data1 = data.result.value as? AnyObject{
                
                if let resultsArray = data1["results"] as? NSArray{
                    
                    if let resultsDict = resultsArray[0] as? NSDictionary{
                        
                        if let versionStr = resultsDict["version"] as? String{
                            
                            if currentVersion != versionStr{
                                newVersionHandler(currentVersion, versionStr)
                            }else{
                                let alert = UIAlertController(title: "", message: "已经是最新版本", preferredStyle: UIAlertControllerStyle.alert)
                                
                                
                                let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: nil)
                                
                                let noAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                                
                                alert.addAction(okAction)
                                
                                alert.addAction(noAction)
                                
                                self.present(alert, animated: true, completion: nil)
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            
        }

        
        
    }
}
//extension MeVersionTableViewController{
//    // 创建长连接
//    func creatSocketToConnectServer() -> Void {
//        if let prot = UInt16(protTF.text!){
//            do {
//                try myTCPSocket?.connect(toHost: hostTF.text!, onPort: prot, withTimeout: 20)
//            } catch {
//                print(error)
//                ShowTextHudInView("Socket连接服务器失败")
//            }
//        }else{
//            ShowTextHudInView("转换UInt16失败")
//        }
//    }
//    
//    // 长连接建立后 开始发送心跳包
//    func socketDidConnectBeginSendBeat() -> Void {
//        hostTimer?.invalidate()
//        hostTimer = nil
//        hostTimer = Timer.scheduledTimer(timeInterval: TimeInterval(60),
//                                         target: self,
//                                         selector: #selector(sendBeat),
//                                         userInfo: nil,
//                                         repeats: true)
//        RunLoop.current.add(hostTimer!, forMode: RunLoopMode.commonModes)
//    }
//    // 向服务器发送心跳包
//    func sendBeat() {
//        if let data = StringUtils.data(fromHex: "4842021310"){
//            myTCPSocket?.write(data, withTimeout: -1, tag: 0)
//            myTCPSocket?.readData(withTimeout: -1, tag: 0)
//        }else{
//            ShowTextHudInView("Socket需要发送的心跳data为空")
//        }
//    }
//    
//    //代理
//    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
//        ShowTextHudInView("Socket连接服务器成功")
//        myTCPSocket?.readData(withTimeout: -1, tag: 0)
//        socketDidConnectBeginSendBeat()
//    }
//    
//    // 接收到数据
//    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) -> Void {
//        //        myTCPSocket?.write(data, withTimeout: -1, tag: 0)
//        myTCPSocket?.readData(withTimeout: -1, tag: 0)
//        self.textView.text = "收到服务器指令:\(StringUtils.hex(from: data))"
//        DispatchQueue.main.async { [unowned self] in
//            if let str = StringUtils.hex(from: data){
//                if str.hasPrefix("4442") {
//                    self.saveLogToFile(logStr: str, logTitle: "收到服务器原始数据")
//                    //处理后转发给蓝牙
//                    let start = str.index(str.startIndex, offsetBy: 6)
//                    let end = str.index(str.endIndex, offsetBy: -4)
//                    let range = start..<end
//                    let dataStr = str.substring(with: range)
//                    let lenght = (dataStr.characters.count / 2)
//                    self.saveLogToFile(logStr: "99960200\(self.ToHex(tmpid: lenght))\(dataStr)", logTitle: "收到服务器原始数据处理后发给蓝牙的数据")
//                    if let data = StringUtils.data(fromHex: "99960200\(lenght)\(dataStr)"){
//                        self.sendData(data: data)
//                    }
//                }
//            }
//        }
//    }
//    
//    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) -> Void {
//        myTCPSocket?.readData(withTimeout: -1, tag: 0)
//    }
//    
//    // 断开连接
//    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) -> Void {
//        ShowTextHudInView("socket已经断开连接,正在重连")
//        creatSocketToConnectServer()
//    }
//    
//}
