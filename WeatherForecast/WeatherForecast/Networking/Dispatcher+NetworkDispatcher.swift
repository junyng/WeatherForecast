//
//  Dispatcher+NetworkDispatcher.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol Dispatcher {
    func dispatch(request: Request, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

struct NetworkDispatcher: Dispatcher {
    public static let instance = NetworkDispatcher()
    private init() {}
    
    func dispatch(request: Request,
                  onSuccess: @escaping (Data) -> Void,
                  onError: @escaping (Error) -> Void) {
        
        guard let url = request.buildURL() else {
            onError(DarkSkyError.invalidURL)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            if let error = error {
                onError(error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            onSuccess(data)
            }.resume()
    }
}

enum DarkSkyError: Error {
    case invalidURL
}
