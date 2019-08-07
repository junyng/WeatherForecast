//
//  WeatherDaily.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

/// 일별 날씨 정보
struct WeatherDaily {
    let summary: String
    let icon: UIImage?
    let detailArray: [WeatherDetail]
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
