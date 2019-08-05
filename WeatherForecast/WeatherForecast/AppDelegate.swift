//
//  AppDelegate.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let coordinateStore = CoordinateStore.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window!.rootViewController as! UINavigationController
        let locationTableViewController = navigationController.topViewController as! LocationTableViewController
        locationTableViewController.coordinateStore = coordinateStore
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coordinateStore.saveData()
    }
}

