//
//  certificateTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/20.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class certificateTableViewController: TabBaseTableViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var surfaceImageView: UIImageView!
    
    @IBOutlet weak var surfaceBtn: UIButton!
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var okBtn: UIButton!
    
    @IBOutlet weak var realNameTextFiled: UITextField!
    
    @IBOutlet weak var idCardTextField: UITextField!
    
    let choiceArray0 = ["拍照","从手机相册选择"]
    var NextBackValue = ""
    
    
    var faceUrl = ""
    var backUrl = ""
    
    //判断是否让所有控件失去交互
    var okornoStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "实名认证"
        
        if okornoStr == "1"{
            
            self.surfaceBtn.isUserInteractionEnabled = false
            self.backBtn.isUserInteractionEnabled = false
            self.realNameTextFiled.isUserInteractionEnabled = false
            self.idCardTextField.isUserInteractionEnabled = false
            self.okBtn.isUserInteractionEnabled = false
            self.okBtn.backgroundColor = UIColor.gray
            self.okGetNetData()
        }
        
        
        surfaceBtn.layer.borderColor = UIColor.black.cgColor
        surfaceBtn.layer.borderWidth = 1
        backBtn.layer.borderWidth = 1
        backBtn.layer.borderColor = UIColor.black.cgColor
        
        surfaceBtn.addTarget(self, action: #selector(surfaceAction), for: UIControlEvents.touchUpInside)
        backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
    }
    //获取实名认证信息
    func okGetNetData(){
        
        NetworkTools.requestData(type: .get, URLString: certgetCertSTR+"?mid=\(memberId)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data["data"] as? NSDictionary{
                
                if let realNameStr = dataDict["realName"] as? String{
                    
                    self.realNameTextFiled.text = realNameStr
                    
                }
                
                if let idCardStr = dataDict["idCard"] as? String{
                    
                    self.idCardTextField.text = idCardStr
                    
                }
                
                if let faceUrlStr = dataDict["faceUrl"] as? String{
                    
                    self.surfaceImageView.sd_setImage(with: URL.init(string: faceUrlStr), placeholderImage: nil)
                    
                    
                }
                
                if let backUrlStr = dataDict["backUrl"] as? String{
                    
                    self.backImageView.sd_setImage(with: URL.init(string: backUrlStr), placeholderImage: nil)
                }
                
                
            }
            
            self.tableView.reloadData()
        }) { (error) in
            
            
        }
        
    }
    
    
    //上传
    func okAction(){
        
        self.getNetData()
    }
    
    //正面照上传
    func surfaceAction(){
        
        
        upload()
        NextBackValue = "0"
    }
    
    
    //背面上传
    func backAction(){
        
        
        
        upload()
        NextBackValue = "1"
        
    }
    func upload(){
        let alert = UIAlertController(title: nil, message: "请选择上传身份证照片方式", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        for (id,i) in choiceArray0.enumerated(){
            let okAction = UIAlertAction(title: i, style: .default, handler: { (action:UIAlertAction) -> Void in
                
                var sourceType: UIImagePickerControllerSourceType = .photoLibrary
                switch id {
                case 0: // 拍照
                    sourceType = .camera
                case 1:// 从相册选择
                    sourceType = .photoLibrary
                default:
                    return
                }
                let pickerVC = UIImagePickerController()
                pickerVC.view.backgroundColor = UIColor.white
                pickerVC.delegate = self
                pickerVC.allowsEditing = true
                pickerVC.sourceType = sourceType
                self.present(pickerVC, animated: true, completion: nil)
                
                
            })
            alert.addAction(okAction)
        }
        
        
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

//MARK - 上传实名认证

extension certificateTableViewController{
    
    func getNetData(){
        
        if realNameTextFiled.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入正确的姓名", T: self)
            
            return
        }
        if idCardTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请输入身份证号码", T: self)
            
            return
        }
        if !idCardPublicManager.isTrueIDNumber(text: idCardTextField.text!){
            
            ToolManger.defaultShow(Str: "请输入正确的身份证号码", T: self)
            return
        }
        
        
        
        if faceUrl.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请上传正面照", T: self)
            
        }
        
        if backUrl.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请上传背面照片", T: self)
            
            return
        }
        
        
        let parta = ["mid":memberId,"realName":realNameTextFiled.text!,"idCard":idCardTextField.text!,"faceUrl":faceUrl,"backUrl":backUrl]
        
        NetworkTools.requestData(type: .post, URLString: authrealCertSTR, parameters: parta, encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in

            let ALLBankVC = UIStoryboard.init(name: "AllBankAcountCreatSB", bundle: nil).instantiateViewController(withIdentifier: "ALLBankVC") as! ALLBankTableViewController
            
            ALLBankVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(ALLBankVC, animated: true)
            
        }) { (error) in
            
            
        }
        
    }
    
    
    
}


//MARK - 相册相关
extension certificateTableViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            //headerView.setHeadImage(image)
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            //self.headerImageView.image = image
            
            
            if NextBackValue == "0"{
                
                surfaceImageView.image = image
                changePortrait(image: surfaceImageView.image!, alias: "shenfenzhengsurface")
            }else if NextBackValue == "1"{
                backImageView.image = image
                changePortrait(image: backImageView.image!, alias: "shenfenzhengback")
            }
            //上传图片
            
            
            
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension certificateTableViewController{
    func changePortrait(image:UIImage,alias:String){
        let imagedata = UIImageJPEGRepresentation(image, 0.3)
        
        let imageName = "\(NSDate())" + ".png"
        let para = ["mid":memberId,"source":"iOS","alias":alias]
        
        TBUploadDataManager.share.uploadLocalData(data: imagedata!, parameters: para, hostUrl: SingleSTR, withName: "file", fileName: imageName, type: tbUploadType.formdata, comparBlock: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    let data = response.result.value as AnyObject
                    
//                    if let msg = data.value(forKey: "msg") as? String{
//                        
//                        ToolManger.defaultShow(Str: msg, T: self)
//                        
//                    }
//                    if let data1 = data.value(forKey: "data") as? NSDictionary{
//                        

//                        
//                        
//                        
//                    }
                    
                    if let data1 = data.value(forKey: "data") as? NSDictionary{
                        
                        if let imageUrlStr = data1["imageUrl"] as? String{
                            if alias == "shenfenzhengsurface"{
                                self.faceUrl = imageUrlStr
                            }else if alias == "shenfenzhengback"{
                                self.backUrl = imageUrlStr
                            }
                            
                        }
                        

                        
                    }
                    
                    
                    //KVNProgress.showSuccess(withStatus: "上传成功")
                    //                        if let json = response.result.value{
                    //                            let suStr = (json as AnyObject).object(forKey: "success")
                    //
                    //                            if "1" == "\(suStr!)"{
                    //
                    //                            }
                    //
                    //                        }
                    //
                    //成功要干什么
                }
            case .failure(let encodingError):
                print(encodingError)
                //失败要干什么
                //KVNProgress.showSuccess(withStatus: "上传失败")
            }
        })
        
    }
    
}
