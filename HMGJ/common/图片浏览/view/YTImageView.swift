//
//  YTImageView.swift
//  MovieFansDemo1
//
//  Created by 余婷 on 16/10/13.
//  Copyright © 2016年 余婷. All rights reserved.
//

import UIKit

class YTImageView: UIImageView {

    //MARK: - 属性
    var target:AnyObject? = nil
    var action:Selector? = nil
    
    //添加事件
    func addtarget(target:AnyObject,action:Selector){
        //打开用户交互
        self.isUserInteractionEnabled = true
        //保存数据
        self.target = target
        self.action = action
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.target != nil {
            
            self.target?.perform(self.action!, with: self)
        }
    }
    
}
