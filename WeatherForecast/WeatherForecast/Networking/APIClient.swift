//
//  APIClient.swift
//  WeatherForecast
//
//  Created by BLU on 06/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// API 요청하는 프로토콜 정의
protocol APIClient {
    var session: URLSession { get }
    
    // Review: let_var_whitespace
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, Error>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    /// URL 요청과 함께 JSON 데이터를 Decodable 모델로 디코딩한다.
    func decodingTask<T: Decodable>(with request: URLRequest, type: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            // Review: statusCode 200 ~ 300 범위가 성공입니다.
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(type, from: data)
                        
                        completion(genericModel, nil)
                    } catch {
                        /// JSON 디코딩 실패
                        completion(nil, .jsonConversionFailed)
                    }
                } else {
                    /// 유효하지 않은 데이터
                    completion(nil, .invalidData)
                }
            } else {
                /// HTTP Response 코드가 일치하지 않음
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    /// 디코딩 작업 후에 JSON 반환
    func fetch<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, Error>) -> Void) {
        // Review: unneeded_parentheses_in_closure_argument
        let task = decodingTask(with: request, type: T.self) { json, error in
            
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
