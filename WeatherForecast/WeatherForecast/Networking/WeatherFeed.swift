//
//  WeatherFeed.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherFeed: Endpoint {
    private let coordinate: (latitude: Double, longitude: Double)
    
    var base: String {
        return "https://api.darksky.net"
    }
    
    var path: String {
        return "/forecast/693b24d34c1e7088cefd6076c3c10fd3/\(coordinate.latitude),\(coordinate.longitude)"
    }
    
    init(coordinate: (Double, Double)) {
        self.coordinate = coordinate
    }
}
