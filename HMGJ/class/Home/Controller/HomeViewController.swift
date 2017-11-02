//
//  HomeViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import MJRefresh


class HomeViewController: BaseViewController {

    //是否开通e账户
    var eaccountFlagS = ""

    var collectionView:UICollectionView!
    var topView:UIView?
    var rootView:UIScrollView?
    var lastY:CGFloat = 0
    var imageView:UIImageView?
    
    let leftBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
    
    let vie = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
    var invitedHeader:HomeHeaderView!
    var No_activity_informationV:No_activity_informationViewView!
     var No_activity_informationV1:No_activity_informationViewView!
    var The_customAlertV:the_customView!
    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "红码"
        

        
//        No_activity_informationV = UINib.init(nibName: "No_activity_informationView", bundle: nil).instantiate(withOwner: self, options: nil).first as! No_activity_informationViewView
//        No_activity_informationV1 = UINib.init(nibName: "No_activity_informationView", bundle: nil).instantiate(withOwner: self, options: nil).first as! No_activity_informationViewView
//        self.tanchuang()
        

       
       // self.addRefreshView()
        self.headerAction()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2.0) { 
            
            //上报推送
            if registrationIDSTR.characters.count > 0{
                self.jpush()
            }
        }
        self.colayout()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getNetData()
        
    }
    func colayout(){
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 200, width: ScreenW, height: ScreenH-200), collectionViewLayout: layout)
        // 注册一个cell
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView.register(UINib.init(nibName:"ServiceCenterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib.init(nibName: "serviceFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        //设置每一个cell的宽高
        
        collectionView.backgroundColor = UIColor.white
        layout.itemSize = CGSize.init(width: ScreenW/2, height: 100)
        self.view.addSubview(collectionView)
    }

    //弹窗
    func tanchuang(){
        The_customAlertV = UINib.init(nibName: "The_customAlertView", bundle: nil).instantiate(withOwner: self, options: nil).first as! the_customView
        The_customAlertV.size = CGSize.init(width: ScreenW * 3 / 4, height: ScreenH / 2 + 50)
        The_customAlertV.layer.masksToBounds = true
        The_customAlertV.layer.cornerRadius = 5
        The_customAlertV.center = self.vie.center
        self.vie.backgroundColor = UIColor.RGBA(0, 0, 0, 0.4)
        The_customAlertV.cancelBtn.addTarget(self, action: #selector(cancelAction), for: UIControlEvents.touchUpInside)
        The_customAlertV.okBtn.addTarget(self, action: #selector(okAction), for: UIControlEvents.touchUpInside)
        The_customAlertV.noBtn.addTarget(self, action: #selector(noAction), for: UIControlEvents.touchUpInside)
        self.vie.addSubview(The_customAlertV)
    }
    
    func cancelAction(){
        
        self.vie.removeFromSuperview()
        
    }
    
    func okAction(){
        let certVC = UIStoryboard(name: "certificateSB", bundle: nil).instantiateViewController(withIdentifier: "certVC") as! certificateTableViewController
        certVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(certVC, animated: true)
        self.vie.removeFromSuperview()
    }
    
    func noAction(){
        self.vie.removeFromSuperview()
        
    }
    

    
    
    //头视图
    func headerAction(){
        
        invitedHeader = UINib(nibName: "HomeHeaderview", bundle: nil).instantiate(withOwner: self, options: nil).first as! HomeHeaderView
        //invitedHeader.sharedBtn.backgroundColor = UIColor.RGBColor(76, G: 217, B: 100, A: 1)
        
        invitedHeader.frame = CGRect.init(x: 0, y: 64, width: ScreenW, height:200)
       self.topView?.addSubview(invitedHeader)
        invitedHeader.view1.isUserInteractionEnabled = true
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(view1Action))
        invitedHeader.view1.addGestureRecognizer(tap1)
        
        invitedHeader.view2.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(view2Action))
        invitedHeader.view2.addGestureRecognizer(tap2)
        
        invitedHeader.view3.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(view3Action))
        invitedHeader.view3.addGestureRecognizer(tap3)
        
        invitedHeader.view4.isUserInteractionEnabled = true
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(view4Action))
        invitedHeader.view4.addGestureRecognizer(tap4)
        self.view.addSubview(invitedHeader)
        if let aa = UserDefaults.standard.string(forKey: "role"){
            
            if aa == "0"{
                
                self.invitedHeader.view4.isHidden = true
            }
            
        }

    }
    //头文件方法封装
    func ALLTap(view:UIView){
        
    }
    
    //收款
    func view1Action(){
        
//        let acticityListShopVC = acticityListShopViewController()
//        
//        acticityListShopVC.hidesBottomBarWhenPushed = true
//        
//        self.navigationController?.pushViewController(acticityListShopVC, animated: true)
        
        let scanchoiceVC = UIStoryboard.init(name: "ScanChoiceSB", bundle: nil).instantiateViewController(withIdentifier: "scanVC") as! ScanChoiceTableViewController
        
        scanchoiceVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(scanchoiceVC, animated: true)
        
    }
    //流水
    func view2Action(){
        
        let myVC = Running_waterViewController()
        
        myVC.hidesBottomBarWhenPushed = true
        
        //myVC.shopQRCodeStr = shopqr
        
        self.navigationController?.pushViewController(myVC, animated: true)
        

    }
    //报表
    func view3Action(){
        
//        let myVC = UIStoryboard.init(name: "MycodeSB", bundle: nil).instantiateViewController(withIdentifier: "mycodeVC") as! MyCodeViewController
//        
//        myVC.hidesBottomBarWhenPushed = true
//        
//        self.navigationController?.pushViewController(myVC, animated: true)
        let report = The_reportViewController()
        
        
        report.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(report, animated: true)

    }
    //钱包
    func view4Action(){
        
        let the_walletVC = UIStoryboard.init(name: "The_walletSB", bundle: nil).instantiateViewController(withIdentifier: "the_walletVC") as! The_walletTableViewController
        
        the_walletVC.hidesBottomBarWhenPushed = true
        the_walletVC.eaccountFlagS = self.eaccountFlagS
        self.navigationController?.pushViewController(the_walletVC, animated: true)
        
    }
    



}
extension HomeViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCenterCollectionViewCell
        
        
        if indexPath.row == self.dataArray.count - 1{
            cell.headerImageView.image = UIImage.init(named: "图层-2")
            cell.DetailLabel.text = "微服务"
            cell.nameLabel.text = "微服务"
        }else{
            let model = self.dataArray[indexPath.row] as? service_centerModel
            cell.model = self.dataArray[indexPath.row] as? service_centerModel
            
            if let roleStr = model?.role{
                
                if roleStr == "merchant" && UserDefaults.standard.string(forKey: "role") == "0"{
                    
                    cell.isHidden = true
                }
                
            }
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
            if indexPath.row == self.dataArray.count - 1{
                
                let microVC = Micro_serviceViewController()
                
                microVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(microVC, animated: true)
                
            }else{
                let model = self.dataArray[indexPath.row] as? service_centerModel
                
                if let categoryStr = model?.category{
                    
                    if categoryStr == "app"{
                        if let appid = model?.appId{
                            
                            if appid == "goods_manager"{
                                
                                let acticityListShopVC = acticityListShopViewController()
                                
                                acticityListShopVC.hidesBottomBarWhenPushed = true
                                
                                self.navigationController?.pushViewController(acticityListShopVC, animated: true)
                                
                            }else{
                                self.appidGetNetData(appid: appid)
                            }
                            
                            
                        }
                        
                    }
                        // http://www.jfyl888.com:8888/mindex.jsp
                    else if categoryStr == "url"{
                        let dkshtVC = DKSHTMLController()
                        var url = model?.url
                        if url!.contains("memberId"){
                            
                        }else{
                            if (url?.contains("?"))!{
                                url = url! + "&memberId=\(memberId)&cell=\(PhoneNumber)"
                            }else{
                                url = url! + "?memberId=\(memberId)&cell=\(PhoneNumber)"
                            }
                        }
                        dkshtVC.htmlUrl = url
                        dkshtVC.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(dkshtVC, animated: true)
                    }
                    
                    
                }
            }
        
        

        
    }
    
    
    
    
}


// iOS项目开发实战——实现UICollectionView的动态增加Cell与Section
//http://blog.csdn.net/chenyufeng1991/article/details/49539007

extension HomeViewController{
    
    
    func jpush(){
        // var uuid32 = UUID
        //        if (UUID?.characters.count)! > 32{
        //            uuid32 = UUID?.substring(to: 31)
        //        }
        let equpOS = "iOS," + UUNAME + ",iphone," + UUSYS
        let para = ["equipNo":UUID!,"segment":"","memberId":memberId,"equipOS":equpOS,"jpushId": registrationIDSTR,"handerCell":PhoneNumber,"appId":appId]
        print(JPUSHSTR)
        print(para)
        NetworkTools.requestData(type: .post, URLString: JPUSHSTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            print("-===-=-=-=-=-=-=-=")
            print(data)
            
            
        }) { (error) in
            
            self.jpush()
        }
    }
    
    func appidGetNetData(appid:String){
        
        NetworkTools.requestData(type: .post, URLString: appuserInfoSTR, parameters: ["memberId":memberId,"appId":appid], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            let cigareteVC = UIStoryboard(name: "CigaretteStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CigaretteLoginVC") as! CigaretteLoginVC
            cigareteVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(cigareteVC, animated: true)
            print(data)
            if let dataDict = data.value(forKey: "data") as? String{
                print(dataDict)
//                let cigareteVC = UIStoryboard(name: "CigaretteStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CigaretteLoginVC") as! CigaretteLoginVC
//                cigareteVC.hidesBottomBarWhenPushed = true
//                
//                self.navigationController?.pushViewController(cigareteVC, animated: true)
                if dataDict.characters.count > 0{
                    
                    cigareteVC.memberidStr = "1"
                }else {
                    
                    cigareteVC.memberidStr = ""
                }
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
    
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: appmemberChooseSTR, parameters: ["memberId":memberId], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            //            appId = baccy;
            //            category = app;
            //            icon = "http://file.inlee.com.cn:8011/file/icon/hebao.png";
            //            isDefault = 1;
            //            name = "\U624b\U673a\U8ba2\U70df";
            //            remark = "\U624b\U673a\U4e5f\U53ef\U4ee5\U8ba2\U70df\U5566";
            //            sort = 0;
            //            url = "http://www.inlee.com.cn/app/baccy";
            print(data)
            
            if let data1 = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: service_centerModel.self, json: data1){
                    self.dataArray.removeAllObjects()
                    self.dataArray.addObjects(from: modelArray)
                    
                    
                    for (i,j) in self.dataArray.enumerated(){
                        
                        if let model = j as? service_centerModel{
                            if model.role == "0" && UserDefaults.standard.string(forKey: "role") == "0"{
                                self.dataArray.removeObject(at: i)
                                
                            }
                        }
                        
                        
                    }
                    
                    let model = service_centerModel()
                    
                    model.appId = ""
                    
                    self.dataArray.insert(model, at: self.dataArray.count)
                
                    
                    self.collectionView.reloadData()
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
    }

}


