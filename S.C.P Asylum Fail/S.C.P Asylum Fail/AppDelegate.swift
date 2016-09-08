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


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: Bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        getNotificationSettings()
        return true
    }
    
    func getNotificationSettings() {
        let settings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert,UIUserNotificationType.Badge,UIUserNotificationType.Sound] , categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        getHomeVCAndDo()
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
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
