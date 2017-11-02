//
//  PhotoCollectionViewCell.swift
//  YCL
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 app. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var coverImageView: UIImageView!
    
    //MARK: - 数据属性
    var imageUrlStr = ""{
        
        didSet{
            
            coverImageView.sd_setImage(with: URL.init(string: imageUrlStr), placeholderImage: nil)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
