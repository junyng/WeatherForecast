//
//  DailyWeatherParser.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct DailyWeatherParser {
    static func parse(dto: WeatherDailyDTO) -> WeatherDaily {
        return WeatherDaily(
            summary: dto.summary ?? "-",
            icon: UIImage(named: dto.icon?.rawValue ?? ""),
            detailArray: dto.detailArray?.compactMap { DetailWeatherParser.parse(dto: $0) } ?? []
        )
    }
}
