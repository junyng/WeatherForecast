//
//  Double+Conversions.swift
//  WeatherForecast
//
//  Created by BLU on 10/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

extension Double {
    /// 화씨 -> 섭씨 온도 변환
    func celsiusToFahrenheit() -> Double {
        return self * 9 / 5 + 32
    }
    /// 온도 화씨 -> 섭씨 온도 변환
    func fahrenheitToCelsius() -> Double {
        return (self - 32) * 5 / 9
    }
}
