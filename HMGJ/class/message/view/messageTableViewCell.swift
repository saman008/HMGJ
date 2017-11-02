//
//  messageTableViewCell.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/8/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit
import SDWebImage

class messageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var headerimageView: UIImageView!
    
    @IBOutlet weak var reactlabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reactlabel.layer.masksToBounds = true
        reactlabel.layer.cornerRadius = 5
    }
    
    var model:messageModel? = nil{
        
        didSet{
            
            headerimageView.sd_setImage(with: NSURL.init(string: model!.head) as URL?, completed:nil)
            reactlabel.text = model?.unreadAmt
            
            if let modelreact = model?.unreadAmt{
                
                if modelreact == "0"{
                    reactlabel.isHidden = true
                }
                
            }
            
            titleLabel.text = model?.name
            detailLabel.text = model?.title
            timeLabel.text = model?.time
            
            
        }
    }
    
    
}
