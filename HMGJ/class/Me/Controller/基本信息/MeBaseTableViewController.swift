//
//  MeBaseTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class MeBaseTableViewController: TabBaseTableViewController {

    @IBOutlet weak var erweimaImageView: UIImageView!
    
    @IBOutlet weak var merchantCodeLabel: UILabel!
    
    @IBOutlet weak var shopNameLabel: UILabel!
    
    @IBOutlet weak var shopAliasLabel: UILabel!
    
    @IBOutlet weak var industryLabel: UILabel!
    
    
    @IBOutlet weak var shopCityCodeLabel: UILabel!
    @IBOutlet weak var shopAddressLabel: UILabel!
    
    
    
    
    @IBOutlet weak var advertisingImageView: UIImageView!
    
    var imageUrlArray = [String]()

    var industryListArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "基本信息"
        
        self.aa()
        
        self.merchantCodeLabel.text = UserDefaults.standard.string(forKey: "shopCode")
        
        
        self.shopNameLabel.text = UserDefaults.standard.string(forKey: "shopName")
        self.shopAliasLabel.text = UserDefaults.standard.string(forKey: "shopAlias")
        
        if let aa = UserDefaults.standard.string(forKey: "shopAddress"){
            var shopadress = ""
            var aaaaa = 0
            for i in aa.characters{
                
                if "\(i)" == "-"{
                    aaaaa += 1
                    if aaaaa == 3{
                        self.shopCityCodeLabel.text = shopadress
                        shopadress = ""
                    }

                }
                
                shopadress = shopadress + "\(i)"
            }
            
            let index = shopadress.index(shopadress.startIndex, offsetBy: 1)//获取字符d的索引
            let result = shopadress.substring(from: index)//从d的索引开始截取后面所有的字符串即defghi
            
            self.shopAddressLabel.text = result
        }
        
        if shopLicenseUrlID?.characters.count != 0{
            imageUrlArray.append(shopLicenseUrlID!)
            self.advertisingImageView.sd_setImage(with: URL.init(string: shopLicenseUrlID!), placeholderImage: UIImage.init(named: "广告"))
        }
        
        
    
    }
    



}

extension MeBaseTableViewController{
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 8{
            //跳转到看图片页面中
            let showImageC = ShowImageViewController()
            //传值
            showImageC.imageArray = imageUrlArray
            showImageC.seletedIndex = 1
            self.present(showImageC, animated: true, completion: nil)
        }
        
        if indexPath.row == 6{
            
            let myVC = UIStoryboard.init(name: "MycodeSB", bundle: nil).instantiateViewController(withIdentifier: "mycodeVC") as! MyCodeViewController
            
            myVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(myVC, animated: true)
            
        }
        
    }
    
}
extension MeBaseTableViewController{
    //选择经营类别
    func aa(){
        
        NetworkTools.requestData(type: .post, URLString: acountapplySTR, parameters: ["service":"pay.info.industry","version":"1.0"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            self.industryListArray.removeAll()
            if let data1Array = data.value(forKey: "data") as? NSArray{

                
                
                for i in data1Array{
                    

                    
                    if let aa = i as? NSDictionary{
                        
                        
                        
                        if let bb = aa["industryName"] as? String{
                            
                            if let id = aa["id"] as? Int{
                               
                                if let industry = UserDefaults.standard.string(forKey: "industry"){
                                    
                                    if "\(id)" == industry{
                                        self.industryLabel.text = bb
                                    }
                                    
                                }
                               
                                
                            }
                            self.industryListArray.append(bb)
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }) { (eroor) in
            
            
        }
        
        
    }
    
//    func getNetData(areaStr:String,id:String){
//        
//        NetworkTools.requestDataUrl(type: .get, URLString: getareaSTR, parameters: ["areaId":areaStr], T: self, finishedCallback: { (data) in
//            
//           
//            if let dataDict = data.value(forKey: "data") as? NSDictionary{
//                
//                if let nameStr = dataDict["name"] as? String{
//                    print(nameStr)
//                    if id == "1"{
//                        self.pro = nameStr
//                    }
//                    if id == "2"{
//                        self.city = nameStr
//                    }
//                    
//                    if id == "3"{
//                        self.country = nameStr
//
//                    }
//                    
//                    
//                    
//                }
//                
//            }
//           
//        }) { (error) in
//            
//            
//        }
//        
//    }
    
}
