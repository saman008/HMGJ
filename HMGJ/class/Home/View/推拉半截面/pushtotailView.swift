//
//  pushtotailView.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/13.
//  Copyright © 2017年 冷轶. All rights reserved.
//
protocol ToolBtnProrocol : class{
    func didAction(index:[NSIndexPath])
    
}

import UIKit

class pushtotailView: UIView,PickerDateViewDelegate {
    var collectionView:UICollectionView!
    
//    var headerdataArray = NSMutableArray() {
//        
//        didSet{
//            
//            self.collectionView.reloadData()
//        }
//    }
    var liushuiorbaobiaoStr = ""
    lazy var headerdataArray:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    var twodataArray = [[newRunningModel]]()
    
   // var sendValue:((String)->Void)? = nil
    var delegate:ToolBtnProrocol? = nil
    @IBOutlet weak var bonsd: NSLayoutConstraint!

    @IBOutlet weak var view1: UIView!
    var tableView1:UITableView!
    
    @IBOutlet weak var okBtn: UIButton!
    
    var value1 = "请选择开始时间"
    var value2 = "请选择结束时间"
    
    var value3 = ""
    var value4 = ""
    var valueALL = ""
    
    
    var reportValue1 = ""
    var reportValue2 = ""
    var reportValue3 = ""
    
    var reportAllValue = ""
    override func draw(_ rect: CGRect) {
        
        bonsd.constant = ScreenW / 4
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRect.init(x: 10, y: 30, width: ScreenW / 4 * 3 - 20, height: ScreenH-80), collectionViewLayout: layout)
        // 注册一个cell
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView?.delegate = self;
        collectionView?.dataSource = self;
        collectionView.register(UINib.init(nibName:"pushDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pushDetailCollectionViewCell")
        
        collectionView.register(UINib.init(nibName:"TrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrandCollectionViewCell")
        
        //系统自己的header
        //        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        collectionView.register(UINib.init(nibName: "reportFooterCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reportFooterCollectionViewCell")
        
        collectionView.register(UINib.init(nibName: "reportDanTimeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reportDanTimeCollectionViewCell")
        
        //消除滚动条
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        //设置每一个cell的宽高
        self.collectionView.allowsMultipleSelection = true
        collectionView.backgroundColor = UIColor.white
        //layout.itemSize = CGSize.init(width: ScreenW/2, height: 140)
        self.view1.addSubview(collectionView)

        
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.removeFromSuperview()
        
        
    }
    
    //按日按月统计点击按钮触发事件
    func daysAction(btn:UIButton){
        
        if reportValue1 == ""{
            self.pick()
            reportValue3 = "1"
        }else if reportValue1 == "1"{
         
            reportValue1 = ""
            //btn.backgroundColor = UIColor.gray
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
            btn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        }
        
    }
    
    func monthAction(btn:UIButton){
        
        if reportValue2 == ""{
            self.pick()
            reportValue3 = "2"
        }else if reportValue2 == "1"{
            reportValue2 = ""
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
            btn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        }
        
        
    }
    
    func timeAction(btn:UIButton){
        
        self.pick()
        
        
    }
    
    
    //开始时间
    func startTimeAction(btn:UIButton){
        self.value1 = "1"
        self.pick()
        
    }
    //结束时间
    func endTimeAction(btn:UIButton){
     
        self.value1 = "2"
        self.pick()
        
        
//        // 刷新第几组，直接传入要刷新的组数集合 “[section]”
//        self.tableView.reloadSections([1], with: .fade)
        
//        // 刷新从第0组开始的两组，也就是刷新 第0组 和 第1组
//        let index = NSIndexSet.init(indexesIn: NSMakeRange(0, 2))
//        self.tableView1.reloadSections(index, with: UITableViewRowAnimation.fade)
    }

}
extension pushtotailView{
    
    func pick(){
        let pickerDate = WXZPickDateView()
        pickerDate.isAddYetSelect = false
        pickerDate.isShowDay = true
        let date = NSDate()
        let calendar = NSCalendar.current
        //这里注意 swift要用[,]这样方式写
       
        let com = calendar.dateComponents([.year,.month,.day], from: date as Date)
       
        let a = com.year
        
        let b = com.month
        
        let c = com.day
        
        pickerDate.setDefaultTSelectYear(a!, defaultSelectMonth: b!, defaultSelectDay: c!)
        pickerDate.delegate = self
        pickerDate.show()
    }
    
    func pickerDateView(_ pickerDateView: WXZBasePickView!, selectYear year: Int, selectMonth month: Int, selectDay day: Int) {
        print(month)
        var monthStr = ""
        if month >= 0 && month < 10{
            
            monthStr = "0" + "\(month)"
            
        }else{
            monthStr = "\(month)"
        }
        
        let value = "\(year)-\(monthStr)-\(day)"
        if liushuiorbaobiaoStr == "2"{
            
            let index = IndexPath.init(row: 0, section: 0)
            let cell = self.collectionView.cellForItem(at: index) as! reportDanTimeCollectionViewCell
            
            //按日统计
            if reportValue3 == "1"{
                reportValue1 = "1"
                reportValue2 = ""
                //cell.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
                
                cell.daysBtn.layer.borderWidth = 0.5
                cell.daysBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
                cell.daysBtn.layer.borderColor = UIColor.red.cgColor
                cell.daysBtn.backgroundColor = UIColor.white
                
                cell.monthBtn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
                cell.monthBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
                cell.monthBtn.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
                cell.timeBtn.setTitle("\(year)-\(monthStr)-\(day)", for: UIControlState.normal)
                
                reportAllValue = "\(year)-\(monthStr)-\(day)"
            }
            //按月统计
            else if reportValue3 == "2"{
                reportValue1 = ""
                reportValue2 = "1"
                
                cell.monthBtn.layer.borderWidth = 0.5
                cell.monthBtn.setTitleColor(UIColor.red, for: UIControlState.normal)
                cell.monthBtn.layer.borderColor = UIColor.red.cgColor
                cell.monthBtn.backgroundColor = UIColor.white
                
                cell.daysBtn.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
                cell.daysBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
                cell.daysBtn.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
                cell.timeBtn.setTitle("\(year)-\(monthStr)", for: UIControlState.normal)
                reportAllValue = "\(year)-\(monthStr)"
            }
            
        }else{
            let index = IndexPath.init(row: 0, section: 3)
            let cell = self.collectionView.cellForItem(at: index) as! TrandCollectionViewCell
            
            if value1 == "1"{
                
                cell.startBtn.setTitle(value, for: UIControlState.normal)
                value3 = value + " 00:00:00"
            }
            if value1 == "2"{
                
                cell.endBtn.setTitle(value, for: UIControlState.normal)
                value4 = value + " 23:59:59"
            }
        }
        
        //"2017-06-16 00:00:00,2017-09-16 23:59:59"
        
//        NSUInteger section = 0;
//        NSUInteger row = 1;
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
//        
//        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

        // 刷新某一组
//        let indexPath: IndexPath = IndexPath.init(row: 0, section: 3)
//        self.tableView1.reloadRows(at: [indexPath], with: .fade)
        print(year)
        print(month)
        print(day)
        
    }
    
    
    
}
extension pushtotailView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return self.headerdataArray.count//4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let model = self.headerdataArray[section] as? newRunningModel
        
        if let aa = model?.value{
            if aa == "time" && self.liushuiorbaobiaoStr == ""{
                return 1
            }else if aa == "time" && self.liushuiorbaobiaoStr == "2"{
             
                return 1
            }
            
            else{
                return self.twodataArray[section].count
            }
        }
        
        return 0
//        if section == 3{
//            return 1
//        }else{
//            return 6
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = self.headerdataArray[indexPath.section] as? newRunningModel
        
        if let aa = model?.value{
            if aa == "time" && self.liushuiorbaobiaoStr == ""{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrandCollectionViewCell", for: indexPath) as! TrandCollectionViewCell
                
                let aa = Running_waterViewController()
                
                cell.startBtn.addTarget(aa, action: #selector(startTimeAction(btn:)), for: UIControlEvents.touchUpInside)
                
                cell.endBtn.addTarget(aa, action: #selector(endTimeAction(btn:)), for: UIControlEvents.touchUpInside)
                
                return cell
            }else if aa == "time" && self.liushuiorbaobiaoStr == "2"{
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reportDanTimeCollectionViewCell", for: indexPath) as!reportDanTimeCollectionViewCell
                
                let bb = The_reportViewController()
                
                cell.daysBtn.addTarget(bb, action: #selector(daysAction(btn:)), for: UIControlEvents.touchUpInside)
                
                cell.monthBtn.addTarget(bb, action: #selector(monthAction(btn:)), for: UIControlEvents.touchUpInside)
                
                cell.timeBtn.addTarget(bb, action: #selector(timeAction(btn:)), for: UIControlEvents.touchUpInside)
                
                return cell
                
            }
            
            
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pushDetailCollectionViewCell", for: indexPath) as! pushDetailCollectionViewCell
                
                cell.model = self.twodataArray[indexPath.section][indexPath.row]
                
                
                if cell.isSelected == true{
                    cell.backgroundColor = UIColor.white
                    
                }else{
                    cell.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
                }
                
                
                return cell
            }
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pushDetailCollectionViewCell", for: indexPath) as! pushDetailCollectionViewCell
        
        cell.model = self.twodataArray[indexPath.section][indexPath.row]
        cell.tag = indexPath.row + 100
        if cell.isSelected == true{
            cell.backgroundColor = UIColor.white
            
        }else{
            cell.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        
        let model = self.headerdataArray[indexPath.section] as? newRunningModel
        
        if let aa = model?.value{
            if aa == "time" && self.liushuiorbaobiaoStr == ""{
                return
            }else if aa == "time" && self.liushuiorbaobiaoStr == "2"{
                return
            }else{
                
                let cell = collectionView.cellForItem(at: indexPath) as! pushDetailCollectionViewCell
                
                cell.minLabel.textColor = UIColor.black
                cell.layer.borderColor = UIColor.clear.cgColor
                cell.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
                //cell?.backgroundColor = UIColor.gray
                //获取多选的数组
                let indexPaths = collectionView.indexPathsForSelectedItems
                delegate?.didAction(index: indexPaths! as [NSIndexPath])
                if let indexArray = indexPaths as NSArray?{
                    print(indexArray)
                    for i in indexArray{
                        
                        if let item = i as? NSIndexPath{
                            
                            //                    print(item.row)
                            //                    print(item.section)
                        }
                    }
                }
                print("取消点击")
            }
        }

        
        let cell = collectionView.cellForItem(at: indexPath) as! pushDetailCollectionViewCell
        
        cell.minLabel.textColor = UIColor.black
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.backgroundColor = UIColor.RGBColor(R: 242, G: 242, B: 242, A: 0.95)
        //cell?.backgroundColor = UIColor.gray
        //获取多选的数组
        let indexPaths = collectionView.indexPathsForSelectedItems
        delegate?.didAction(index: indexPaths! as [NSIndexPath])
        if let indexArray = indexPaths as NSArray?{
            print(indexArray)
            for i in indexArray{
                
                if let item = i as? NSIndexPath{
                    
                    //                    print(item.row)
                    //                    print(item.section)
                }
            }
        }
        print("取消点击")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        
        let model = self.headerdataArray[indexPath.section] as? newRunningModel
        
        if let aa = model?.value{
            if aa == "time" && self.liushuiorbaobiaoStr == ""{
                return
            }else if aa == "time" && self.liushuiorbaobiaoStr == "2"{
                return
            }else{
                let cell = collectionView.cellForItem(at: indexPath) as! pushDetailCollectionViewCell
                
                cell.minLabel.textColor = UIColor.red
                cell.backgroundColor = UIColor.white
                cell.layer.borderColor = UIColor.red.cgColor
                //cell.backgroundColor = UIColor.red
                
                
                //获取多选的数组
                let indexPaths = collectionView.indexPathsForSelectedItems
                delegate?.didAction(index: indexPaths! as [NSIndexPath])
                
                
                if let indexArray = indexPaths as NSArray?{
                    print(indexPaths)
                    
                    for i in indexArray{
                        
                        if let item = i as? NSIndexPath{
                            
                            //                    print(item.row)
                            //                    print(item.section)
                        }
                    }
                }
                
                print("点击")
            }
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! pushDetailCollectionViewCell
        
        cell.minLabel.textColor = UIColor.red
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.red.cgColor
        //cell.backgroundColor = UIColor.red
        
       
        //获取多选的数组
        let indexPaths = collectionView.indexPathsForSelectedItems
        delegate?.didAction(index: indexPaths! as [NSIndexPath])

        
        if let indexArray = indexPaths as NSArray?{
            print(indexPaths)
            
            for i in indexArray{
                
                if let item = i as? NSIndexPath{
                    
//                    print(item.row)
//                    print(item.section)
                }
            }
        }
        
        print("点击")
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! choiceCollectionViewCell
        
       // delegate?.didRecleve(index: indexPath.row)
        //        let allVC = allThreeViewController()
        //
        //        self.navigationController?.pushViewController(allVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let model = self.headerdataArray[indexPath.section] as? newRunningModel
        
        if let aa = model?.value{
            if aa == "time" && self.liushuiorbaobiaoStr == ""{
                return CGSize.init(width: ScreenW / 4 * 3, height: 100)
            }else if aa == "time" && self.liushuiorbaobiaoStr == "2"{
                return CGSize.init(width: ScreenW / 4 * 3, height: 120)
            }
            
            else{
                return CGSize.init(width: (ScreenW / 4 * 3 - 40) / 3, height: 50)
            }
        }
        
//        if indexPath.section == 3{
//            return CGSize.init(width: ScreenW / 4 * 3, height: 100)
//        }else{
//            return CGSize.init(width: (ScreenW / 4 * 3 - 40) / 3, height: 50)
//        }
        return CGSize.init(width: 1, height: 1)
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
        
        let model = self.headerdataArray[indexPath.section] as? newRunningModel
       
        reusableview.titleLabel.text = model?.key
//        if indexPath.section == 0{
//            reusableview.titleLabel.text = model?.value//"收款方式"
//        }else if indexPath.section == 1{
//            reusableview.titleLabel.text = model?.value//"交易方式"
//        }else if indexPath.section == 2{
//             reusableview.titleLabel.text = model?.value//"收银员"
//        }else if indexPath.section == 3{
//             reusableview.titleLabel.text = model?.value//"交易时间"
//        }
        return reusableview
    }
    
}

