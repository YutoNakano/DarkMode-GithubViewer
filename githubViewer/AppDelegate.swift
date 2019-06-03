//
//  AppDelegate.swift
//  githubViewer
//
//  Created by 中野湧仁 on 2019/05/11.
//  Copyright © 2019 Yuto Nakano. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let topViewController = TopViewController()
    let recommendViewController = RecommendViewController()
    let tabViewController = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let navi1 = UINavigationController(rootViewController: topViewController)
        navi1.tabBarItem.image = UIImage(named: "infomation")
        navi1.title = "検索"
        let navi2 = UINavigationController(rootViewController: recommendViewController)
        navi2.tabBarItem.image = UIImage(named: "others")
        navi2.title = "おすすめ"
        
        let controllers = [navi1,navi2]
        
        let presenter = SearchRepositoriesPresenter(view: topViewController)
        topViewController.inject(presenter: presenter)
        
        tabViewController.viewControllers = controllers
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabViewController
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey  : Any] = [:]) -> Bool {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

