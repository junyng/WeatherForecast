//
//  SwiftNameIdentifier.swift
//  WeatherForecast
//
//  Created by BLU on 10/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
