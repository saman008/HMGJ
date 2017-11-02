//
//  activityshopTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/10/16.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class activityshopTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUrlImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var isPutLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var modfiyBtn: UIButton!
    
    @IBOutlet weak var getupBtn: UIButton!
    
    @IBOutlet weak var cutBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:activityShopModel? = nil{
        
        didSet{
            
            if let imgurlStr = model?.imgUrl{
                self.imgUrlImageView.sd_setImage(with: URL.init(string: imgurlStr), placeholderImage: nil)
                
                
            }
            
            if let isput = model?.isPut{
                
                if isput == "0"{
                    self.isPutLabel.text = "未上架"
                    self.getupBtn.setTitle("上架", for: UIControlState.normal)
                }else if isput == "1"{
                    self.isPutLabel.text = "已上架"
                    self.getupBtn.setTitle("下架", for: UIControlState.normal)
                }
                
            }
            
            self.nameLabel.text = model?.name
            
            if let price = model?.price{
                
                let pricea = (price as NSString).floatValue
                let priceb = pricea / 100
                let pricec = String.init(format: "%.2f", priceb)
                self.priceLabel.text = "\(pricec)元/\(model!.unit)"
                
            }
            
        }
        
    }

    
}
