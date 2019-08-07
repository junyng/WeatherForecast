//
//  main.swift
//  WeatherForecast
//
//  Created by tskim on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

private func appDelegateClassName() -> String {
    let isTesting = NSClassFromString("XCTestCase") != nil
    return isTesting ? "WeatherForecastTests.TestAppDelegate" : NSStringFromClass(AppDelegate.self)
}

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(UIApplication.self),
    appDelegateClassName()
)
