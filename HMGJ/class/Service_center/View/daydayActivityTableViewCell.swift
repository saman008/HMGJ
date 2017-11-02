//
//  daydayActivityTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/9/12.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

class daydayActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var imgUrlImageView: UIImageView!

    @IBOutlet weak var checkDetailBtn: UIButton!
    
    @IBOutlet weak var textDetailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model:activitychannnelModel? = nil{
        
        didSet{
            
            self.textDetailLabel.text = model?.text
            if let aa = model?.imgUrl{
                
                self.imgUrlImageView.sd_setImage(with: URL.init(string: aa), placeholderImage: nil)
                //self.imgUrlImageView.contentMode = .scaleAspectFit
            }
            
        }
        
    }
    
    
}
