//
//  DarkSkyRequest.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct DarkSkyRequest: Request {
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net/")!
    }
    
    var path: String? {
        return "forecast"
    }
}

