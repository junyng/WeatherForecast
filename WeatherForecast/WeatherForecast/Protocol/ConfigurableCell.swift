//
//  ConfigurableCell.swift
//  WeatherForecast
//
//  Created by BLU on 15/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype T
    
    func configure(_ item: T)
}
