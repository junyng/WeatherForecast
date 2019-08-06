//
//  WeatherDetail.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDetail {
    let time: Date
    let summary: String
    let icon: UIImage?
    let sunriseTime: Date
    let sunsetTime: Date
    let humidity: Double
    let windSpeed: Double
    let visibility: Double
    let precipProbability: Double
    let temperatureHigh: Double
    let temperatureLow: Double
    
    init(dto: WeatherDetailDTO) {
        self.time = Date(timeIntervalSince1970: Double(dto.time ?? 0))
        self.summary = dto.summary ?? "-"
        self.icon = UIImage(named: dto.icon?.rawValue ?? "")
        self.sunriseTime = Date(timeIntervalSince1970: Double(dto.sunriseTime ?? 0))
        self.sunsetTime = Date(timeIntervalSince1970: Double(dto.sunsetTime ?? 0))
        self.humidity = dto.humidity ?? 0.0
        self.windSpeed = dto.windSpeed ?? 0.0
        self.visibility = dto.visibility ?? 0.0
        self.precipProbability = dto.precipProbability ?? 0.0
        self.temperatureHigh = dto.temperatureHigh ?? 0.0
        self.temperatureLow = dto.temperatureLow ?? 0.0
    }
}

struct WeatherDetailDTO: Decodable {
    let time: Int?
    let summary: String?
    let icon: Icon?
    let sunriseTime: Int?
    let sunsetTime: Int?
    let humidity: Double?
    let windSpeed: Double?
    let visibility: Double?
    let precipProbability: Double?
    let temperatureHigh: Double?
    let temperatureLow: Double?
}
