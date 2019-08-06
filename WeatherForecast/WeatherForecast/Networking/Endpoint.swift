//
//  Endpoint.swift
//  WeatherForecast
//
//  Created by BLU on 06/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 네트워크 요청을 정의하는 프로토콜
protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [URLQueryItem(name: "lang", value: "ko")]
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
