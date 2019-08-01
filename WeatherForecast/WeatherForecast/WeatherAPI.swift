//
//  WeatherAPI.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherAPI {
    private static let baseURLString = "https://api.darksky.net/forecast"
    private static let APIKey = "693b24d34c1e7088cefd6076c3c10fd3"
    
    static func weatherURL(lat: Double, lon: Double) -> URL {
        var baseURL = URL(string: baseURLString)
        baseURL?.appendPathComponent(APIKey)
        baseURL?.appendPathComponent("\(lat),\(lon)")
        return baseURL!
    }
}
