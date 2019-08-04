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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coordinateStore = CoordinateStore.sharedInstance
        let navigationController = window!.rootViewController as! UINavigationController
        let locationTableViewController = navigationController.topViewController as! LocationTableViewController
        locationTableViewController.coordinateStore = coordinateStore
        return true
    }
}

