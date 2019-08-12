//
//  Location.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 위치 정보를 갖는 커스텀 클래스
class Location: Codable {
    let latitude: Double
    let longitude: Double
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case address
    }
    
    init(latitude: Double, longitude: Double, address: String? = nil) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(address, forKey: .address)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
        address = try container.decode(String.self, forKey: .address)
    }
    
    func coordinate() -> Coordinate {
        return (latitude, longitude)
    }
    
    func addressString() -> String? {
        return address
    }
}

extension Location: Equatable {
    // 두 개의 좌표의 위도 경도가 같으면 위치는 같다.
    static func == (lhs: Location, rhs: Location) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
