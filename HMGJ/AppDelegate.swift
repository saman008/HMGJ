//
//  AppDelegate.swift
//  HMGJ
//
//  Created by 冷轶 on 2017/7/17.
//  Copyright © 2017年 冷轶. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,BDSSpeechSynthesizerDelegate,JPUSHRegisterDelegate {
    
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        //广告启动页面
        LeaderStart()
        
        //极光推送
        //        jpushAction()
        jpushAction()
        
        if #available(iOS 11.0, *) {
            //UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
        } else {
            // Fallback on earlier versions
        }
        
        return true
    }
    
    
    //    App ID: 9994339
    //
    //    API Key: RCEDWBRUWEKLdpKKkk93RKDb
    //
    //    Secret Key: 9f9b5e913494de9c45e8accf16fc0f22
    func BDyuyin(str:String){
        // 设置apiKey和secretKey
        BDSSpeechSynthesizer.sharedInstance().setApiKey("RCEDWBRUWEKLdpKKkk93RKDb", withSecretKey: "9f9b5e913494de9c45e8accf16fc0f22")
        // 合成参数设置 可根据需求自行修改
        ///女声
        
        
        BDSSpeechSynthesizer.sharedInstance().setSynthParam(BDS_SYNTHESIZER_SPEAKER_FEMALE, for: BDS_SYNTHESIZER_PARAM_SPEAKER)
        ///音量 0 ~9
        
        BDSSpeechSynthesizer.sharedInstance().setSynthParam(9, for: BDS_SYNTHESIZER_PARAM_VOLUME)
        ///语速 0 ~9
        
        BDSSpeechSynthesizer.sharedInstance().setSynthParam(6, for: BDS_SYNTHESIZER_PARAM_SPEED)
        ///语调 0 ~9
        
        BDSSpeechSynthesizer.sharedInstance().setSynthParam(5, for: BDS_SYNTHESIZER_PARAM_PITCH)
        ///mp3音质  压缩的16K
        
        BDSSpeechSynthesizer.sharedInstance().setSynthParam(BDS_SYNTHESIZER_AUDIO_ENCODE_MP3_16K, for: BDS_SYNTHESIZER_PARAM_AUDIO_ENCODING)
        // 设置离线引擎 App ID: 9901658
        
        let offlineEngineSpeechData = Bundle.main.path(forResource: "Chinese_Speech_Female", ofType: "dat")
        
        let offlineEngineTextData = Bundle.main.path(forResource: "Chinese_Text", ofType: "dat")
        
        let offlineEngineLicenseFile = Bundle.main.path(forResource: "offline_engine_tmp_license", ofType: "dat")
        
        let offlineEngineEnglishSpeechDataa = Bundle.main.path(forResource: "English_Speech_Female", ofType: "dat")
        
        let offlineEngineEnglishTextData = Bundle.main.path(forResource: "English_Text", ofType: "dat")
        
        var err = BDSSpeechSynthesizer.sharedInstance().loadOfflineEngine(offlineEngineTextData, speechDataPath: offlineEngineSpeechData, licenseFilePath: offlineEngineLicenseFile, withAppCode: "9994339")
        
        
        if (err != nil){
            
            return
        }
        
        err = BDSSpeechSynthesizer.sharedInstance().loadEnglishData(forOfflineEngine: offlineEngineEnglishTextData, speechData: offlineEngineEnglishSpeechDataa)
        
        if (err != nil){
            
            return
        }
        // 获得合成器实例
        
        BDSSpeechSynthesizer.sharedInstance().setSynthesizerDelegate(self)
        // 设置委托对象
        BDSSpeechSynthesizer.sharedInstance().setSynthesizerDelegate(self)
        
        // 开始合成并播放
        
        var speakError:NSError? = nil
        
        if BDSSpeechSynthesizer.sharedInstance().speakSentence(str, withError: &speakError) == -1{
            
            
            print(speakError?.code)
            print(speakError?.localizedDescription)
        }
        
    }
    
    
    //MARK: ---------  启动jpush--------
    func jpushAction(){
        //MARK: -------JPUSH-------
        let entity = JPUSHRegisterEntity()
        
        entity.types = Int(UIUserNotificationType.alert.rawValue) | Int(UIUserNotificationType.badge.rawValue) | Int(UIUserNotificationType.sound.rawValue)
        
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
        JPUSHService.setup(withOption: nil, appKey: APPkey, channel: "App Store", apsForProduction: true)
        
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            print(resCode)
            if resCode == 0{
                registrationIDSTR = JPUSHService.registrationID()
                
                // registrationIDSTR = UserDefaults.standard
                
                print("====================")
                print(registrationIDSTR)
            }
            
        }
    }
    
    
    
    
    
    
//    //MARK: ---------启动jpush--------
//    func jpushAction(){
//        
//        
//        //通知类型（这里将声音、消息、提醒角标都给加上）
//        let userSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
//                                                      categories: nil)
//        if ((UIDevice.current.systemVersion as NSString).floatValue >= 8.0) {
//            //可以添加自定义categories
//            
//            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
//                                  categories: nil)
//        }
//        else {
//            //categories 必须为nil
//            JPUSHService.register(forRemoteNotificationTypes: userSettings.types.rawValue,
//                                  categories: nil)
//        }
//        
//        // 启动JPushSDK fae7fd212942ec1f2078f707 自己的极光49a47fea652682915834741a
//        JPUSHService.setup(withOption: nil, appKey: APPkey,
//                           channel: "App Store", apsForProduction: true)
//        
//        
//        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
//            print(resCode)
//            if resCode == 0{
//                registrationIDSTR = JPUSHService.registrationID()
//                
//                // registrationIDSTR = UserDefaults.standard
//                
//                print("====================")
//                print(registrationIDSTR)
//            }
//            
//        }
//        
//        //        let defaultCenter = NotificationCenter.default
//        //
//        //        defaultCenter.addObserver(self, selector: #selector(networkDid(nott:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
//        
//        UIApplication.shared.applicationIconBadgeNumber = 0
//    }
    
    //    func networkDid(nott:Notification){
    //
    //        var userInfo = nott.userInfo!
    //        //获取推送内容
    //        let content =  userInfo["content"] as! String
    //        //获取服务端传递的Extras附加字段，key是自己定义的
    //        //let extras =  userInfo["extras"]  as! NSDictionary
    //        //let value1 =  extras["key1"] as! String
    //
    //        //显示获取到的数据
    //        let alertController = UIAlertController(title: "收到自定义消息",
    //                                                message: content,
    //                                                preferredStyle: .alert)
    //        alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
    //        self.window?.rootViewController!.present(alertController, animated: true, completion: nil)
    //
    //    }
    
    //只要进入app 就会清楚图片小红点还有推送通知
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        application.applicationIconBadgeNumber = 0
        
        application.cancelAllLocalNotifications()
        
    }
    
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        return true
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //注册 DeviceToken
        JPUSHService.registerDeviceToken(deviceToken)
    }
    //    // iOS 10 Support
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
            if let aps = userInfo["ios"] as? NSDictionary{
                if let extras = aps["extras"] as? NSDictionary{
                    if let category = extras["category"] as? String{
                        
                        if category == "mail"{
                            CATEGORY = category
                        }
                    }
                }
                
                if let alert = aps["alert"] as? String{
                    
                    BDyuyin(str: alert)
                }
            }
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue) | Int(UNNotificationPresentationOptions.badge.rawValue) | Int(UNNotificationPresentationOptions.sound.rawValue))
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
            if let aps = userInfo["ios"] as? NSDictionary{
                if let extras = aps["extras"] as? NSDictionary{
                    if let category = extras["category"] as? String{
                        
                        if category == "mail"{
                            CATEGORY = category
                        }
                    }
                }
                
                if let alert = aps["alert"] as? String{
                    commonTool.start(text: alert, T: self)
                    BDyuyin(str: alert)
                }
            }
        }
        completionHandler()
        
    }
    
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler
        completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //增加IOS 7的支持
        JPUSHService.handleRemoteNotification(userInfo)
        print(userInfo)
        //        //获取通知消息和自定义参数数据
        //        let id = userInfo["id"] as! String
        //        let time = userInfo["time"] as! String
        if let aps = userInfo["ios"] as? NSDictionary{
            if let extras = aps["extras"] as? NSDictionary{
                if let category = extras["category"] as? String{
                    
                    if category == "mail"{
                        CATEGORY = category
                    }
                }
            }
            
            if let alert = aps["alert"] as? String{
                
                BDyuyin(str: alert)
            }
        }
        UIApplication.shared.applicationIconBadgeNumber = 0
        //        //显示获取到的数据
        //        let alertController = UIAlertController(title: alert,
        //                                                message: "新闻编号：\(id)\n发布时间：\(time)",
        //            preferredStyle: .alert)
        //        alertController.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        //        self.window?.rootViewController!.present(alertController, animated: true, completion: nil)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    //    // iOS 10 Support
    //    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center  willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    //    // Required
    //    NSDictionary * userInfo = notification.request.content.userInfo;
    //    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //    [JPUSHService handleRemoteNotification:userInfo];
    //    }
    //    else {
    //    // 本地通知
    //    }
    //    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    //    }
    //
    //    // iOS 10 Support
    //    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler: (void (^)())completionHandler {
    //    // Required
    //    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //    [JPUSHService handleRemoteNotification:userInfo];
    //    }
    //    else {
    //    // 本地通知
    //    }
    //    completionHandler();  // 系统要求执行这个方法
    //    }
    
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //可选
        NSLog("did Fail To Register For Remote Notifications With Error: \(error)")
    }
    
    
}
