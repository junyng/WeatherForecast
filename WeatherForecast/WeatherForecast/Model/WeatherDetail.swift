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
