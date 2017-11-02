

//
//  shoplistliushuiTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/29.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class shoplistliushuiTableViewCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        
    }
    var model:storelistModel? = nil{
        
        didSet{
            
            if let aa = model?.shopImgUrl{
                headerImageView.sd_setImage(with: URL.init(string: aa), placeholderImage: UIImage.init(named: "shop_image"))
            }
            
            
            self.titleLabel.text = model?.shopAlias
            
        }
        
    }

    
    
}
