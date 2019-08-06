//
//  WeatherClient.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class WeatherClient: APIClient {
    static let shared = WeatherClient()
    private init() { }
    let session = URLSession(configuration: .default)
    
    func getFeed(from coordinate: (Double, Double), completion: @escaping (Result<WeatherForecast?, Error>) -> Void) {
        
        let endpoint = WeatherFeed(coordinate: coordinate)
        let request = endpoint.request
        
        fetch(with: request, decode: { json -> WeatherForecast? in
            guard let weatherFeedResult = json as? WeatherForecast else { return nil }
            return weatherFeedResult
        }, completion: completion)
    }
}
