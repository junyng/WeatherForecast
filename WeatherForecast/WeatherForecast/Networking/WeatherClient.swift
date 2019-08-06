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
    
    func getFeed(from coordinate: (Double, Double), completion: @escaping (Result<WeatherForecastDTO?, Error>) -> Void) {
        
        let endpoint = WeatherFeed(coordinate: coordinate)
        let request = endpoint.request
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        fetch(with: request, decode: { json -> WeatherForecastDTO? in
            dispatchGroup.leave()
            guard let weatherFeedResult = json as? WeatherForecastDTO else { return nil }
            
            return weatherFeedResult
        }, completion: completion)
    }
}
