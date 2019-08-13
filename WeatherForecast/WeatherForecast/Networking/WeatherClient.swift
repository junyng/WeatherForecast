//
//  WeatherClient.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

typealias Coordinate = (latitude: Double, longitude: Double)

class WeatherClient: APIClient {
    static let shared = WeatherClient()

    private init() { }
    let session = URLSession(configuration: .default)
    
    func getFeed(from coordinate: Coordinate, completion: @escaping (Result<WeatherForecastDTO?, Error>) -> Void) {
        let endpoint = WeatherFeed(coordinate: coordinate)
        guard let request = endpoint.request else { return }
        
        fetch(with: request, decode: { json -> WeatherForecastDTO? in
            guard let weatherFeedResult = json as? WeatherForecastDTO else { return nil }
            return weatherFeedResult
        }, completion: completion)
    }
}
