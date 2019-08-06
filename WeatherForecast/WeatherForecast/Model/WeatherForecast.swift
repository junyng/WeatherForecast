//
//  Weather.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherForecast {
    let weatherCurrently: WeatherCurrently
    let weatherHourly: WeatherHourly
    let weatherDaily: WeatherDaily
    
    init(dto: WeatherForecastDTO) {
        self.weatherCurrently = WeatherCurrently(dto: dto.weatherCurrently)
        self.weatherHourly = WeatherHourly(dto: dto.weatherHourly)
        self.weatherDaily = WeatherDaily(dto: dto.weatherDaily)
    }
}

/// 전체 날씨 정보
struct WeatherForecastDTO: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case weatherCurrently = "currently"
        case weatherHourly = "hourly"
        case weatherDaily = "daily"
    }
    
    let weatherCurrently: WeatherCurrentlyDTO
    let weatherHourly: WeatherHourlyDTO
    let weatherDaily: WeatherDailyDTO
}
