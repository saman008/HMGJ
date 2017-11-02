//
//  QQScanViewController.swift
//  swiftScan
//
//  Created by xialibing on 15/12/10.
//  Copyright © 2015年 xialibing. All rights reserved.
//

import UIKit
import Alamofire


class QQScanViewController: LBXScanViewController {
    
    
    /**
    @brief  扫码区域上方提示文字
    */
    var topTitle:UILabel?

    /**
     @brief  闪关灯开启状态
     */
    var isOpenedFlash:Bool = false
    
// MARK: - 底部几个功能：开启闪光灯、相册、我的二维码
    
    //底部显示的功能项
    var bottomItemsView:UIView?
    
    //相册
    var btnPhoto:UIButton = UIButton()
    
    //闪光灯
    var btnFlash:UIButton = UIButton()
    
    //我的二维码
    var btnMyQR:UIButton = UIButton()


    var amountStr = ""
    var label2Str = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫描二维码"
        
        //需要识别后的图像
        setNeedCodeImage(needCodeImg: true)
        
        //框向上移动10个像素
        scanStyle?.centerUpOffset += 10

        drawBottomItems()
       
        
        
        //
        let label = UILabel()
        label.text = "扫描客户的“付款码“，即可收款"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white

        label.center = CGPoint.init(x: ScreenW/2-120, y: self.view.center.y + 100)
        label.textAlignment = .center
        label.size = CGSize.init(width: 240, height: 21)
        self.view.addSubview(label)
        
        //
        let label1 = UILabel()
        label1.text = ""
        label1.font = UIFont.systemFont(ofSize: 14)
        label1.textColor = UIColor.white
        
        label1.center = CGPoint.init(x: self.view.center.x - 100, y: 30)
        label1.textAlignment = .center
        label1.size = CGSize.init(width: 200, height: 21)
        self.view.addSubview(label1)
        //金额
        let label2 = UILabel()
        label2.text = "收款:\(label2Str)元"
        label2.font = UIFont.systemFont(ofSize: 14)
        label2.textColor = UIColor.white
        
        label2.center = CGPoint.init(x: self.view.center.x - 100, y: 80)
        label2.textAlignment = .center
        label2.size = CGSize.init(width: 200, height: 21)
        self.view.addSubview(label2)
        
//        let sucVC = UIStoryboard.init(name: "QQScanSB", bundle: nil).instantiateViewController(withIdentifier: "QQScanSB") as! QQScanSucTableViewController
//        
//        sucVC.hidesBottomBarWhenPushed = true
//        
//        self.navigationController?.pushViewController(sucVC, animated: true)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
    }
    
//    extension QRCodeViewController : AVCaptureMetadataOutputObjectsDelegate
//    {
//        func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!)
//        {
//            //        1.获取到文字信息
//            infomationLabel.text = (metadataObjects.last as AnyObject).stringValue
//            //        2.清除之前画的图层
//            clearLayers()
//            guard let metadata = metadataObjects.last as? AVMetadataObject else {
//                return
//            }
//            let object = previewLayer.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
//            //        3.对扫描到的二维码进行描边
//            drawLines(object:object)
//            
//        }
//    }
//    
  
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        
        for result:LBXScanResult in arrayResult
        {
            if let str = result.strScanned {
                print(str)

                if let aa = UserDefaults.standard.string(forKey: "role"){
                    
                    if aa != "0"{
                        
                        ToolManger.defaultShow(Str: "只有员工可以扫码", T: self)
                        self.navigationController?.popViewController(animated: true)
                        
                        return
                        
                    }
                    
                }
                
                let waitVC = UIStoryboard.init(name: "waitSB", bundle: nil).instantiateViewController(withIdentifier: "waitVC") as! waitTableViewController
                
                waitVC.hidesBottomBarWhenPushed = true
                waitVC.Str = str
                waitVC.amountStr = amountStr
                self.navigationController?.pushViewController(waitVC, animated: true)
                
                //self.getNetData(authCode: str)
                
            }
        }
        
        let result:LBXScanResult = arrayResult[0]
        print("========")
        print(result)
        
//        let vc = ScanResultController()
//        vc.codeResult = result
//        navigationController?.pushViewController(vc, animated: true)
    }
    

    
//    - (void) start:(NSString *) text {
//    av = [[AVSpeechSynthesizer alloc] init];
//    av.delegate = self;
//    
//    AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString: text];
//    utterance.rate = 0.5;
//    
//    AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
//    utterance.voice= voice;
//    
//    
//    [av speakUtterance: utterance];
//    }
    
    func drawBottomItems()
    {
        if (bottomItemsView != nil) {
            
            return;
        }
        
        let yMax = self.view.frame.maxY - self.view.frame.minY
        
        bottomItemsView = UIView(frame:CGRect(x: 0.0, y: yMax-100,width: self.view.frame.size.width, height: 100 ) )
        
        
        bottomItemsView!.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        self.view.addSubview(bottomItemsView!)
        
        
        let size = CGSize(width: 65, height: 87);
        
        self.btnFlash = UIButton()
        btnFlash.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        btnFlash.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        btnFlash.addTarget(self, action: #selector(QQScanViewController.openOrCloseFlash), for: UIControlEvents.touchUpInside)
        
        
        self.btnPhoto = UIButton()
        btnPhoto.bounds = btnFlash.bounds
        btnPhoto.center = CGPoint(x: bottomItemsView!.frame.width/4, y: bottomItemsView!.frame.height/2)
        btnPhoto.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_photo_nor"), for: UIControlState.normal)
        btnPhoto.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_photo_down"), for: UIControlState.highlighted)
        btnPhoto.addTarget(self, action: Selector(("openPhotoAlbum")), for: UIControlEvents.touchUpInside)
        
        
//        
//        bottomItemsView?.addSubview(btnFlash)
//        bottomItemsView?.addSubview(btnPhoto)
       
        let label = UILabel()
        label.text = "将二维码放入框内，自动扫描"
        label.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        label.center = CGPoint(x: bottomItemsView!.frame.width/2, y: bottomItemsView!.frame.height/2)
        self.bottomItemsView?.addSubview(label)
        //self.view.addSubview(bottomItemsView!)
        
    }
    
    //开关闪光灯
    func openOrCloseFlash()
    {
        scanObj?.changeTorch();
        
        isOpenedFlash = !isOpenedFlash
        
        if isOpenedFlash
        {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_down"), for:UIControlState.normal)
        }
        else
        {
            btnFlash.setImage(UIImage(named: "CodeScan.bundle/qrcode_scan_btn_flash_nor"), for:UIControlState.normal)
        }
    }
    

}

extension QQScanViewController{
    
    func getNetData(authCode:String){
        

        
        
        NetworkTools.requestData(type: .post, URLString: scancodepayStr, parameters: ["amount":amountStr,"authCode":authCode,"shopQRCode":shopQRCodeID,"staffMId":memberId], encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let outTradeNoStr = dataDict["outTradeNo"] as? String{
                    
                    let QQScanSBVC = UIStoryboard.init(name: "QQScanSB", bundle: nil).instantiateViewController(withIdentifier: "QQScanSB") as! QQScanSucTableViewController
                    
                    QQScanSBVC.outTradeNoStr = outTradeNoStr
                    QQScanSBVC.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(QQScanSBVC, animated: true)
                    
                }
                
            }
            

        }) { (error) in
            
            
        }
        
        
    }
    
    
}
