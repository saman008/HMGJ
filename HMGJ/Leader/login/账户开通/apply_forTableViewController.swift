//
//  apply_forTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/23.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress


class apply_forTableViewController: TabBaseTableViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    //商铺名称 简称 店铺照片

    
    @IBOutlet weak var shopNameLabel: UITextField!
    
    @IBOutlet weak var shopNickLabel: UITextField!

    //省市区
    @IBOutlet weak var provinceCodeBtn: UIButton!
    
    @IBOutlet weak var provinceCodeLabel: UILabel!
    
    var provinceCodeStr = ""
    @IBOutlet weak var cityCodeBtn: UIButton!
    
    @IBOutlet weak var cityCodeLabel: UILabel!
    
    var cityCodeStr = ""
    @IBOutlet weak var countryCodeBtn: UIButton!
    
    @IBOutlet weak var addressLabel: UITextField!
    
    @IBOutlet weak var countryCodeLabel: UILabel!
    var countryCodeStr = ""
    
    @IBOutlet weak var industryBtn: UIButton!
    @IBOutlet weak var headimageBtn: UIButton!
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var shopImgUrl: UIButton!
    //营业执照号
    
    @IBOutlet weak var certificateNumber: UITextField!
    
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var certImageView: UIImageView!
    
    var pickerView:ValuePickerView!
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    var headImage = ""
    var yingyezhizhao = ""
    var NextBackValue = ""
    var industryStr = ""
    
    
    var proArray = [String]()
    var proArray1 = [String]()
    
    var cityArray = [String]()
    var cityArray1 = [String]()
    
    
    //行业选择
    var countryArray = [String]()
    var countryArray1 = [String]()
    var shopScopeValue = ""
    @IBAction func btnClick(_ sender: UIButton) {
        
        self.pickerView.valueDidSelect1 = { (value) in
            
            print(value)
            
        }
        
        if provinceCodeBtn == sender{
            
            if self.proArray.count == 0{
                //            self.proArray.append("暂无")
                //            self.proArray1.append("510000")
                return
            }
            
            self.pickerView.dataSource = self.proArray
            self.pickerView.pickerTitle = "选择位置"
            self.pickerView.valueDidSelect = { (value) in
                print("1")
                self.provinceCodeLabel.text = value!
                
                for (i,j) in self.proArray.enumerated(){
                    
                    if j == value!{
                        self.provinceCodeStr = self.proArray1[i]
                        self.cityCodeBtn.isUserInteractionEnabled = true
                        
                    }
                    
                }
                print("=======\(self.provinceCodeStr)")
                self.cityArray.removeAll()
                self.cityArray1.removeAll()
                self.cityCodeLabel.text = "城市"
                self.cityCodeStr = ""
                
                self.countryArray.removeAll()
                self.countryArray1.removeAll()
                self.countryCodeLabel.text = "区县"
                self.countryCodeStr = ""
                
                DispatchQueue.main.async(execute: { 
                    self.addressNetData1(areaid: self.provinceCodeStr)
                })
                
                
            }
            
            self.pickerView.show()
        }
        
        if cityCodeBtn == sender{
            
            
            if self.cityArray.count == 0{
                //            self.cityArray.append("暂无")
                //             self.cityArray1.append("510100")
                return
            }
            
            self.pickerView.dataSource = self.cityArray
            self.pickerView.pickerTitle = "选择位置"
            self.pickerView.valueDidSelect = { (value) in
                print("2")
                self.cityCodeLabel.text = value!
                for (i,j) in self.cityArray.enumerated(){
                    
                    if j == value!{
                        self.cityCodeStr = self.cityArray1[i]
                        self.countryCodeBtn.isUserInteractionEnabled = true
                        
                    }
                    
                }
                
                
                self.countryArray.removeAll()
                self.countryArray1.removeAll()
                self.countryCodeLabel.text = "区县"
                self.countryCodeStr = ""
                
               self.addressNetData2(areaid: self.cityCodeStr)
            }
            
            self.pickerView.show()
        }
        if countryCodeBtn == sender{
            
            if self.countryArray.count == 0{
                //            self.countryArray.append("暂无")
                //             self.countryArray1.append("510104")
                return
            }
            
            self.pickerView.dataSource = self.countryArray//["成华区","龙泉驿区","金牛区","武侯区","锦江区","青羊区","都江堰市","",""]
            self.pickerView.pickerTitle = "选择位置"
            self.pickerView.valueDidSelect = { (value) in
                print("3")
                self.countryCodeLabel.text = value!
                for (i,j) in self.countryArray.enumerated(){
                    
                    if j == value!{
                        self.countryCodeStr = self.countryArray1[i]
                        
                    }
                    
                }
                
                
            }
            
            self.pickerView.show()
        }
        
    }
    
    var industryListArray = [String]()
    var industryCodeListArray = [String]()
    
    var The_navigation_barV:The_navigation_barViewView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "新商户申请"

        
        
        pickerView = ValuePickerView()

        shopImgUrl.addTarget(self, action: #selector(shopImgUrlAction), for: UIControlEvents.touchUpInside)
        headimageBtn.addTarget(self, action: #selector(headimageAction), for: UIControlEvents.touchUpInside)
        industryBtn.addTarget(self, action: #selector(industryAction), for: UIControlEvents.touchUpInside)
        okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        
        
        self.cityCodeBtn.isUserInteractionEnabled = false
        self.countryCodeBtn.isUserInteractionEnabled = false
        
        
        //选择行业
        self.aa()
        
        self.addressNetData()
//        self.addressNetData1()
//         self.addressNetData2()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //自定义导航栏
        The_navigation_barV = UINib.init(nibName: "The_navigation_barView", bundle: nil).instantiate(withOwner: self, options: nil).first as! The_navigation_barViewView
        The_navigation_barV.frame = CGRect.init(x: 0, y: 0, width: ScreenW, height: 64)
        UIApplication.shared.keyWindow?.addSubview(The_navigation_barV)
        The_navigation_barV.backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        The_navigation_barV.titleLabel.text = "店铺申请"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        self.The_navigation_barV.removeFromSuperview()
        
    }
    //返回按钮
    func backAction(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    //ok
    func okAction(){
        
        self.checkPhoneGetNetData()

    }
    
    //选择经营范围
    func industryAction(){
        
        if self.industryListArray.count == 0{
            
            return
        }
        
        self.pickerView.dataSource = self.industryListArray
        self.pickerView.pickerTitle = "选择经营范围"
        
        self.pickerView.valueDidSelect1 = { (value) in
            
            if let value11 = value{
                self.shopScopeValue = value11
            }
            
            
        }
        
        self.pickerView.valueDidSelect = { (value) in
            print("2")
            self.industryBtn.setTitle(value!, for: UIControlState.normal)
            self.industryStr = value!
        }
        
        self.pickerView.show()
    }
    
    //店铺头像上传
    func headimageAction(){
        
        self.upload()
        
        self.NextBackValue = "0"
    }
    
    //营业执照上传
    func shopImgUrlAction(){
        
        self.upload()
        self.NextBackValue = "1"
    
    }
    
    //图片上传下弹窗
    let choiceArray0 = ["拍照","从手机相册选择"]
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
    

    
}
//MARK - 相册相关
extension apply_forTableViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            //headerView.setHeadImage(image)
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            //self.headerImageView.image = image
            
            
            if NextBackValue == "0"{
                headImageView.image = image
                changePortrait(image: headImageView.image!, alias: "headImage")
            }else if NextBackValue == "1"{
                certImageView.image = image
                changePortrait(image: certImageView.image!, alias: "yingyezhizhao")
            }
            //上传图片
            
            
            
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

extension apply_forTableViewController{
    
    
    //选择经营类别
    func aa(){
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.info.industry","version":"1.0"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            self.industryListArray.removeAll()
            
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                for i in data1Array{
                    
                    if let aa = i as? NSDictionary{
                        
                        if let bb = aa["industryName"] as? String{
                            
                            self.industryListArray.append(bb)
                            
                        }
                        
                        if let cc = aa["industryCode"] as? String{
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }) { (eroor) in
            
            
        }
        
        
    }
    
    //图片上传
    func changePortrait(image:UIImage,alias:String){
        let imagedata = UIImageJPEGRepresentation(image, 0.3)
        
        let imageName = "\(NSDate())" + ".png"
        let para = ["mid":"123","source":"iOS","alias":alias]
        
        TBUploadDataManager.share.uploadLocalData(data: imagedata!, parameters: para, hostUrl: SingleSTR, withName: "file", fileName: imageName, type: tbUploadType.formdata, comparBlock: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    debugPrint(response)
                    let data = response.result.value as AnyObject
                    
                    
                    if let data1 = data.value(forKey: "data") as? NSDictionary{
                        
                        if let imageUrlStr = data1["imageUrl"] as? String{
                            if alias == "headImage"{
                                self.headImage = imageUrlStr
                            }else if alias == "yingyezhizhao"{
                                self.yingyezhizhao = imageUrlStr
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
    
    //验证是否注册过
    
    func checkPhoneGetNetData(){

        if nameTextField.text?.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入正确的姓名")
            return
        }
        if phoneTextField.text?.characters.count != 11{
            
            KVNProgress.showError(withStatus: "请输入正确的手机号码")
            return
        }
        
        if shopNameLabel.text!.characters.count < 0 || shopNameLabel.text!.characters.count > 16{
            KVNProgress.showError(withStatus: "请输入正确的店铺名称")
            //ToolManger.defaultShow(Str: "请输入正确的店铺名称", T: self)
            
            return
        }
        
        if shopNickLabel.text!.characters.count < 0 || shopNickLabel.text!.characters.count > 6{
            KVNProgress.showError(withStatus: "请输入正确的店铺简称")
            //ToolManger.defaultShow(Str: "请输入正确的店铺简称", T: self)
            
            
            return
        }
        if self.shopScopeValue.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入正确的营业范围")
            return
        }
        
//        if industryBtn.titleLabel?.text == "请选择店铺经营范围"{
//            KVNProgress.showError(withStatus: "请选择店铺经营范围")
//            //ToolManger.defaultShow(Str: "请选择店铺经营范围", T: self)
//            
//            return
//        }
        
        if self.headImage.characters.count == 0{
            KVNProgress.showError(withStatus: "请上传店铺图片或者图片正在上传中")
            //ToolManger.defaultShow(Str: "请上传店铺图片或者图片正在上传中", T: self)
            
            return
        }
        
        if self.provinceCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择店铺省份")
            //ToolManger.defaultShow(Str: "请选择店铺省份", T: self)
            
            return
        }
        
        if self.cityCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择城市")
            //ToolManger.defaultShow(Str: "请选择城市", T: self)
            
            return
        }
        
        if self.countryCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择区县")
            //ToolManger.defaultShow(Str: "请选择区县", T: self)
            
            return
        }
        
        if self.addressLabel.text?.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入你的街道信息")
            //ToolManger.defaultShow(Str: "请输入你的街道信息", T: self)
            
            return
        }
        
        if self.yingyezhizhao.characters.count == 0{
            KVNProgress.showError(withStatus: "请上传营业执照或者图片正在上传中")
            //ToolManger.defaultShow(Str: "请上传营业执照或者图片正在上传中", T: self)
            
            return
        }
        
        if certificateNumber.text!.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入营业执照号")
            // ToolManger.defaultShow(Str: "请输入营业执照号", T: self)
            
            return
        }
        
        NetworkTools.requestData(type: .get, URLString: registercheckPhoneSTR, parameters: ["account":self.phoneTextField.text!], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            self.getNetData()
            
        }) { (error) in
            
            
        }
        
    }
    
    //注册店铺
    func getNetData(){
        
        if self.shopScopeValue.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入正确的营业范围")
            return
        }
        
        if nameTextField.text?.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入正确的姓名")
            return
        }
        if phoneTextField.text?.characters.count != 11{
            
            KVNProgress.showError(withStatus: "请输入正确的手机号码")
            return
        }
        
        if shopNameLabel.text!.characters.count < 0 || shopNameLabel.text!.characters.count > 16{
            KVNProgress.showError(withStatus: "请输入正确的店铺名称")
            //ToolManger.defaultShow(Str: "请输入正确的店铺名称", T: self)
            
            return
        }
        
        if shopNickLabel.text!.characters.count < 0 || shopNickLabel.text!.characters.count > 6{
            KVNProgress.showError(withStatus: "请输入正确的店铺简称")
            //ToolManger.defaultShow(Str: "请输入正确的店铺简称", T: self)
            
            
            return
        }
        
        if industryBtn.titleLabel?.text == "请选择店铺经营范围"{
         KVNProgress.showError(withStatus: "请选择店铺经营范围")
            //ToolManger.defaultShow(Str: "请选择店铺经营范围", T: self)
            
            return
        }
        
        if self.headImage.characters.count == 0{
            KVNProgress.showError(withStatus: "请上传店铺图片或者图片正在上传中")
            //ToolManger.defaultShow(Str: "请上传店铺图片或者图片正在上传中", T: self)
            
            return
        }
        
        if self.provinceCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择店铺省份")
            //ToolManger.defaultShow(Str: "请选择店铺省份", T: self)
            
            return
        }
        
        if self.cityCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择城市")
            //ToolManger.defaultShow(Str: "请选择城市", T: self)
            
            return
        }
        
        if self.countryCodeStr.characters.count == 0{
            KVNProgress.showError(withStatus: "请选择区县")
            //ToolManger.defaultShow(Str: "请选择区县", T: self)
            
            return
        }
        
        if self.addressLabel.text?.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入你的街道信息")
            //ToolManger.defaultShow(Str: "请输入你的街道信息", T: self)
            
            return
        }
        
        if self.yingyezhizhao.characters.count == 0{
            KVNProgress.showError(withStatus: "请上传营业执照或者图片正在上传中")
            //ToolManger.defaultShow(Str: "请上传营业执照或者图片正在上传中", T: self)
            
            return
        }
        
        if certificateNumber.text!.characters.count == 0{
            KVNProgress.showError(withStatus: "请输入营业执照号")
           // ToolManger.defaultShow(Str: "请输入营业执照号", T: self)
            
            return
        }
        
        
//        let para = ["applyName":self.nameTextField.text!,"applyPhone":self.phoneTextField.text!,"shopName":self.shopNameLabel.text!]
        let para = ["applyName":self.nameTextField.text!,"applyPhone":self.phoneTextField.text!,"shopName":self.shopNameLabel.text!,"shopShortName":self.shopNickLabel.text!,"shopScope":shopScopeValue,"shopCity":"\(provinceCodeLabel.text!)-\(cityCodeLabel.text!)-\(countryCodeLabel.text!)","shopCityCode":"\(self.provinceCodeStr)-\(self.cityCodeStr)-\(self.countryCodeStr)","shopAddress": "\(provinceCodeLabel.text!)-\(cityCodeLabel.text!)-\(countryCodeLabel.text!)-" + self.addressLabel.text!,"shopLicense":self.certificateNumber.text!,"shopLicenseUrl":self.yingyezhizhao,"shopUrl":self.headImage]
        NetworkTools.requestData(type: .post, URLString: RegisterOKSTR, parameters: para, encoding: "post", T: self, ShowStr: true, finishedCallback: { (data) in
            
            let rigsterSuccessVC = UIStoryboard.init(name: "registerSuccessSB", bundle: nil).instantiateViewController(withIdentifier: "rigsterSuccessVC") as! rigsterSuccessTableViewController
            
            self.present(rigsterSuccessVC, animated: true, completion: nil)
            
        }) { (error) in
            
            
        }
        
    }
    
    //获取地区城市选择

    
    func addressNetData(){
        
        NetworkTools.requestData(type: .get, URLString: getSubArea + "?parentId=0", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.proArray.removeAll()
            self.proArray1.removeAll()
            
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                for i in data1Array{
                    if let item = i as? NSDictionary{
                        if let name  = item["name"] as? String{
                            print(name)
                            
                            
                            self.proArray.append(name)
                        }
                        if let codeStr = item["code"] as? String{
                            
                            self.proArray1.append(codeStr)
                        }
                    }
                    
                }
                
            }
        }) { (error) in
            
            
        }
        
    }
    
    func addressNetData1(areaid:String){
        
        NetworkTools.requestData(type: .get, URLString: getSubArea + "?parentId=\(areaid)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.cityArray.removeAll()
            self.cityArray1.removeAll()
            
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                for i in data1Array{
                    if let item = i as? NSDictionary{
                        if let name  = item["name"] as? String{
                            print(name)
                            self.cityArray.append(name)
                        }
                        if let codeStr = item["code"] as? String{
                            
                            self.cityArray1.append(codeStr)
                        }
                    }
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
        
    }
    func addressNetData2(areaid:String){
        
        NetworkTools.requestData(type: .get, URLString: getSubArea + "?parentId=\(areaid)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            self.countryArray.removeAll()
            self.countryArray1.removeAll()
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                for i in data1Array{
                    if let item = i as? NSDictionary{
                        if let name  = item["name"] as? String{
                            print(name)
                            
                            
                            self.countryArray.append(name)
                        }
                        if let codeStr = item["code"] as? String{
                            
                            self.countryArray1.append(codeStr)
                        }
                    }
                    
                }
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
}
