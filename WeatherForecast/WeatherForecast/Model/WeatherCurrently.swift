//
//  Currently.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct WeatherCurrently {
    let time: Date
    let summary: String
    let icon: UIImage?
    let temperature: Double
    
    init(dto: WeatherCurrentlyDTO) {
        self.time = Date(timeIntervalSince1970: Double(dto.time ?? 0))
        self.summary = dto.summary ?? "-"
        self.icon = UIImage(named: dto.icon?.rawValue ?? "")
        self.temperature = dto.temperature ?? 0.0
    }
}


/// 현재 시간의 날씨 정보
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
