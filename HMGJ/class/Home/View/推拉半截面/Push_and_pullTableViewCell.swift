//
//  Push_and_pullTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/13.
//  Copyright © 2017年 冷轶. All rights reserved.
//
protocol ToolProrocol : class{
    func didRecleve(index:Int)
    
}

import UIKit

class Push_and_pullTableViewCell: UITableViewCell {

    var delegate:ToolProrocol? = nil
    @IBOutlet weak var choiceCollectionView: UICollectionView!
    var dataArray = NSMutableArray() {
        
        didSet{
            
            self.choiceCollectionView.reloadData()
        }
    }
    let arr1 = ["spa","bar","club","feet","ktv","other"]
    let arr2 = ["水疗SPA","酒吧","俱乐部","足疗按摩","KTV","其他"]
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.choiceCollectionView.delegate = self
        self.choiceCollectionView.dataSource = self
        self.choiceCollectionView.allowsMultipleSelection = true
        self.choiceCollectionView.register(UINib.init(nibName: "pushDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
//        self.backgroundColor = BColor
//        self.choiceCollectionView.backgroundColor = BColor
        
    }
    
    
    
    
}
//获取多选的数组
//let indexPaths = self.collectionView?.indexPathsForSelectedItems()
extension Push_and_pullTableViewCell:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arr1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! pushDetailCollectionViewCell
        
        cell.backgroundColor = UIColor.gray
        
//        if cell.isSelected{
//            cell.backgroundColor = UIColor.blue
//        }else{
//            cell.backgroundColor = UIColor.red
//        }
        
//        cell.iconImageView.image = UIImage.init(named: arr1[indexPath.row])
//        cell.titleLabel.text = arr2[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.backgroundColor = UIColor.gray
        
        print("取消点击")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)

        cell?.backgroundColor = UIColor.red

        let a = Running_waterViewController()
        //获取多选的数组
        let indexPaths = collectionView.indexPathsForSelectedItems
        if let indexArray = indexPaths as NSArray?{
            for i in indexArray{
                
                if let item = i as? NSIndexPath{
                    a.timeStr = "\(item.row)"
                    print(item.row)
                    
                }
            }
        }
        
        print("点击")
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! choiceCollectionViewCell
        
        delegate?.didRecleve(index: indexPath.row)
        //        let allVC = allThreeViewController()
        //
        //        self.navigationController?.pushViewController(allVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 70, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0,0, 0)
    }

    
}
