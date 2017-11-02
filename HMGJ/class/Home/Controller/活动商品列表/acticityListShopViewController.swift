//
//  acticityListShopViewController.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/10/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class acticityListShopViewController: BaseViewController {

    lazy var dataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    var tableView:UITableView!
    
    let rightBtn = UIButton(frame: CGRect.init(x: 0, y: 0, width: 100, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "活动商品列表"
        
        
        tableView = UITableView.init(frame: self.view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib.init(nibName: "activityshopTableViewCell", bundle: nil), forCellReuseIdentifier: "activityshopTableViewCell")
        
        tableView.rowHeight = 150
        
        tableView.tableFooterView = UIView()
        
        self.view.addSubview(tableView)
        
        self.nav2Btn()
        
        //self.getNetData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.getNetData()
        
    }

    //右上角
    func nav2Btn(){
        
        rightBtn.setImage(UIImage.init(named: "location"), for: UIControlState.normal)
        rightBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        rightBtn.setTitle("添加", for: UIControlState.normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        rightBtn.contentHorizontalAlignment = .right

        
        rightBtn.addTarget(self, action: #selector(leftAction), for: UIControlEvents.touchUpInside)
        let rightitem = UIBarButtonItem(customView: rightBtn)
        self.navigationItem.rightBarButtonItem = rightitem
    }
    //方法实现右上角
    func leftAction(){
        

        let addNewShopVC = UIStoryboard.init(name: "addNewShopSB", bundle: nil).instantiateViewController(withIdentifier: "addNewShopVC") as! addNewShopTableViewController
        
        
        self.navigationController?.pushViewController(addNewShopVC, animated: true)
        
    }

}


//按钮点击效果
extension acticityListShopViewController{
    
    //是否上架
    func isPutAction(btn:UIButton){
        
        let model = self.dataArray[btn.tag - 200] as? activityShopModel
        var para = ["":""]
        if let putis = model?.isPut{
            
            if putis == "0"{
                para = ["shopQRCode":shopQRCodeID,"shopGoodsCode":model!.shopGoodsCode,"isPut":"1"]
            }else if putis == "1"{
                para = ["shopQRCode":shopQRCodeID,"shopGoodsCode":model!.shopGoodsCode,"isPut":"0"]
            }
            
        }
        
        
        
        self.modifiyGetNetData(para: para)
    }
    //是否删除
    func isDel(btn:UIButton){
        let model = self.dataArray[btn.tag - 100] as? activityShopModel
        let para = ["shopQRCode":shopQRCodeID,"shopGoodsCode":model!.shopGoodsCode,"isDel":"1"]
        
        self.modifiyGetNetData(para: para)
        
    }
    
    //编辑
    func modifyAction(btn:UIButton){
        
        let model = self.dataArray[btn.tag - 300] as? activityShopModel
        let addNewShopVC = UIStoryboard.init(name: "addNewShopSB", bundle: nil).instantiateViewController(withIdentifier: "addNewShopVC") as! addNewShopTableViewController
        
        if let name = model?.name{
            addNewShopVC.nameStr = name
            addNewShopVC.shopGoodsCodeStr = model!.shopGoodsCode
        }

        if let price = model?.price{
            let pricea = (price as NSString).doubleValue
            let priceb = pricea / 100
            addNewShopVC.priceStr = "\(priceb)"
        }
        
        if let unit = model?.unit{
            addNewShopVC.unitStr = unit
        }
        if let imgurl = model?.imgUrl{
            addNewShopVC.imgurl = imgurl
        }
        
        self.navigationController?.pushViewController(addNewShopVC, animated: true)
    }
    
    
}

extension acticityListShopViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityshopTableViewCell", for: indexPath) as? activityshopTableViewCell
        
        cell?.model = self.dataArray[indexPath.row] as? activityShopModel
        
        cell?.cutBtn.addTarget(self, action: #selector(isDel(btn:)), for: UIControlEvents.touchUpInside)
        cell?.cutBtn.tag = 100 + indexPath.row
        cell?.getupBtn.addTarget(self, action: #selector(isPutAction(btn:)), for: UIControlEvents.touchUpInside)
        cell?.getupBtn.tag = 200 + indexPath.row
        cell?.modfiyBtn.addTarget(self, action: #selector(modifyAction(btn:)), for: UIControlEvents.touchUpInside)
        
        cell?.modfiyBtn.tag = 300 + indexPath.row
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        
    }
    
    
}

extension acticityListShopViewController{
    
    //获取商品列表
    func getNetData(){
        
        NetworkTools.requestData(type: .get, URLString: activitychannelshopgoodsappListSTR, parameters: ["shopQRCode":shopQRCodeID], encoding: "get", T: self, ShowStr: false, finishedCallback: { (data) in
            self.dataArray.removeAllObjects()
            if let data1Array = data.value(forKey: "data") as? NSArray{
                
                if let modelArray = NSArray.yy_modelArray(with: activityShopModel.self, json: data1Array){
                    
                    self.dataArray.addObjects(from: modelArray)
                    
                    
                    self.tableView.reloadData()
                    
                    if self.dataArray.count > 0{
                        
                        self.view.addSubview(self.tableView)
                    }else{
                        self.tableView.removeFromSuperview()
                        
                        //                        let imageview = UIImageView.init(image: UIImage.init(named: "activity213456"))
                        //                        //imageview.contentMode = .scaleAspectFill
                        //                        imageview.frame = CGRect.init(x: 100, y: 100, width: ScreenW/2, height: ScreenH/2)
                        //                        //self.view.center = imageview.center
                        
                        let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: ScreenW, height: ScreenH))
                        
                        label.text = "暂无数据"
                        label.textAlignment = .center
                        self.view.backgroundColor = UIColor.white
                        self.view.addSubview(label)
                        
                    }
                    
                }
                
            }
            
        }) { (error) in
            
            
        }
        
    }
    
    //上架下架删除
    
    func modifiyGetNetData(para:[String:String]){
        
        NetworkTools.requestData(type:.post, URLString: activitychannelshopgoodsmodifyToSTR, parameters: para, encoding: "post", T: self, ShowStr: false, finishedCallback: { (data) in
            
            self.getNetData()
            
            
        }) { (error) in
            
            
        }
        
    }
    
    
    
}
