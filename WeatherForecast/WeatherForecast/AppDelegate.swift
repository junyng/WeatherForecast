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
        let coordinatesDataStore = CoordinatesDataStore.sharedInstance
        let navigationController = window!.rootViewController as! UINavigationController
        let citiesViewController = navigationController.topViewController as! CitiesViewController
        citiesViewController.coordinatesDataStore = coordinatesDataStore
        return true
    }
}

