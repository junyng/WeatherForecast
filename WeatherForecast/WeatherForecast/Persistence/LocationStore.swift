//
//  LocationStore.swift
//  WeatherForecast
//
//  Created by BLU on 04/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 노티피케이션 정의
extension Notification.Name {
    /// 위치 정보 데이터 추가시 POST
    static let locationsAdded = Notification.Name("locationsAdded")
}

/// 위치 정보 데이터 저장소
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
        /// 위도/경도가 같을시 리턴
//        guard !locations.contains(location) else {
//            return
//        }
        locations.append(location)
        locationsAdded()
    }
    
    func removeLocation(_ location: Location) {
        if let index = locations.firstIndex(of: location) {
            locations.remove(at: index)
        }
    }
    
    /// 파일 URL에 데이터를 아카이빙해 저장
    func saveChanges() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: locations, requiringSecureCoding: false)
            try data.write(to: archiveURL)
        } catch {
            print("파일을 저장하지 못하였습니다.")
        }
    }
    
    /// 위치 목록이 추가됨을 알림
    private func locationsAdded() {
        NotificationCenter.default.post(name: .locationsAdded, object: nil)
    }
}
