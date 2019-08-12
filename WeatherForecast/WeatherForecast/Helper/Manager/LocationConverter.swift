//
//  LocationConverter.swift
//  WeatherForecast
//
//  Created by BLU on 12/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation
import CoreLocation

class LocationConverter {
    
    static let shared = LocationConverter()
    private init() { }
    
    /// 주소 문자열을 기준으로 좌표 정보를 반환한다.
    func getLocationInfo(from addressString: String,
                       completionHandler: @escaping(CLLocationCoordinate2D?, TimeZone?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            completionHandler(placemarks?.first?.location?.coordinate, placemarks?.first?.timeZone, error)
        }
    }
}
