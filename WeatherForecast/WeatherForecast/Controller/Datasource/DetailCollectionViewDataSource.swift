//
//  DetailCollectionViewDataSource.swift
//  WeatherForecast
//
//  Created by BLU on 05/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class DetailCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var detailArray = [WeatherDetail]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dailyCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDailyCell", for: indexPath) as! DailyCell
        let summaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath) as! SummaryCell
        let dailyDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyDetailCell", for: indexPath) as! DailyDetailCell
        if indexPath.item < detailArray.count {
            let item = detailArray[indexPath.item]
            dailyCell.weatherImageView.image = item.icon
            dailyCell.dayLabel.text = DateUtil.weekDay(from: item.time) ?? ""
            dailyCell.temperatureHighLabel.text = String(format: "%.1f°", ConversionUtil.fahrenheitToCelsius(temperature: item.feature.temperatureHigh))
            dailyCell.temperatureLowLabel.text = String(format: "%.1f°", ConversionUtil.fahrenheitToCelsius(temperature: item.feature.temperatureLow))
            return dailyCell
        } else {
            
            return summaryCell
        }
    }
}

