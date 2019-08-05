//
//  Coordinate.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class Coordinate: NSObject, NSCoding {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    override var description: String {
        return "\(latitude),\(longitude)"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: "lat")
        aCoder.encode(longitude, forKey: "lng")
    }
    
    required init?(coder aDecoder: NSCoder) {
        latitude = aDecoder.decodeDouble(forKey: "lat")
        longitude = aDecoder.decodeDouble(forKey: "lng")
    }
}

extension Coordinate {
    // 위도 경도가 같으면 두 좌표는 같다.
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
    }
}
