//
//  ShowImageViewController.swift
//  MovieFansDemo1
//
//  Created by 余婷 on 16/10/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

import UIKit
import KVNProgress

class ShowImageViewController: UIViewController {
    //MARK: - 控件属性
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func finishAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
     //将图片保存到手机相册中
    @IBAction func saveAction(_ sender: UIButton) {
        KVNProgress.show(withStatus: "正在保存")
        //1.取出需要保存的图片
        //取出图片所在的cell
        let cell = collectionView.cellForItem(at: NSIndexPath.init(item: self.seletedIndex-1, section: 0) as IndexPath) as! PhotoCollectionViewCell
        //取出图片
        let image = cell.coverImageView.image
        
        //2.保存图片
        //将指定的图片存到相册中
        //参数1:将要保存的图片
        //参数2,参数3:图片保存后参数2调用参数3
        //注意:参数3中函数的格式是固定的
        
        UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(image:error:contextInfo:)), nil)
        
    }
    
    //MARK: - 数据属性
    var imageArray = [String]()  //图片数组
    var seletedIndex = 1   //选中的图片下标
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //注册cell
        self.collectionView.register(UINib.init(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        //设置当前显示的页数
        self.numberLabel.text = "\(self.seletedIndex)/\(self.imageArray.count)"
        self.collectionView.isHidden = true
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //设置偏移量，默认显示被点击的图片
        self.collectionView.contentOffset = CGPoint.init(x: ScreenW * CGFloat(self.seletedIndex-1), y: 0)
        self.collectionView.isHidden = false
    }
    
    
    


}

//MARK: - collectionView 协议方法
extension ShowImageViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! PhotoCollectionViewCell
        //刷新数据
        cell.imageUrlStr = self.imageArray[indexPath.row]
        //返回cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize.init(width: ScreenW, height: 400)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.seletedIndex = Int(scrollView.contentOffset.x/ScreenW)+1
        self.numberLabel.text = "\(self.seletedIndex)/\(self.imageArray.count)"
    }
    
}

//MARK: - 按钮点击
extension ShowImageViewController{

    
    
    func image(image:UIImage,error:NSError,contextInfo:AnyObject) {
        
        KVNProgress.showSuccess(withStatus: "保存成功")
    }
    
}
