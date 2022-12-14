//
//  AppDelegate.swift
//  Thorgroup
//
//  Created by apple on 2022/9/29.
//

import UIKit
import SnapKit
import Kingfisher
import KingfisherWebP
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        preLaunchThirdParty()
        VGFullscreenPopGesture.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarVC = VGBaseTabBarVC()
        window?.rootViewController = tabBarVC
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        preLaunchThirdParty()
        return true
    }
    
    
    // MARK: -  Life Cycle
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    
    // MARK: - Universal Links
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return true
    }
    
    
    /// 9.0以后使用新监听app的回跳API
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    
    
    // MARK: - Push Notification
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    
    //MARK: - Third Party
    public func preLaunchThirdParty() {
        // Kingfisher解码扩展
        let modifier = AnyModifier { request in
            var req = request
            req.addValue("image/gif */*", forHTTPHeaderField: "Accept")
            req.addValue("image/webp */*", forHTTPHeaderField: "Accept")
            return req
        }
        KingfisherManager.shared.defaultOptions += [
            .requestModifier(modifier),
            .processor(WebPProcessor.default),
            .cacheSerializer(WebPSerializer.default)
        ]
    }
    
    func deferLaunchThirdParty() {
        // 全局键盘控制
        IQKeyboardManager.shared.enable = true
    }
    
}

