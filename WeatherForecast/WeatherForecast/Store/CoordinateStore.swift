//
//  CoordinateStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let reloadCoordinateList = Notification.Name("reloadCoordinateList")
}

final class CoordinateStore {
    static let sharedInstance = CoordinateStore()
    private let storeKey = "coordinate"
    private(set) var coordinateList = [Coordinate]()
    
    private init() {
        loadData()
    }
    
    func addCoordinate(_ coordinate: Coordinate) {
        if coordinateList.contains(coordinate) {
            return
        }
        coordinateList.append(coordinate)
        notifyReload()
    }
    
    func saveData() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: coordinateList, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print(error)
        }
    }
    
    func loadData() {
        do {
            if let data = UserDefaults.standard.object(forKey: storeKey) as? Data {
                coordinateList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Coordinate]
            }
        } catch {
            print(error)
        }
    }
    
    /// 좌표 목록이 변경됨을 알림
    private func notifyReload() {
        NotificationCenter.default.post(name: .reloadCoordinateList, object: nil)
    }
}
