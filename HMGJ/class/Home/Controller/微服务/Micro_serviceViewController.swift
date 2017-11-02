//
//  Micro_serviceViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import Alamofire

class Micro_serviceViewController: BaseViewController{

    
    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
        
    }()
    lazy var dataArray1:NSMutableArray = {
        
        
        return NSMutableArray()
        
    }()
    
    var collectionView:UICollectionView!
    
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 40, height: 40))
    var appid = ""
    var appid1 = ""
    
    var nooryesStr = ""
    
    var appidArray1 = [String]()
    var appidArray2 = [String]()
    
    var listArray = [[String:String]]()
    
    var rightStr = "1"
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "微服务"
        
        self.colayout()
        
        self.getNetData()
        self.nochooseGetNetData()
        
        self.rightAction()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        for (i,j) in self.dataArray1.enumerated(){
//            let modelj = j as? service_centerModel
//            self.updateChooseGetNetData(appid: modelj!.appId, sort: "\(i)")
//            
//        }
//        
//    }

    
    //右上角
    func rightAction(){
        
        rightBtn.setTitle("编辑", for: UIControlState.normal)
        rightBtn.addTarget(self, action: #selector(rightActi(btn:)), for: UIControlEvents.touchUpInside)
        
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    func rightActi(btn:UIButton){
        
        if rightStr == "1"{
            btn.setTitle("保存", for: UIControlState.normal)
            
            rightStr = "2"
            return
        }
        
        if rightStr == "2"{
            btn.setTitle("编辑", for: UIControlState.normal)
            
            //添加服务
            if nooryesStr == "1"{
                

                for i in appidArray1{
                    self.addChooseGetNetData(appid: i)
                    //self.updateChooseGetNetData(appid: i, sort: "\(i)")
                }
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0, execute: {
                    self.nochooseGetNetData()
                    self.getNetData()
                    
                })
                
                nooryesStr = ""
            }
            //删除服务
            if nooryesStr == "2"{
                for i in appidArray2{
                    self.deleteChooseGetNetData(appid: i)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.0, execute: {
                    self.getNetData()
                    self.nochooseGetNetData()
                    
                })
                nooryesStr = ""
            }
            rightStr = "1"
        }
        

        
    }
    
    func colayout(){
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.init(x: 0, y:0, width: ScreenW, height: ScreenH), collectionViewLayout: layout)
        // 注册一个cell
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView.register(UINib.init(nibName:"ServiceCenterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        collectionView.register(UINib.init(nibName: "serviceFootView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        //允许多选
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(UINib.init(nibName: "reportFooterCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reportFooterCollectionViewCell")
        
        //设置每一个cell的宽高
        
        collectionView.backgroundColor = UIColor.white
        layout.itemSize = CGSize.init(width: ScreenW/2, height: 100)
        self.view.addSubview(collectionView)
    }

    
    
    func addAction(){
        
        print("增加")
        
    }
    
    func longPressAction(sender:UILongPressGestureRecognizer){
        
        if sender.state == .began{
            
            //获取所点击的点在collectionview上的位置
            
            let point = sender.location(in: self.collectionView)
            //通过点击的点来获得indexpath
            
            let indexPath = self.collectionView.indexPathForItem(at: point)
            //开启交互
            
            self.collectionView.beginInteractiveMovementForItem(at: indexPath!)
            
        }else if sender.state == .changed{
            let point = sender.location(in: self.collectionView)
            
            self.collectionView.updateInteractiveMovementTargetPosition(point)
            //更新交互
        }else if sender.state == .ended{
            //关闭交互
            self.collectionView.endInteractiveMovement()
        }
        
    }
    
    
}
extension Micro_serviceViewController:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        
        if section == 0{
            return self.dataArray.count
        }else{
            return self.dataArray1.count
        }

        
    }
    
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ServiceCenterCollectionViewCell
        if cell.isSelected == true{
            //cell.backgroundColor = UIColor.red
            cell.nameLabel.textColor = UIColor.red
            cell.layer.borderColor = UIColor.red.cgColor
            cell.DetailLabel.textColor = UIColor.red
        }else if cell.isSelected == false{
            //cell.backgroundColor = UIColor.white
            cell.nameLabel.textColor = UIColor.black
            cell.DetailLabel.textColor = UIColor.gray
            cell.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        }
        if indexPath.section == 0{
            cell.model = self.dataArray[indexPath.row] as? service_centerModel
            
        }else {
            cell.model = self.dataArray1[indexPath.row] as? service_centerModel
            
        }
         return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0,0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        
        return CGSize.init(width: ScreenW, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        
        return CGSize.init(width: ScreenW, height: 0.01)
    }
    //返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reportFooterCollectionViewCell", for: indexPath) as! reportFooterCollectionViewCell
        
        
        if indexPath.section == 0{
            reusableview.titleLabel.text = "未选择服务"
        }else{
            reusableview.titleLabel.text = "已选择服务"
        }
        return reusableview
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ServiceCenterCollectionViewCell
         cell.nameLabel.textColor = UIColor.black
        cell.DetailLabel.textColor = UIColor.gray
       // cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        if indexPath.section == 0{
            let model = self.dataArray[indexPath.row] as? service_centerModel
            var appidaa = ""
            if let aa = model?.appId{
                appidaa = aa
            }
            for (i,j) in appidArray1.enumerated(){
                if j == appidaa{
                    self.appidArray1.remove(at: i)
                }
            }
           
        }else{

            let model = self.dataArray1[indexPath.row] as? service_centerModel
            var appidaa = ""
            if let aa = model?.appId{
                appidaa = aa
            }
            for (i,j) in appidArray2.enumerated(){
                if j == appidaa{
                    self.appidArray2.remove(at: i)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if rightStr == "1"{
            var model:service_centerModel?
            if indexPath.section == 0{
                model = self.dataArray[indexPath.row] as? service_centerModel
            }
            if indexPath.section == 1{
                model = self.dataArray1[indexPath.row] as? service_centerModel
            }
            
            if let categoryStr = model?.category{
                
                if categoryStr == "app"{
                    if let appid = model?.appId{
                        self.appidGetNetData(appid: appid)
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
        if rightStr == "2"{
         
            let cell = collectionView.cellForItem(at: indexPath) as! ServiceCenterCollectionViewCell
            //cell.backgroundColor = UIColor.red
            cell.nameLabel.textColor = UIColor.red
            cell.DetailLabel.textColor = UIColor.red
            cell.layer.borderColor = UIColor.red.cgColor
            //获取多选的数组
            let indexPaths = collectionView.indexPathsForSelectedItems
            if indexPath.section == 0{
                let model = self.dataArray[indexPath.row] as? service_centerModel
                if let aa = model?.appId{
                    self.appidArray1.append(aa)
                    appid = aa
                }
                nooryesStr = "1"
            }else{
                
                
                let model = self.dataArray1[indexPath.row] as? service_centerModel
                if let aa = model?.appId{
                    self.appidArray2.append(aa)
                    appid1 = aa
                }
                nooryesStr = "2"
            }
        }
      
        
    }
    
    
    
    
}

extension Micro_serviceViewController{
    
    //获取用户信息
    func appidGetNetData(appid:String){
        
        NetworkTools.requestData(type: .post, URLString: appuserInfoSTR, parameters: ["memberId":memberId,"appId":appid], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            print(data)
            if let dataDict = data.value(forKey: "data") as? String{
                print(dataDict)
                let cigareteVC = UIStoryboard(name: "CigaretteStoryboard", bundle: nil).instantiateViewController(withIdentifier: "CigaretteLoginVC") as! CigaretteLoginVC
                cigareteVC.hidesBottomBarWhenPushed = true
                
                self.navigationController?.pushViewController(cigareteVC, animated: true)
                if dataDict.characters.count > 0{
                    
                    cigareteVC.memberidStr = "1"
                }else {
                    
                    cigareteVC.memberidStr = ""
                }
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
    /////////////////post用户未选择服务/////////////////////
    func nochooseGetNetData(){
        
        NetworkTools.requestData(type: .post, URLString: appnoChooseSTR, parameters: ["memberId":memberId], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            if let data1Aray = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: service_centerModel.self, json: data1Aray){
                    self.appidArray1.removeAll()
                    self.appidArray2.removeAll()
                    self.dataArray.removeAllObjects()
                    
                    self.dataArray.addObjects(from: modelArray)
                    
                    self.collectionView.reloadData()
                    
                }
            }
            
        }) { (error) in
            
            
        }
        
        
    }
    ///已经选择的选项post
    func getNetData(){
        
        NetworkTools.requestData(type: .post, URLString: appmemberChooseSTR, parameters: ["memberId":memberId], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in

            
            if let data1 = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: service_centerModel.self, json: data1){
                    self.appidArray1.removeAll()
                    self.appidArray2.removeAll()
                    self.dataArray1.removeAllObjects()
                    self.dataArray1.addObjects(from: modelArray)
                    self.listArray.removeAll()
                    for (i,j) in self.dataArray1.enumerated(){
                        let modelj = j as? service_centerModel
                        let model = ["appId":modelj!.appId,"sort":"\(i)"]
                        
                        
                        self.listArray.append(model)
                        
                    }
                    if self.listArray.count != 0{
                        self.updateChooseGetNetData(para: self.listArray)
                    }else{
                        
                    }
                    
                    self.collectionView.reloadData()
                    
                }
                
            }
            
            
        }) { (error) in
            
            
        }
        
    }
//
//    //////////////////我的服务添加服务post/////////
    
    func addChooseGetNetData(appid:String){
        
        NetworkTools.requestData(type: .post, URLString: appaddChooseSTR, parameters: ["memberId":memberId,"appId":appid,"sort":"","where":"home"], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            //self.navigationController?.popViewController(animated: true)
            print(data)
            
        }) { (error) in
            
            
        }
        
    }
    
//    ////////////////////////////我的服务删除服务////////////
    
    func deleteChooseGetNetData(appid:String){
        NetworkTools.requestData(type: .post, URLString: appdeleteChooseSTR, parameters: ["memberId":memberId,"appId":appid], encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            //self.navigationController?.popViewController(animated: true)
            print(data)
            
        }) { (error) in
            
            
        }
        
        
    }
    
//    ////1.1	App我的服务更新排序/post////////
//
    func updateChooseGetNetData(para:[[String:String]]){
        
        let para1 = ["memberId":memberId,"services":para] as [String : Any]
        print(para1)
        NetworkTools.requestAnyData(type: .post, URLString: appupdateChooseSTR, parameters: para1, encoding: "post", T: self, ShowStr: false, error: false, finishedCallback: { (data) in
            
            print(data)
            
            
        }) { (error) in
            
            
        }

        
    }
    
    
}
