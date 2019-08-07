//
//  CurrentlyWeatherParser.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct CurrentlyWeatherParser {
    static func parse(dto: WeatherCurrentlyDTO) -> WeatherCurrently {
        return WeatherCurrently(
            time: Date(timeIntervalSince1970: Double(dto.time ?? 0)),
            summary: dto.summary ?? "-",
            icon: UIImage(named: dto.icon?.rawValue ?? ""),
            temperature: dto.temperature ?? 0.0
        )
    }
}
