//
//  FishView.swift
//  帧动画
//
//  Created by 赵国进 on 2017/9/16.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

import UIKit

class FishView: UIView {
    
    var fishMaxNum = 5

    fileprivate var imageViewArray = [UIImageView]()
    fileprivate var timer: Timer!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 0..<fishMaxNum{
            let x = arc4random() % UInt32(abs(frame.width - 60))
            let y = arc4random() % UInt32(abs(frame.height - 35))
            let w = arc4random() % 50 + 10
            let h = arc4random() % 30 + 5
            let imageView = UIImageView(frame: CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(w), height: CGFloat(h)))
            addSubview(imageView)
            imageViewArray.append(imageView)
        }
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func timerAction(timer:Timer){
        let count = imageViewArray.count
        //随机要动的鱼数量
        let num = arc4random() % UInt32(count)
        for _ in 0..<num{
            //随机数组中哪几个动
            let num2 = arc4random() % UInt32(count)
            changeFrame(imageView: imageViewArray[Int(num2)])
        }
        
        timer.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(arc4random() % 5 + 1), target: self, selector: #selector(self.timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    func changeFrame(imageView: UIImageView){
        let tempX = CGFloat(arc4random() % 100) - 50
        let tempY = CGFloat(arc4random() % 100) - 50
        let frameOr = imageView.frame.origin
        if tempX + frameOr.x > 0 && tempX + frameOr.x < frame.width - imageView.frame.width{
            imageView.stopAnimating()
            if tempX + frameOr.x > imageView.frame.origin.x{
                animation(isLeft: false, imageView: imageView)
            }else{
                animation(isLeft: true, imageView: imageView)
            }
            UIView.animate(withDuration: TimeInterval(arc4random() % 5 + 1), animations: {
                imageView.frame.origin.x += tempX
            })
        }
        if tempY + frameOr.y > 0 && tempY + frameOr.y < frame.height - imageView.frame.height{
            UIView.animate(withDuration: TimeInterval(arc4random() % 5 + 1), animations: {
                imageView.frame.origin.y += tempY
            })
        }
    }
    
    func animation(isLeft: Bool, imageView: UIImageView){
        imageView.animationImages = []
        for item in 0...9{
            let imageName = isLeft ? "fishl\(item).png" : "fish\(item).png"
            let image = UIImage(named: imageName)
            imageView.animationImages?.append(image!)
            
        }
        imageView.animationDuration = Double((arc4random() % 20) + 5) / 10.0
        imageView.startAnimating()
    }

}
