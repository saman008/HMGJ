//
//  YTView.swift
//  03-转场动画
//
//  Created by 余婷 on 16/8/29.
//  Copyright © 2016年 余婷. All rights reserved.
//

import UIKit

public enum TransitionType:String{
    ///交叉淡化过渡
    case Fade = "fade"
    ///新视图移到旧视图上面
    case MoveIn = "moveIn"
    ///新视图把旧视图推出去
    case Push = "push"
    ///将旧视图移开,显示下面的
    case Reveal = "reveal"
    ///向上翻一页
    case PageCurl = "pageCurl"
    ///向下翻一页 
    case PageUnCurl = "pageUnCurl"
    ///滴水效果
    case RippleEffect = "rippleEffect"
    ///收缩效果，如一块布被抽走 
    case SuckEffect = "suckEffect"
    ///立方体效果
    case Cube = "cube"
    ///上下翻转效果
    case OglFlip = "oglFlip"
}

public enum TransitionDirection:String {
    case FromRight = "fromRight"
    case FromLeft = "fromLeft"
    case FromTop = "fromTop"
    case FromBottom = "fromBottom"
}

extension UIView{
    
    ///添加转场动画
    public func addTransitionAnimation(duration:Double,type:TransitionType,direction:TransitionDirection){
        
        //1.创建动画对象
        let animation = CATransition.init()
        //2.设置动画时间
        animation.duration = duration
        //3.设置动画类型
        animation.type = type.rawValue
        //4.设置动画方向
        animation.subtype = direction.rawValue
        //5.添加动画
        self.window?.layer.add(animation, forKey: nil)
        
    }

    
}
