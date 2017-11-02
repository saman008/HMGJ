
//
//  addNewShopTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/10/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class addNewShopTableViewController: TabBaseTableViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var priceTextField: UITextField!
    
    
    @IBOutlet weak var unitTextField: UITextField!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var imageBtn: UIButton!
    
    
    
    @IBOutlet weak var okBtn: UIButton!
    
    
    var imgurl = ""
    
    
    var shopGoodsCodeStr = ""
    var nameStr = ""
    var priceStr = ""
    var unitStr = ""
    
    //图片上传下弹窗
    let choiceArray0 = ["拍照","从手机相册选择"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "添加新商品"
        
        self.imageBtn.addTarget(self, action: #selector(upload), for: UIControlEvents.touchUpInside)
        
        self.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
        self.priceTextField.delegate = self
        
        if shopGoodsCodeStr.characters.count != 0{
            self.nameTextField.text = nameStr
            self.priceTextField.text = priceStr
            self.unitTextField.text = unitStr
            self.headerImageView.sd_setImage(with: URL.init(string: imgurl), placeholderImage: nil)
            
        }
        
    }

    func okAction(){
        if self.nameTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请填写商品名字", T: self)
            
            return
        }
        
        if self.priceTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请填写商品价格", T: self)
            
            return
        }
        
        if self.unitTextField.text?.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请填写商品单位", T: self)
            
            return
        }
        
        if (self.unitTextField.text?.characters.count)! > 2{
            
            ToolManger.defaultShow(Str: "商品单位最多2个字", T: self)
            
            return
        }
        
        
        if self.imgurl.characters.count == 0{
            
            ToolManger.defaultShow(Str: "请选择商品图片", T: self)
            
            return
        }
        let pricea = (self.priceTextField.text! as NSString).doubleValue
        
        let priceb = pricea * 100
        //编辑
        if shopGoodsCodeStr.characters.count != 0{
            
            
            
            self.getNetData(url: activitychannelshopgoodsmodifySTR, para: ["shopGoodsCode":shopGoodsCodeStr,"shopQRCode":shopQRCodeID,"name":self.nameTextField.text!,"price":priceb,"imgUrl":self.imgurl,"unit":self.unitTextField.text!])
        }
        //添加
        else{
            
            self.getNetData(url: activitychannelshopgoodsuploadSTR, para: ["shopQRCode":shopQRCodeID,"name":self.nameTextField.text!,"price":priceb,"imgUrl":self.imgurl,"unit":self.unitTextField.text!])
        }
        

        
    }
    

}
//MARK -键盘代理
extension addNewShopTableViewController{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        let expression = "^([0-9]{0,100})((\\.)[0-9]{0,2})?$"//"^[0-9]*((\\\\.|,)[0-9]{0,2})?$"
        let regex = try! NSRegularExpression(pattern: expression, options: NSRegularExpression.Options.allowCommentsAndWhitespace)
        let numberOfMatches = regex.numberOfMatches(in: newString, options:NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, (newString as NSString).length))
        
        return numberOfMatches != 0
        
    }
    
    
    
}

//MARK - 相册相关
extension addNewShopTableViewController{

    func upload(){
        let alert = UIAlertController(title: nil, message: "请选择上传方式", preferredStyle: .actionSheet)
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
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            //headerView.setHeadImage(image)
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.headerImageView.image = image
            

            //上传图片
            self.changePortrait(image: self.headerImageView.image!)
            
            
            
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
extension addNewShopTableViewController{

    
    //上传和编辑商品信息
    func getNetData(url:String,para:[String:Any]){
        
        NetworkTools.requestAnyData(type: .post, URLString: url, parameters: para, encoding: "post", T: self, ShowStr: true, error: true, finishedCallback: { (data) in
            ToolManger.defaultShow(Str: "上传成功", T: self)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0, execute: {
                
                self.navigationController?.popViewController(animated: true)
                
            })
            
        }) { (error) in
            
            
        }


    }
    //图片上传
    func changePortrait(image:UIImage){
        let imagedata = UIImageJPEGRepresentation(image, 0.3)
        
        let imageName = "\(NSDate())" + ".png"
        let para = ["mid":"123","source":"iOS","alias":"huodongtu","width":"90","height":"98"]
        
        TBUploadDataManager.share.uploadLocalData(data: imagedata!, parameters: para, hostUrl: singleWithThumbSTR, withName: "file", fileName: imageName, type: tbUploadType.formdata, comparBlock: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    let data = response.result.value as AnyObject
                    
                    
                    if let data1 = data.value(forKey: "data") as? NSDictionary{
                        
                        if let imgurl1 = data1["imageThumbUrl"] as? String{
                            
                            self.imgurl = imgurl1
                            
                        }
                        
                    }
                    

                    
                }
            case .failure(let encodingError):
                print(encodingError)

                
            }
        })
        
    }
}
