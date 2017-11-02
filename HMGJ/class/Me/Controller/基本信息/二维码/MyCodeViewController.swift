//
//  MyCodeViewController.swift
//  swiftScan
//
//  Created by xialibing on 15/12/10.
//  Copyright © 2015年 xialibing. All rights reserved.
//

import UIKit
import KVNProgress

class MyCodeViewController: BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    @IBOutlet weak var weixinImageView: UIImageView!
    
    @IBOutlet weak var weixinLabel: UILabel!
    @IBOutlet weak var zhifubaoImageView: UIImageView!
    
    @IBOutlet weak var zhifubaoLabel: UILabel!
    
    @IBOutlet weak var jingdongImageView: UIImageView!
    
    @IBOutlet weak var jingdongLabel: UILabel!
    @IBOutlet weak var yizhifuImageView: UIImageView!
    
    @IBOutlet weak var yizhifuLabel: UILabel!
    //二维码
    var qrView = UIView()
    //var qrImgView = UIImageView()
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    var shopqrCodeStr = ""
    var titleStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "红码收款"
        
        self.titleLabel.text = titleStr
        self.titleLabel.text = UserDefaults.standard.string(forKey: "shopName")
        if let aa = UserDefaults.standard.string(forKey: "shopQRCodeUrl"){
            self.shopqrCodeStr = aa
        }
        
        
        
        self.qrimage()
        self.addLongPressGestureRecognizer()
       // self.getNetData()
    }

    func qrimage(){
        /// 识别二维码图片
        JKQRCodeTool.jk_recognizeQRCodeImage(UIImage.init(named: "JKSwiftGitHub"), completionHandle: { (str, error) in
            if error != nil {
                JKLOG(error)
            } else {
                JKLOG(str)
                
                /// 生成二维码图片
                
                /// 红色d
                /*
                 */
                JKQRCodeTool.jk_QRCodeImage(withString: self.shopqrCodeStr, size: CGSize.init(width: 500, height: 500), completionHandle: { (image, error1) in
                    if error1 != nil {
                        JKLOG(error1)
                    } else {
                        
                        // 带阴影效果
                        let tool = JKQRTool.init()
                        let newImage = tool.imageBlack(toTransparent: image, withRed: 255, andGreen: 0, andBlue: 0)
                        self.qrImageView?.image = newImage
//                        //拿到图片
//                        UIImage *image2 = [UIImage imageNamed:@"1.png"];
//                        NSString *path_document = NSHomeDirectory();
//                        //设置一个图片的存储路径
//                        NSString *imagePath = [path_document stringByAppendingString:@"/Documents/pic.png"];
//                        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
//                        [UIImagePNGRepresentation(image2) writeToFile:imagePath atomically:YES];
////                        下次利用图片的地址直接来拿图片。
////                        
////                        [objc] view plain copy
////                        UIImage *getimage2 = [UIImage imageWithContentsOfFile:imagePath];
//                        
//                        let path_document = NSHomeDirectory()
//                        let imagePath = path_document.appending("/Documents/pic.png")
//                        UIImagePNGRepresentation(newImage!).in
                        
                        
                    }
                })
                

                
                
            }
        })
        
    }
    

    
    

}
extension MyCodeViewController{
    
    //添加长按手势
    func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressClick))
        self.qrImageView.isUserInteractionEnabled = true
        self.qrImageView.addGestureRecognizer(longPress)
    }
    //长按手势事件
    func longPressClick() {
        let alert = UIAlertController(nibName: "", bundle: nil)
        let cancenlAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        let okAction = UIAlertAction.init(title: "保存到手机", style: UIAlertActionStyle.default) { (action) in
            KVNProgress.show(withStatus: "正在保存")
            //取出图片
            let image = self.qrImageView.image
            
            //2.保存图片
            //将指定的图片存到相册中
            //参数1:将要保存的图片
            //参数2,参数3:图片保存后参数2调用参数3
            //注意:参数3中函数的格式是固定的
            
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(self.image(image:error:contextInfo:)), nil)
            
        }
        alert.addAction(cancenlAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
        //保存二维码
    
    func image(image:UIImage,error:NSError,contextInfo:AnyObject) {
        
        KVNProgress.showSuccess(withStatus: "保存成功")
    }
    
}

//extension MyCodeViewController{
//    
//    
//    func getNetData(){
//        
//        NetworkTools.requestDataUrl(type: .get, URLString: orderchannelpaywaylistSTR + "?shopQRCode=\(shopQRCodeID)", parameters: ["":""], T: self, finishedCallback: { (data) in
//            
//            if let data1Array = data.value(forKey: "data"){
//                
//                
//                if let modelArray = NSArray.yy_modelArray(with: erweimaPayModel.self, json: data1Array){
//                    
//                    
//                    self.dataArray.addObjects(from: modelArray)
//                    
//                    for (i,j) in self.dataArray.enumerated(){
//                        let jdd = j as? erweimaPayModel
//                        if i == 0{
//                            
//                            self.weixinImageView.sd_setImage(with: URL.init(string: jdd!.img), placeholderImage: nil)
//                            self.weixinLabel.text = jdd?.desc
//                        }else if i == 1{
//                            self.zhifubaoImageView.sd_setImage(with: URL.init(string: jdd!.img), placeholderImage: nil)
//                            self.zhifubaoLabel.text = jdd?.desc
//                        }else if i == 2{
//                            self.jingdongImageView.sd_setImage(with: URL.init(string: jdd!.img), placeholderImage: nil)
//                            self.jingdongLabel.text = jdd?.desc
//                        }else if i == 3{
//                            self.yizhifuImageView.sd_setImage(with: URL.init(string: jdd!.img), placeholderImage: nil)
//                            self.yizhifuLabel.text = jdd?.desc
//                        }
//                        
//                    }
//                    
//                }
//                
//            }
//            
//            
//            
//        }) { (error) in
//            
//            
//        }
//        
//    }
//    
//}

