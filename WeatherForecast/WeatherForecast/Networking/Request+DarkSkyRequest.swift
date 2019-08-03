//
//  Request.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 네트워크 요청을 정의하는 프로토콜
protocol Request {
    var baseURL: URL { get }
    var path: String? { get }
}

struct DarkSkyRequest: Request {
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net/")!
    }
    
    var path: String? {
        return "forecast"
    }
}
