//
//  AppDelegate.swift
//  SimpleZhihuDaily
//
//  Created by 雪 禹 on 7/23/16.
//  Copyright © 2016 XueYu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //Override point for customization after application launch.
        
        let homeCtrl = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let homeNav = UINavigationController(rootViewController: homeCtrl)
        
        homeNav.navigationBar.tintColor = UIColor.whiteColor()
        homeNav.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 176/255.0, blue: 232/255.0, alpha: 1.0)
        
        homeNav.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        self.window!.rootViewController = homeNav
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
}

