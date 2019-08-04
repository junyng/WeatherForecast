//
//  Weather.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 전체 날씨 정보
struct WeatherForecast: Codable {
    
    private enum CodingKeys : String, CodingKey {
        case currentWeather = "currently"
        case weatherHourly = "hourly"
        case weatherDaily = "daily"
    }
    
    let currentWeather: WeatherCurrently
    let weatherHourly: WeatherHourly
    let weatherDaily: WeatherDaily
}

extension WeatherForecast {
    static func fetch (
        coordinates: Coordinates,
        dispatcher: NetworkDispatcher = NetworkDispatcher.sharedInstance,
        completion: @escaping (Result<WeatherForecast, Error>) -> Void
        ) {
        let darkSkyRequest = DarkSkyRequest(coordinates: coordinates)
        dispatcher.dispatch(request: darkSkyRequest) { (result) in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(WeatherForecast.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
