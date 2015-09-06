//
//  AppDelegate.swift
//  HDY
//
//  Created by haha on 15/9/3.
//  Copyright (c) 2015年 edonesoft. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    var navController:UINavigationController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
    if (AppConfig.sharedAppConfig.IsTest)
        //if (true)
        {
            AppConfig.SERVICE_ROOT_PATH = "http://192.168.1.26:47897/"
        }else
        {
             AppConfig.SERVICE_ROOT_PATH = "http://newhuodongyou.chinacloudsites.cn/"
        }
        
        
        
        if(AppConfig.sharedAppConfig.isUserLogin())
        {
            //顺利登陆
            
        }else
        {
            //开始去注册
            var vc = UIHelper.GetVCWithIDFromStoryBoard(.Account, viewControllerIdentity: "loginNavigation")
            
            self.window?.rootViewController = vc
            
            
        }
        

        
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

