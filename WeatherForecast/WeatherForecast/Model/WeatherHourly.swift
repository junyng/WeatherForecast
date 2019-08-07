//
//  WeatherHourly.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import UIKit

struct WeatherHourly {
    let summary: String
    let icon: UIImage?
    let currentArray: [WeatherCurrently]
}


struct WeatherHourlyDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case currentArray = "data"
    }
    
    let summary: String?
    let icon: Icon?
    let currentArray: [WeatherCurrentlyDTO]?
}
