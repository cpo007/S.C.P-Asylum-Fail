//
//  AppDelegate.swift
//  S.C.P Asylum Fail
//
//  Created by cpo007@qq.com on 16/6/21.
//  Copyright © 2016年 eggplant. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: Bounds)
        
        window?.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        getNotificationSettings()
        return true
    }

    
    func getNotificationSettings() {
        let settings = UIUserNotificationSettings(types: [UIUserNotificationType.alert,UIUserNotificationType.badge,UIUserNotificationType.sound] , categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        getHomeVCAndDo()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    
    //获取HomeVC并且激活比较时间
    func getHomeVCAndDo() {
        guard let nav = window?.rootViewController as? BaseNavigationController else{ return }
        guard let homevc = nav.topViewController as? HomeViewController else{ return }
        homevc.compareNotificationTime()
    }
}
