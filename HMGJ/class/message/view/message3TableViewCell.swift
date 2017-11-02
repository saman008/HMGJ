//
//  message3TableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/21.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class message3TableViewCell: UITableViewCell {

    @IBOutlet weak var imgImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var model:optionsModel? = nil{
        
        
        didSet{
            
            self.titleLabel.text = model?.title
            self.imgImageView.sd_setImage(with: NSURL.init(string: model!.img) as! URL, placeholderImage: nil)
            
        }
        
    }
    
    
}
