//
//  SwiftNameIdentifier.swift
//  WeatherForecast
//
//  Created by BLU on 10/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol SwiftNameIdentifier {
    static var swiftIdentifier: String { get }
}

extension SwiftNameIdentifier {
    static var swiftIdentifier: String {
        return String(describing: Self.self)
    }
}
