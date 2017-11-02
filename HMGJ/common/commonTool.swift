//
//  commonTool.swift
//  FunLife
//
//  Created by Forever on 2017/6/27.
//  Copyright © 2017年 Forever. All rights reserved.
//

import UIKit
import AVFoundation

class commonTool:NSObject,AVSpeechSynthesizerDelegate {

    
    //语音播放
    static func start(text:String,T:AnyObject){
        var av:AVSpeechSynthesizer?
        av = AVSpeechSynthesizer()
        
        av?.delegate = T as? AVSpeechSynthesizerDelegate
        
        let uttranse = AVSpeechUtterance.init(string: text)
        
        uttranse.rate = 0.5
        
        let voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        
        uttranse.voice = voice
        
        av?.speak(uttranse)
        
    }
    
}
