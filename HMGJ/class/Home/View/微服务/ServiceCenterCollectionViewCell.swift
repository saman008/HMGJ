//
//  ServiceCenterCollectionViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/15.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class ServiceCenterCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var DetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.RGBColor(R: 231, G: 231, B: 231, A: 1).cgColor
        
        
        
    }

    var model:service_centerModel? = nil{
        
        didSet{
            
            if let aa = model?.icon{
                
                self.headerImageView.sd_setImage(with: URL.init(string: aa), placeholderImage: nil)
                
            }
            
            self.nameLabel.text = model?.name
            
            self.DetailLabel.text = model?.remark
            
            
        }
        
    }
}
