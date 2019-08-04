//
//  CoordinatesDataStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

final class CoordinatesDataStore {
    static let sharedInstance = CoordinatesDataStore()
    private let storeKey = "coordinates"
    private var coordinatesList = [Coordinates]()
    
    private init() {}
    
    func addCoordinates(_ coordinates: Coordinates) {
        coordinatesList.append(coordinates)
    }
}
