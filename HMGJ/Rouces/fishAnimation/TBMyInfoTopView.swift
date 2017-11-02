//
//  TBMyInfoTopView.swift
//  170915
//
//  Created by 赵国进 on 2017/9/15.
//  Copyright © 2017年 上海途宝网络科技. All rights reserved.
//

import UIKit

class TBMyInfoTopView: UIView {
    
    //提供给外部调用接口
    
    ///曲线振幅
    var waterAmplitude: CGFloat = 8
    ///曲线角速度
    var waterPalstance: CGFloat = 0
    ///曲线初相
    var waterX: CGFloat = 0
    ///曲线偏距,越小距离顶端越近
    let waterY: CGFloat = 50
    ///曲线移动速度
    var waterMoveSpeed: CGFloat = 0

    fileprivate let waterColor = UIColor(red: 118/255.0, green: 165/255.0, blue: 242/255.0, alpha: 0.3)
    fileprivate let BackGroundColor = UIColor(red: 80/255.0, green: 140/255.0, blue: 238/255.0, alpha: 1)
    //前面的波浪
    fileprivate let waterLayer1 = CAShapeLayer()
    fileprivate let waterLayer2 = CAShapeLayer()
    fileprivate var disPlayLink = CADisplayLink()
    
    //阳光
    var sunshinView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = BackGroundColor
        buildInterface()
        buildData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildInterface(){
        
        //珊瑚
        let shImageView = UIImageView(frame: CGRect(x: frame.width - 60, y: frame.height - 60, width: 60, height: 60))
        shImageView.image = #imageLiteral(resourceName: "shanhu.png")
        addSubview(shImageView)
        let scImageView = UIImageView(frame: CGRect(x: 150, y: frame.height - 40, width: 40, height: 40))
        scImageView.image = #imageLiteral(resourceName: "shuicao.png")
        addSubview(scImageView)
        
        sendSubview(toBack: scImageView)
        
        //初始化波浪
        waterLayer1.fillColor = waterColor.cgColor
        waterLayer1.strokeColor = waterColor.cgColor
        waterLayer1.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        waterLayer2.fillColor = waterColor.cgColor
        waterLayer2.strokeColor = waterColor.cgColor
        waterLayer2.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        layer.addSublayer(waterLayer1)
        layer.addSublayer(waterLayer2)
        
        //阳光
        sunshinView = UIImageView(frame: CGRect(x: 200, y: -100, width: 200, height: 200))
        sunshinView.image = #imageLiteral(resourceName: "gx.png")
        addSubview(sunshinView)
        // 创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        // 设置动画属性
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 20
        anim.isRemovedOnCompletion = false
        // 将动画添加到图层上
        sunshinView.layer.add(anim, forKey: nil)
        
        //鱼群
        let fishView = FishView(frame: CGRect(x: 0, y: waterY + 10, width: frame.width, height: frame.height - waterY - 10))
        fishView.backgroundColor = UIColor.clear
        insertSubview(fishView, belowSubview: shImageView)
        Timer.scheduledTimer(timeInterval: TimeInterval(arc4random() % 10 + 5), target: self, selector: #selector(self.showBubble(timer:)), userInfo: nil, repeats: false)
    }
    
    ///初始化数据
    func buildData(){
        waterPalstance = CGFloat(Double.pi) / bounds.size.width
        waterMoveSpeed = 5 * waterPalstance
        //以屏幕刷新速度为周期刷新曲线的位置
        disPlayLink = CADisplayLink(target: self, selector: #selector(self.updatewater(link:)))
        disPlayLink.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    func updatewater(link: CADisplayLink){
        //更新x
        waterX += waterMoveSpeed
        updatewater(shapLayer: waterLayer1, isSin: false)
        updatewater(shapLayer: waterLayer2, isSin: true)
    }
    
    func updatewater(shapLayer: CAShapeLayer, isSin: Bool){
        //波浪宽度
        let waterwaterWidth = bounds.size.width
        //初始化运动路径
        let path = CGMutablePath()
        //设置起始位置
        path.move(to: CGPoint(x: 0, y: waterY))
        //初始化波浪,y为偏距
        var tempY = waterY
        //正弦曲线公式为： y=Asin(ωx+φ)+k
        for x in 0..<Int(waterwaterWidth){
            tempY = isSin ? waterAmplitude * sin(waterPalstance * CGFloat(x) + waterX) + waterY : waterAmplitude * cos(waterPalstance * CGFloat(x) + waterX) + waterY
            path.addLine(to: CGPoint(x: CGFloat(x), y: tempY))
        }
        //填充底部颜色
        path.addLine(to: CGPoint(x: waterwaterWidth, y: 200))
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.closeSubpath()
        shapLayer.path = path
    }
    
    func showBubble(timer:Timer){
        
        //气泡数量
        let num = arc4random() % 5
        //x坐标
        let x = arc4random() % UInt32(frame.width)
        if let bubbleView = TBBubbleView(frame: CGRect(x: CGFloat(x), y: self.frame.height - 10, width: 0, height: 0), folatMaxLeft: 30, folatMaxRight: 30, folatMaxHeight: frame.height - waterY - 20, bubbleNum: Int(num)){
            insertSubview(bubbleView, at: 3)
            if let image = UIImage.init(named: "2"){
                bubbleView.images = [image]
            }
            bubbleView.duration = 4
            bubbleView.startBubble()
            
            timer.invalidate()
            Timer.scheduledTimer(timeInterval: TimeInterval(arc4random() % 10 + 5), target: self, selector: #selector(self.showBubble(timer:)), userInfo: nil, repeats: true)
        }
    }
    
}
