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
        point: Point,
        dispatcher: NetworkDispatcher = NetworkDispatcher.instance,
        onSuccess: @escaping (Weather) -> Void,
        onError: @escaping (Error) -> Void
        ) {
        let darkSkyRequest = DarkSkyRequest(point: point)
        dispatcher.dispatch(
            request: darkSkyRequest,
            onSuccess: { (responseData: Data) in
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(Weather.self, from: responseData)
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
        }
        )
    }
}
