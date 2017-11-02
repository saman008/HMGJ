//
//  ImageContentView.swift
//  MovieFansDemo1
//
//  Created by 余婷 on 16/9/29.
//  Copyright © 2016年 余婷. All rights reserved.
//

import UIKit

//MARK: - 协议
protocol ImageContentViewDelegate {
    
    func showAllImage(imageUrlArray:[String],selectedIndex:Int)
    //func iconImagePush(index:Int)
}

class ImageContentView: UIView {

    //MARK: - 属性
    //0.代理
    var delegate:ImageContentViewDelegate? = nil
    var icondelegate:ImageContentViewDelegate? = nil
    
    //1.图片数组
    var imageurlArray:[String]? = nil{
        didSet{
            
            //移除图片容器视图上原来的imageView
            for item in self.subviews {
                
                item.removeFromSuperview()
            }
            
            //根据图片数组创建对应的imageView
            var i = 1
            
            for item in imageurlArray! {
                
                let imageView = YTImageView.init()
                imageView.sd_setImage(with: URL.init(string: item), placeholderImage: nil)
                //添加点击事件
                imageView.addtarget(target: self, action: Selector(("imageAction:")))
                //imageView.addtarget(self, action: "iconAction:")
                //设置tag
                imageView.tag = i
                i += 1
                //添加图片
                self.addSubview(imageView)
                
            }
            
        }
    }

}

//MARK: - 点击事件
extension ImageContentView{
    
//    func iconAction(imageView:YTImageView){
//        self.delegate?.iconImagePush(imageView.tag)
//    }

    func imageAction(imageView:YTImageView) {
        
        self.delegate?.showAllImage(imageUrlArray: self.imageurlArray!, selectedIndex:imageView.tag)
    }
}
//MARK: - 计算frame
extension ImageContentView{

    override func layoutSubviews() {
        
        //获取图片张数
        let count = self.imageurlArray?.count
        //间距
        let margin:CGFloat = 2
        //容器的宽和高
        let contentW = self.frame.size.width
        let contentH = self.frame.size.height
        
        //1.一张图
        if count == 1 {
            
            let x = margin
            let y = margin
            let w = contentW - margin*2
            let h = contentH - margin*2
            for item in self.subviews {
                
                item.frame = CGRect.init(x: x, y: y, width: w, height: h)
            }
            
            return
        }
        
        //2.两张/四张图
        if count==2 || count==4 {
            
            let w = (contentW - margin*3)/2
            let h = (contentH - margin * CGFloat(count!/2 + 1)) / CGFloat(count!/2)
            for (i,item) in self.subviews.enumerated() {
                
                let x = margin + (margin+w) * CGFloat(i%2)
                let y = margin + (margin+h) * CGFloat(i/2)
                
                item.frame = CGRect.init(x: x, y: y, width: w, height: h)
            }
            return
        }
        
        //3.三张/四张以上
        if count!==3 || count!>4 {
            
            let w = (contentW - 4*margin)/3
            //行数
            var line = 0
            if count!%3 == 0 {
                line = count!/3
            }else{
            
                line = count!/3 + 1
            }
            let h = (contentH - CGFloat(line+1)*margin) / CGFloat(line)
            
            for (i,item) in self.subviews.enumerated() {
                
                let x = margin + (margin + w) * CGFloat(i%3)
                let y = margin + (margin + h) * CGFloat(i/3)
                
                item.frame = CGRect.init(x: x, y: y, width: w, height: h)
            }
        }
        
        
    }//
}


