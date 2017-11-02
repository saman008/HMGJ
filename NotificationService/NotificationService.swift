//
//  NotificationService.swift
//  NotificationService
//
//  Created by 冷轶 on 2017/8/11.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UserNotifications
import AVFoundation
//#import “iflyMSC/IFlyMSC.h”

@available(iOSApplicationExtension 10.0, *)
class NotificationService: UNNotificationServiceExtension,AVSpeechSynthesizerDelegate{
    
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
//    //59dc7d34
//    //负责读推送内容
//    lazy var iFlySpeechSynthesizer:IFlySpeechSynthesizer = {
//        //单利创建
//        let tempObj = IFlySpeechSynthesizer.sharedInstance()!
//        //设置代理
//        tempObj.delegate = self as! IFlySpeechSynthesizerDelegate
//        //设置在线工作方式
//        tempObj.setParameter(IFlySpeechConstant.type_CLOUD(), forKey: IFlySpeechConstant.engine_TYPE())
//        //设置音量
//        tempObj.setParameter("100", forKey: IFlySpeechConstant.volume())
//        //设置发音人
//        tempObj.setParameter("xiaoqi", forKey: IFlySpeechConstant.voice_NAME())
//        //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
//        tempObj.setParameter("", forKey: IFlySpeechConstant.tts_AUDIO_PATH())
//        
//        
//        
//        return tempObj
//        
//    }()
    //发音
    var aVSpeechSynthesizer:AVSpeechSynthesizer!
    
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
       
        print(bestAttemptContent!.body)
         readContent(str: bestAttemptContent!.body)
      
//        if let aps = bestAttemptContent?.userInfo["ios"] as? NSDictionary{
//            if let extras = aps["extras"] as? NSDictionary{
//                if let voice = extras["voice"] as? String{
//                    
//                    if voice == "0"{
//                        
//                        
//                    }else{
//                        readContent(str: bestAttemptContent!.body)
//                      // readContent(str: "获得参数")
//                    }
//                }
//            }
//            
//        }
        //            //语音播放
        //            readContent(str: bestAttemptContent!.body)
        
//        let initString = "appid=59dc7d34"
//        IFlySpeechUtility.createUtility(initString)
//       readContent1(content: bestAttemptContent!.body)
        
    }
//    //MARK: - -------根据str阅读-----
//    func readContent1(content:String){
//        
//        //开始阅读
//        self.iFlySpeechSynthesizer.startSpeaking(content)
//        
//        
//    }
    
    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
        // self.stopRead()
        self.contentHandler!(self.bestAttemptContent!)
    }
    
    //MARK 系统语音播放
    func readContent(str:String){
        self.aVSpeechSynthesizer = AVSpeechSynthesizer.init()
        
        self.aVSpeechSynthesizer.delegate = self
        
        let aVSpeechUtterance = AVSpeechUtterance.init(string: str)
        
        aVSpeechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
        
        aVSpeechUtterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        
        self.aVSpeechSynthesizer.speak(aVSpeechUtterance)
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.contentHandler!(self.bestAttemptContent!)
    }
    
    
}

