//
//  Weather.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 전체 날씨 정보
struct WeatherForecast: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case weatherCurrently = "currently"
        case weatherHourly = "hourly"
        case weatherDaily = "daily"
    }
    
    let weatherCurrently: WeatherCurrently
    let weatherHourly: WeatherHourly
    let weatherDaily: WeatherDaily
}
