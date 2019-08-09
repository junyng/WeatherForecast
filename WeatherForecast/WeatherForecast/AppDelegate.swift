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
    private let locationStore = LocationStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Review: force_cast
        // swiftlint:disable force_cast
        let navigationController = window!.rootViewController as! UINavigationController
        // Review: force_cast force_cast
        let locationTableViewController = navigationController.topViewController as! LocationTableViewController
        locationTableViewController.locationStore = locationStore
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        locationStore.saveChanges()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        locationStore.saveChanges()
    }
}
