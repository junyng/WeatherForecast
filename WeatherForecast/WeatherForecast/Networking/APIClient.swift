//
//  APIClient.swift
//  WeatherForecast
//
//  Created by BLU on 06/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, Error>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, type: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(type, from: data)
                        
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailed)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, Error>) -> Void) {
        
        let task = decodingTask(with: request, type: T.self) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                }
            }
        }
        task.resume()
    }
}
