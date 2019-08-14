//
//  HourlyCollectionViewDataSource.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class HourlyCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var currentArray = [WeatherCurrently]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath)
        if let hourlyCell = cell as? HourlyCell {
            let weatherCurrently = currentArray[indexPath.item]
            hourlyCell.timeLabel.text = DateUtil.currentTime(from: weatherCurrently.time)
            hourlyCell.weatherImage.image = weatherCurrently.icon
            hourlyCell.temperatureLabel.text = String(format: "%.1f°", weatherCurrently.temperature.fahrenheitToCelsius())
        }
        return cell
    }
}
