//
//  DetailWeatherParser.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct DetailWeatherParser {
    static func parse(dto: WeatherDetailDTO) -> WeatherDetail {
        return WeatherDetail(
            time: Date(timeIntervalSince1970: Double(dto.time ?? 0)),
            summary: dto.summary ?? "-",
            icon: UIImage(named: dto.icon?.rawValue ?? ""),
            sunriseTime: Date(timeIntervalSince1970: Double(dto.sunriseTime ?? 0)),
            sunsetTime: Date(timeIntervalSince1970: Double(dto.sunsetTime ?? 0)),
            humidity: dto.humidity ?? 0.0,
            windSpeed: dto.windSpeed ?? 0.0,
            visibility: dto.visibility ?? 0.0,
            precipProbability: dto.precipProbability ?? 0.0,
            temperatureHigh: dto.temperatureHigh ?? 0.0,
            temperatureLow: dto.temperatureLow ?? 0.0
        )
    }
}
