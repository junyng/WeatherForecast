//
//  Coordinates.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class Coordinates: NSObject, NSCoding {
    let latitude: Double
    let longitude: Double
    
    init(lat: Double, lng: Double) {
        self.latitude = lat
        self.longitude = lng
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
