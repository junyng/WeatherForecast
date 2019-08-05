//
//  Location.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 위치 정보를 갖는 커스텀 클래스
class Location: NSObject, NSCoding {
    let latitude: Double
    let longitude: Double
    let address: String
    
    init(latitude: Double, longitude: Double, address: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(address, forKey: "address")
    }
    
    required init?(coder aDecoder: NSCoder) {
        latitude = aDecoder.decodeDouble(forKey: "latitude")
        longitude = aDecoder.decodeDouble(forKey: "longitude")
        address = aDecoder.decodeObject(forKey: "address") as! String
    }
    
    func coordinate() -> (Double, Double) {
        return (latitude, longitude)
    }
}

extension Location {
    // 두 개의 좌표의 위도 경도가 같으면 위치는 같다.
    static func == (lhs: Location, rhs: Location) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
