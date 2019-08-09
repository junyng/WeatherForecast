//
//  WeatherClient.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

// Review: 이름이 없는 튜플은 가독성이 떨어집니다.
typealias Coordinate = (Double, Double)

class WeatherClient: APIClient {
    static let shared = WeatherClient()

    // Review: let_var_whitespace
    private init() { }
    let session = URLSession(configuration: .default)
    
    func getFeed(from coordinate: Coordinate, completion: @escaping (Result<WeatherForecastDTO?, Error>) -> Void) {
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
