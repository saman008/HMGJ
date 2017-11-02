//
//  MeTableViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire


class MeTableViewController: TabBaseTableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameconstWidth: NSLayoutConstraint!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var aa: UITableViewCell!
    
    @IBOutlet weak var bb: UITableViewCell!
    
    @IBOutlet weak var cc: UITableViewCell!
    
    
    @IBOutlet weak var dd: UITableViewCell!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var makeimageView: UIImageView!
    
    @IBOutlet weak var makeTitleLabel: UILabel!
    var imageUrlArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        
//        let topV = TBMyInfoTopView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 70))
//        topView.addSubview(topV)
        
        
        //aa.isHidden = true
        
        //self.sysLabel.text = currentVersion
        
        
        //self.view.backgroundColor = UIColor.groupTableViewBackground
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.headerImageView.isUserInteractionEnabled = true
        self.headerImageView.addGestureRecognizer(tap)
        
        
        if let aa = UserDefaults.standard.string(forKey: "role"){
            
            if aa == "0"{
                
                //self.aa.isHidden = true
                self.bb.isHidden = true
                self.cc.isHidden = true
                self.dd.isHidden = true
                self.makeimageView.image = UIImage.init(named: "设置")
                self.makeTitleLabel.text = "系统设置"
            }
            
        }
        if shopImgUrlID.characters.count != 0{
            imageUrlArray.append(shopImgUrlID)
        }
    }
    
    
    func tapAction(){
        //跳转到看图片页面中
        let showImageC = ShowImageViewController()
        //传值
        showImageC.imageArray = imageUrlArray
        showImageC.seletedIndex = 1
        self.present(showImageC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.nameLabel.text = UserDefaults.standard.string(forKey: "shopName")
        self.phoneLabel.text = UserDefaults.standard.string(forKey: "PhoneNumb")
        self.headerImageView.sd_setImage(with: URL.init(string: shopImgUrlID), placeholderImage: UIImage.init(named: "广告"))
//        if verifyStatusID == "0"{
//            self.certificateLabel.text = "去实名认证"
//        }else{
//            self.certificateLabel.text = "已认证"
//        }
        
        
    }
    
    func clearCache() {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = cachePath?.appending("/\(file)")
            
            if FileManager.default.fileExists(atPath: path!) {
                
                do {
                    try FileManager.default.removeItem(atPath: path!)
                } catch {
                    
                }
            }
        }
    }
    
    
}
extension MeTableViewController{
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //实名认证
//        if indexPath.section == 0{
//            
//            
//            let certInfoVC = UIStoryboard.init(name: "certinfoSB", bundle: nil).instantiateViewController(withIdentifier: "certInfoVC") as! certInfoTableViewController
//            
//            
//            certInfoVC.hidesBottomBarWhenPushed = true
//            
//            
//            self.navigationController?.pushViewController(certInfoVC, animated: true)
            
            
//        }
        
        //基本信息
        if indexPath.section == 1 && indexPath.row == 0{
            
            let MeBaseVC = UIStoryboard.init(name: "MeBaseSB", bundle: nil).instantiateViewController(withIdentifier: "MeBaseVC") as! MeBaseTableViewController
            
            MeBaseVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(MeBaseVC, animated: true)
            
        }
        //签约信息
        if indexPath.section == 1 && indexPath.row == 1{
            
            if let aa = UserDefaults.standard.string(forKey: "role"){
                
                if aa == "0"{
                    let MeVersionVC = UIStoryboard.init(name: "MeVersionSB", bundle: nil).instantiateViewController(withIdentifier: "MeVersionVC") as! MeVersionTableViewController
                    
                    MeVersionVC.hidesBottomBarWhenPushed = true
                    
                    
                    self.navigationController?.pushViewController(MeVersionVC, animated: true)
                }else{
                    
                    let mesignVC = MesignalViewController()
                    
                    mesignVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(mesignVC, animated: true)
                    
//                    let MeSigningVC = UIStoryboard.init(name: "MeSigningSB", bundle: nil).instantiateViewController(withIdentifier: "MeSigningVC") as! MeSigningTableViewController
//                    
//                    MeSigningVC.hidesBottomBarWhenPushed = true
//                    
//                    self.navigationController?.pushViewController(MeSigningVC, animated: true)
                }
                
            }
            

            
            
        }
        
        //我的店员
        if indexPath.section == 1 && indexPath.row == 2{
            
            let metheVC = MeThe_shop_assistantViewController()
            
            metheVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(metheVC, animated: true)
        }
        
//        if indexPath.section == 2 && indexPath.row == 0{
//            ToolManger.defaultShow(Str: "暂不开放", T: self)
//        }
//        if indexPath.section == 2 && indexPath.row == 1{
//            
//            ToolManger.defaultShow(Str: "暂不开放", T: self)
//            
//        }
        //系统设置
        if indexPath.section == 2 && indexPath.row == 0{
            
            let MeVersionVC = UIStoryboard.init(name: "MeVersionSB", bundle: nil).instantiateViewController(withIdentifier: "MeVersionVC") as! MeVersionTableViewController
            
            MeVersionVC.hidesBottomBarWhenPushed = true
            
            
            self.navigationController?.pushViewController(MeVersionVC, animated: true)
            
        }
        
    }
    
}

extension MeTableViewController{
    
    func getNetData(){
        NetworkTools.requestData(type: .get, URLString: getUserSTR+"?mid=\(memberId)", parameters: ["":""], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let dataDict = data.value(forKey: "data") as? NSDictionary{
                
                if let accountStr = dataDict["account"] as? String{
                    self.phoneLabel.text = accountStr
                }
                if let nickName = dataDict["nickName"] as? String{
                    self.nameLabel.text = nickName
                    
                    self.nameconstWidth.constant = ToolManger.calculateStringSize(str: nickName, maxW: 10000, maxH: 1000, fontSize: 17).width
                    
                    
                }
                if let headUrl = dataDict["headUrl"] as? String{
                    self.headerImageView.sd_setImage(with: URL.init(string: headUrl), placeholderImage: nil)
                }
                
                self.tableView.reloadData()
            }
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
    
}
