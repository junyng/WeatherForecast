//
//  Weather.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 전체 날씨 정보
struct Weather: Codable {
    let currently: Currently
}

extension Weather {
    static func fetch (
        coordinates: Coordinates,
        dispatcher: NetworkDispatcher = NetworkDispatcher.instance,
        completion: @escaping (Result<Weather, Error>) -> Void
        ) {
        let darkSkyRequest = DarkSkyRequest(coordinates: coordinates)
        dispatcher.dispatch(request: darkSkyRequest) { (result) in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(Weather.self, from: data)
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
