//
//  NetworkingService.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct WeatherService {
    
    static func fetchWeather<ResponseType: Codable>(
        point: Point,
        response: ResponseType.Type,
        dispatcher: NetworkDispatcher = NetworkDispatcher.instance,
        onSuccess: @escaping (ResponseType) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        let darkSkyRequest = DarkSkyRequest(point: point)
        dispatcher.dispatch(
            request: darkSkyRequest,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
        },
            onError: { (error: Error) in
                DispatchQueue.main.async {
                    onError(error)
                }
        })
    }
}
