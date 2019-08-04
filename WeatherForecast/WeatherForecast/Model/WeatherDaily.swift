//
//  WeatherDaily.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherDaily: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case detailArray = "data"
    }
    
    let summary: String
    let icon: Icon
    let detailArray: [WeatherDetail]
}
