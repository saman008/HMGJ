//
//  AllWebViewController.swift
//  FunLife
//
//  Created by Forever on 2017/6/29.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit

class AllWebViewController: BaseViewController,UIWebViewDelegate {

    //MARK: - 属性
    
    let webView = UIWebView()
    var firstA = ""
    var url = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置背景颜色
        self.view.backgroundColor = UIColor.white
        
        //创建webView
        self.webView.frame = self.view.bounds
        self.view.addSubview(self.webView)
        webView.delegate = self
        
        if url.contains("http"){
            if url.contains("memberId"){
                
            }else{
                if url.contains("?"){
                    url = url + "&memberId=\(memberId)&shopQRCode=\(shopQRCodeID)"
                }else{
                    url = url + "?memberId=\(memberId)&shopQRCode=\(shopQRCodeID)"
                }
            }
        }
        
        let reqeust = NSMutableURLRequest(url: NSURL(string: url)! as URL)
//        reqeust.setValue("\(tickets)", forHTTPHeaderField: "userTicket")
        
        webView.loadRequest(reqeust as URLRequest)
       ToolManger.defaultShow(Str: "正在加载", T: self)
        //        //按钮返回
//        let leftBtn = UIButton(frame: CGRectMake(20,20,50,50))
//        leftBtn.addTarget(self, action: "popAction", forControlEvents: UIControlEvents.TouchDown)
//        leftBtn.setTitle("返回", forState: UIControlState.Normal)
//        leftBtn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
//        
//        self.webView.addSubview(leftBtn)
//        if firstA == "1"{
//            leftBtn.hidden = false
//        }else{
//            leftBtn.hidden = true
//        }
        
    }
    
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        self.title = webView.stringByEvaluatingJavaScript(from: "document.title")
        
//        //获取url
//        let url = webView.stringByEvaluatingJavaScript(from: "document.location.href") ?? "" as String
//        print("url:\(url)")
//        
//        //获取标题
//        let title = webView.stringByEvaluatingJavaScript(from: "document.title") ?? "" as String
//        print("title:\(title)")
//        
//        //获取高度
//        let height = webView.stringByEvaluatingJavaScript(from: "document.body.offsetHeight;")
//        print("height:\(height)")
//        
//        //获取宽度
//        let width = webView.stringByEvaluatingJavaScript(from: "document.body.offsetWidth;")
//        print("width:\(width)")
//        
//        //获取body
//        let body = webView.stringByEvaluatingJavaScript(from: "document.body.innerText") ?? "" as String
//        print("body:\(body)")
    }

    
    
//    
//    func popAction(){
//        
//        self.navigationController?.popViewController(animated: <#T##Bool#>)
//        
//        
//    }

}
