//
//  Dispatcher+NetworkDispatcher.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol Dispatcher {
    func dispatch(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

struct NetworkDispatcher: Dispatcher {
    static let sharedInstance = NetworkDispatcher()
    private init() {}
    
    func dispatch(request: Request,
                    completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = request.buildURL() else {
            completion(.failure(DarkSkyError.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        session.dataTask(with: urlRequest) {
            (data, response, error) -> Void in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            completion(.success(data))
            }.resume()
    }
}

enum DarkSkyError: Error {
    case invalidURL
}
