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
    let locationStore = LocationStore.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window!.rootViewController as! UINavigationController
        let locationTableViewController = navigationController.topViewController as! LocationTableViewController
        locationTableViewController.locationStore = locationStore
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        locationStore.saveLocations()
    }
}

