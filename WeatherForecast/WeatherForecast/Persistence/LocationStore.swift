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
    private(set) var locations = [Location]()
    
    private let archiveURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("locations")
    }()
    
    init() {
        do {
            let data = try Data(contentsOf: archiveURL)
            if let archivedLocations = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Location] {
                locations = archivedLocations
            }
        } catch {
            print("파일을 읽지 못하였습니다.")
        }
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
    
    func saveChanges() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
            try data.write(to: archiveURL)
        } catch {
            print("파일을 저장하지 못하였습니다.")
        }
    }
    
    /// 위치 목록이 변경됨을 알림
    private func notifyReload() {
        NotificationCenter.default.post(name: .reloadLocations, object: nil)
    }
}
