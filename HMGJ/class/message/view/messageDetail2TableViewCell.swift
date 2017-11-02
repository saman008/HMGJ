//
//  messageDetail2TableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/21.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class messageDetail2TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var DetailLabel: UILabel!
    
    @IBOutlet weak var bakVIew: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //207,51,51
        bakVIew.backgroundColor = UIColor.RGBA(51, 51, 51, 0.8)
        
        
        
    }

    var model:optionsModel? = nil{
        
        didSet{

            
            self.headerImageView.sd_setImage(with: URL.init(string: model!.img), placeholderImage: nil)
            
            self.DetailLabel.text = model?.title
            
        }
        
    }

    
    
}
