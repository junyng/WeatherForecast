//
//  Point.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct Point: CustomStringConvertible {
    let latitude: Double
    let longitude: Double
    
    var description: String {
        return "\(latitude),\(longitude)"
    }
}
