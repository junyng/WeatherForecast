//
//  WeatherHourly.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherHourly: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case currentArray = "data"
    }
    
    let summary: String
    let icon: Icon
    let currentArray: [CurrentWeather]
}
