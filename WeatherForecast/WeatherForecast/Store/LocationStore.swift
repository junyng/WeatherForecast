//
//  LocationStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let reloadLocations = Notification.Name("reloadLocations")
}

final class LocationStore {
    static let shared = LocationStore()
    private let storeKey = "location"
    private(set) var locations = [Location]()
    
    private init() {
        loadLocations()
    }
    
    func addLocation(_ location: Location) {
        if locations.contains(location) {
            return
        }
        locations.append(location)
        notifyReload()
    }
    
    func removeLocation(_ location: Location) {
        if let index = locations.firstIndex(of: location) {
            locations.remove(at: index)
        }
    }
    
    func saveLocations() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
            UserDefaults.standard.set(data, forKey: storeKey)
        } catch {
            print(error)
        }
    }
    
    func loadLocations() {
        do {
            if let data = UserDefaults.standard.object(forKey: storeKey) as? Data {
                locations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! [Location]
            }
        } catch {
            print(error)
        }
    }
    
    /// 위치 목록이 변경됨을 알림
    private func notifyReload() {
        NotificationCenter.default.post(name: .reloadLocations, object: nil)
    }
}
