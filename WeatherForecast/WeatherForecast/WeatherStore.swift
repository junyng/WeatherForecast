//
//  WeatherStore.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class WeatherStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchCurrentWeather(lat: Double, lng: Double, completion: @escaping (Weather) -> Void) {
        let url = WeatherAPI.weatherURL().appendingPathComponent("\(lat),\(lng)")
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let data = data else {
                return
            }
            
            do {
                let jsonData = try JSONDecoder().decode(Weather.self, from: data)
                completion(jsonData)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
