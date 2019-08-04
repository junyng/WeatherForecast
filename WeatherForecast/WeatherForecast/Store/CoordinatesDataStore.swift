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
    private(set) var coordinatesList = [Coordinates]()
    
    private init() {
        loadData()
    }
    
    func addCoordinates(_ coordinates: Coordinates) {
        if coordinatesList.contains(coordinates) {
            return
        }
        coordinatesList.append(coordinates)
    }
    
    func saveData() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: coordinatesList, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print(error)
        }
    }
    
    func loadData() {
        do {
            if let data = UserDefaults.standard.object(forKey: storeKey) as? Data {
                coordinatesList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Coordinates]
            }
        } catch {
            print(error)
        }
    }
}
