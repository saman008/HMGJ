//
//  MeInfoTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/20.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

import AVFoundation
import Photos


class MeInfoTableViewController: TabBaseTableViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PickerDelegate {
    func chooseDate(picker: LmyPicker, date: Date) {
        
    }


    var genderStr = ""
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    @IBOutlet weak var adressLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    let choiceArray0 = ["拍照","从手机相册选择"]
    let choiceArray3 = ["女","男"]
    //地址
    var areaString = ""
    //详细地址
    var arearDetailString = ""
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
    
    var headUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "修改个人信息"
        
        self.tableView.backgroundColor = UIColor.gray
        
        self.nav2Btn()
        self.nowgetNetData()
    }
    
    //右边保存
    func nav2Btn(){
        
        // rightBtn.setImage(UIImage.init(named: "location"), for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.setTitle("保存", for: UIControlState.normal)
        //rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        rightBtn.contentHorizontalAlignment = .right
        //        let attributeString = NSMutableAttributedString(string: "44678")
        //        attributeString.addAttribute(NSFontAttributeName, value: UIFont.init(name: "成都市", size: 12), range: NSMakeRange(0, 1))
        //        attributeString.addAttribute(NSFontAttributeName, value: RColor, range: NSMakeRange(0, 1))
        //        leftBtn.setAttributedTitle(attributeString, for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(rightActi), for: UIControlEvents.touchUpInside)
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    
    func rightActi(){
        let alert = UIAlertController(title: "是否保存", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        let okAction = UIAlertAction(title: "保存", style: UIAlertActionStyle.default) { (alert) in
            
            self.getNetData()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
}



//MARK - 城市选择器
extension MeInfoTableViewController{
    
    func chooseElements(picker: LmyPicker, content: [Int : Int]) {
        var str:String = ""
        if let array = picker.contentArray {
            var tempArray = array
            for i in 0..<content.keys.count {
                let value:Int! = content[i]
                if value < tempArray.count {
                    let obj:LmyPickerObject = tempArray[value]
                    let title = obj.title ?? ""
                    if str.characters.count>0 {
                        str = str.appending("-\(title)")
                    }else {
                        str = title;
                    }
                    if let arr = obj.subArray {
                        tempArray = arr
                    }
                }
            }
            areaString = str
            self.adressLabel.text = areaString
            tableView.reloadData()
        }
    }
    
    
    
    
}


//MARK - 相册相关
extension MeInfoTableViewController{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        
        if (info[UIImagePickerControllerEditedImage] as? UIImage) != nil {
            //headerView.setHeadImage(image)
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.headerImage.image = image
            //上传图片
            
            self.changePortrait(image: self.headerImage.image!)
            
        }
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}


extension MeInfoTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //头像
        if indexPath.row == 0{
            let alert = UIAlertController(title: nil, message: "请选择头像上传方式", preferredStyle: .actionSheet)
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
        
        //名字
        if indexPath.row == 2{
            let alertController = UIAlertController(title: "请输入姓名",
                                                    message: "", preferredStyle: .alert)
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "请输入你的姓名"
            }
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                //也可以用下标的形式获取textField let login = alertController.textFields![0]
                let login = alertController.textFields!.first!
                
                self.nameLabel.text = login.text!
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        //昵称
        if indexPath.row == 3{
            let alertController = UIAlertController(title: "请输入昵称",
                                                    message: "", preferredStyle: .alert)
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "请输入昵称"
            }
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                //也可以用下标的形式获取textField let login = alertController.textFields![0]
                let login = alertController.textFields!.first!
                
                self.nicknameLabel.text = login.text!
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        //性别
        if indexPath.row == 4{
            
            let alert = UIAlertController(title: nil, message: "请选择你的性别", preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            for (j,i) in choiceArray3.enumerated(){
                let okAction = UIAlertAction(title: i, style: .default, handler: { (action:UIAlertAction) -> Void in
                    
                    
                    self.sexLabel.text = i
                    self.genderStr = "\(j)"
                    
                    
                })
                alert.addAction(okAction)
            }
            
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        //城市选择器(地址)
        if indexPath.row == 5{
            
            var contentArray = [LmyPickerObject]()
            let plistPath:String = Bundle.main.path(forAuxiliaryExecutable: "area.plist") ?? ""
            let plistArray = NSArray(contentsOfFile: plistPath)
            let proviceArray = NSArray(array: plistArray!)
            for i in 0..<proviceArray.count {
                var subs0 = [LmyPickerObject]()
                
                let cityzzz:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                let cityArray:NSArray = cityzzz.value(forKey: "cities") as! NSArray
                for j in 0..<cityArray.count {
                    var subs1 = [LmyPickerObject]()
                    
                    let areazzz:NSDictionary = cityArray.object(at: j) as! NSDictionary
                    let areaArray:NSArray = areazzz.value(forKey: "areas") as! NSArray
                    for m in 0..<areaArray.count {
                        let object = LmyPickerObject()
                        object.title = areaArray.object(at: m) as? String
                        subs1.append(object)
                    }
                    let citymmm:NSDictionary = cityArray.object(at: j) as! NSDictionary
                    let cityStr:String = citymmm.value(forKey: "city") as! String
                    let object = LmyPickerObject()
                    object.title = cityStr
                    subs0.append(object)
                    object.subArray = subs1
                }
                let provicemmm:NSDictionary = proviceArray.object(at: i) as! NSDictionary
                let proviceStr:String? = provicemmm.value(forKey: "state") as! String?
                let object = LmyPickerObject()
                object.title = proviceStr
                object.subArray = subs0
                contentArray.append(object)
            }
            
            let picker = LmyPicker(delegate: self, style: .nomal)
            picker.contentArray = contentArray
            picker.show()
        }
        //详细地址
        if indexPath.row == 6{
            let alertController = UIAlertController(title: "请输入详细地址",
                                                    message: "", preferredStyle: .alert)
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                textField.placeholder = "请输入详细地址"
            }
            let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                action in
                //也可以用下标的形式获取textField let login = alertController.textFields![0]
                let login = alertController.textFields!.first!
                
                self.detailLabel.text = login.text!
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
}




extension MeInfoTableViewController{
    
    //获取个人信息
    func nowgetNetData(){
        NetworkTools.requestData(type: .get, URLString: getUserSTR+"?mid=\(memberId)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let realName = dataDict["realName"] as? String{
                    self.nameLabel.text = realName
                }
                
                if let nickName = dataDict["nickName"] as? String{
                    self.nicknameLabel.text = nickName
                }
                if let headUrl = dataDict["headUrl"] as? String{
                    self.headerImage.sd_setImage(with: URL.init(string: headUrl), placeholderImage: nil)
                }
                
                if let address = dataDict["address"] as? String{
                    self.detailLabel.text = address
                }
                if let gender = dataDict["gender"] as? String{
                    
                    if gender == "1"{
                        self.sexLabel.text = "男"
                    }else if gender == "0"{
                        self.sexLabel.text = "女"
                    }
                    
                }
                
                
                if let area = dataDict["area"] as? String{
                    self.adressLabel.text = area
                }
                
                
                self.tableView.reloadData()
            }
            
        }) { (error) in
            
            
        }
        
        
    }
    //上传个人信息
    func getNetData(){
        let para = ["mid":memberId,"realName":nameLabel.text!,"nickName":nicknameLabel.text!,"area":adressLabel.text!,"address":detailLabel.text!,"gender":genderStr,"headUrl":headUrl]
        print(para)
        NetworkTools.requestData(type: .post, URLString: renewalSTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            
        }) { (error) in
            
            
        }
        
    }
    
    func changePortrait(image:UIImage){
        let imagedata = UIImageJPEGRepresentation(image, 0.3)
        
        let imageName = "\(NSDate())" + ".png"
        let para = ["mid":memberId,"source":"iOS","alias":"head"]
        
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
                    
                    if let data1 = data.value(forKey: "data") as? String{
                        
                        self.headUrl = data1
                        
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
