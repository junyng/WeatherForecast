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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherHourlyCell", for: indexPath) as! HourlyCell
        let item = currentArray[indexPath.item]
        cell.timeLabel.text = DateUtil.currentTime(from: item.time)
        cell.weatherImage.image = item.icon
        cell.temperatureLabel.text = String(format: "%.1f", ConversionUtil.fahrenheitToCelsius(temperature: item.temperature))
        return cell
    }
}
