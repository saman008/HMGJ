//
//  reportCollectionViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/14.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class reportCollectionViewCell: UICollectionViewCell {
//    payway
//    paywayImg
//    tradeSum
//    tradeNum
//    origin

    @IBOutlet weak var paywayImgViewImage: UIImageView!
    
    @IBOutlet weak var tradeSumLabel: UILabel!
    
    @IBOutlet weak var tradeNumLabel: UILabel!
    
    @IBOutlet weak var paywayLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:the_reportModel? = nil{
        
        didSet{
            
            if let aa = model?.paywayImg{
                self.paywayImgViewImage.sd_setImage(with: URL.init(string: aa), placeholderImage: nil)
            }
            if let bb = model?.tradeNum{
                self.tradeNumLabel.text = "笔数 " + bb
            }
            
            if let cc = model?.tradeSum{
                self.tradeSumLabel.text = "金额 " + cc
            }
//            if let dd = {
//                
//            }
            
            self.paywayLabel.text = model?.payway
            
        }
        
    }
    
}
