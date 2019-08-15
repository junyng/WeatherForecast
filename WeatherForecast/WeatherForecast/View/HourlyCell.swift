//
//  HourlyCell.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class HourlyCell: UICollectionViewCell, ConfigurableCell, ReusableCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(_ item: WeatherCurrently) {
        timeLabel.text = DateUtil.currentTime(from: item.time)
        weatherImage.image = item.icon
        temperatureLabel.text = String(format: "%.1f°", item.temperature.fahrenheitToCelsius())
    }
}
