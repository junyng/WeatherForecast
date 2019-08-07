//
//  Currently.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

/// 현재 시간의 날씨 정보
struct WeatherCurrently {
    let time: Date
    let summary: String
    let icon: UIImage?
    let temperature: Double
}

struct WeatherCurrentlyDTO: Decodable {
    let time: Int?
    let summary: String?
    let icon: Icon?
    let temperature: Double?
}

enum Icon: String, Decodable {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
}
