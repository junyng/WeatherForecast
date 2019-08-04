//
//  CoordinatesDataStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let reloadCoordinatesList = Notification.Name("reloadCoordinatesList")
}

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
        notifyReload()
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
    
    /// 좌표 목록이 변경됨을 알림
    private func notifyReload() {
        NotificationCenter.default.post(name: .reloadCoordinatesList, object: nil)
    }
}
