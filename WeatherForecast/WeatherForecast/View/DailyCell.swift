//
//  DailyCell.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class DailyCell: UICollectionViewCell, ConfigurableCell, ReusableCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    
    func configure(_ item: WeatherDetail) {
        weatherImageView.image = item.icon
        dayLabel.text = DateUtil.currentDay(from: item.time) ?? ""
        temperatureHighLabel.text = String(format: "%.1f°", item.feature.temperatureHigh.fahrenheitToCelsius())
        temperatureLowLabel.text = String(format: "%.1f°", item.feature.temperatureLow.fahrenheitToCelsius())
    }
}
