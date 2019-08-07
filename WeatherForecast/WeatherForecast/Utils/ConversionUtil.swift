//
//  ConversionUtil.swift
//  WeatherForecast
//
//  Created by BLU on 07/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

/// 단위 변환 편의 유틸
struct ConversionUtil {
    /// 화씨 -> 섭씨 변환
    static func fahrenheitToCelsius(temperature: Double) -> Double {
        let celsius = (temperature - 32.0) * (5 / 9)
        return celsius
    }
}
