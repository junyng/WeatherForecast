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
    private(set) var locations = [Location]()
    
    private init() {
        loadData()
    }
    
    func addCoordinate(_ coordinate: Location) {
        if locations.contains(coordinate) {
            return
        }
        locations.append(coordinate)
        notifyReload()
    }
    
    func removeCoordinate(_ coordinate: Location) {
        if let index = locations.firstIndex(of: coordinate) {
            locations.remove(at: index)
        }
    }
    
    func saveData() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print(error)
        }
    }
    
    func loadData() {
        do {
            if let data = UserDefaults.standard.object(forKey: storeKey) as? Data {
                locations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Location]
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
