//
//  LocationCell.swift
//  WeatherForecast
//
//  Created by BLU on 03/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell, ConfigurableCell, ReusableCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    private var timezone: TimeZone?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateTime()
    }
    
    func configure(_ item: LocationInfo) {
        timezone = item.location.timezone
        locationLabel.text = item.location.address
        updateTime()
        if let weather = item.weather {
            temperatureLabel.text = String(format: "%.1f°", weather.temperature.fahrenheitToCelsius())
        }
    }
    
    private func updateTime() {
        timeLabel.text = DateUtil.currentTime(from: Date(), timezone: timezone)
    }
}
