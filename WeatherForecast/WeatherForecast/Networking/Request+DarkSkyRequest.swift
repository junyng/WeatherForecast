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
    var baseURLString: String { get }
    var path: String? { get }
    func buildURL() -> URL?
}

struct DarkSkyRequest: Request {
    private let APIKey = "693b24d34c1e7088cefd6076c3c10fd3"
    private let coordinate: (latitude: Double, longitude: Double)
    
    var baseURLString: String {
        return "https://api.darksky.net/"
    }
    
    var path: String? {
        return "forecast"
    }
    
    init(coordinate: (Double, Double)) {
        self.coordinate = coordinate
    }
}

extension DarkSkyRequest {
    /// URL을 만들어 반환
    func buildURL() -> URL? {
        var url = URL(string: baseURLString)
        if let path = path {
            url = url?.appendingPathComponent(path)
        }
        url = url?.appendingPathComponent(APIKey)
        url = url?.appendingPathComponent("\(coordinate.latitude),\(coordinate.longitude)")
        return url
    }
}
