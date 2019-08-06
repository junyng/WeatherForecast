//
//  WeatherDaily.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct WeatherDaily {
    let summary: String
    let icon: UIImage?
    let detailArray: [WeatherDetail]
    
    init(dto: WeatherDailyDTO) {
        self.summary = dto.summary ?? "-"
        self.icon = UIImage(named: dto.icon?.rawValue ?? "")
        self.detailArray = dto.detailArray?.compactMap { WeatherDetail(dto: $0) } ?? []
    }
}

struct WeatherDailyDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case detailArray = "data"
    }
    
    let summary: String?
    let icon: Icon?
    let detailArray: [WeatherDetailDTO]?
}
