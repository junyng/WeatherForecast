//
//  ConversionUtil.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

struct ConversionUtil {
    static func fahrenheitToCelsius(temperature: Double) -> Double {
        let celsius = (temperature - 32.0) * (5 / 9)
        return celsius
    }
    
    static func celsiusToFahrenheit(temperature: Double) -> Double {
        let fahrenheit = (temperature * 9 / 5) + 32.0
        return fahrenheit
    }
}
