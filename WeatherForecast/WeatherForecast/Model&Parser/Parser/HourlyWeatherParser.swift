//
//  HourlyWeatherParser.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct HourlyWeatherParser {
    static func parse(dto: WeatherHourlyDTO) -> WeatherHourly {
        return WeatherHourly(
            summary: dto.summary ?? "-",
            icon: UIImage(named: dto.icon?.rawValue ?? ""),
            currentArray: dto.currentArray?.compactMap { CurrentlyWeatherParser.parse(dto: $0) }.filter { $0.time >= Date() } ?? []
        )
    }
}
