//
//  messageStyleTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/22.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class messageStyleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView!
    
    @IBOutlet weak var DetailLabel: UILabel!
    lazy var data11Array:NSMutableArray = {
        
        
        return NSMutableArray()
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:optionsModel? = nil{
        
        didSet{
           
            if let imgStr = model?.img{
                self.headerImageView.sd_setImage(with: URL.init(string: imgStr), placeholderImage: nil)
            }
            
            self.DetailLabel.text = model?.title
            
        }
        
    }
    
}
