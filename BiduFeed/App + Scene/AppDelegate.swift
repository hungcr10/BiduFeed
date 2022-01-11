//
//  AppDelegate.swift
//  BiduFeed
//
//  Created by CristianoDaoHung on 09/01/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBar()
        window?.makeKeyAndVisible()
        return true
    }


}

