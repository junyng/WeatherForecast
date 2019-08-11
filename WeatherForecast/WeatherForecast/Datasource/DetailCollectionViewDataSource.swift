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
    var feature: Feature? {
        return detailArray.first?.feature
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dailyCell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.swiftIdentifier, for: indexPath) as? DailyCell,
            let summaryCell = collectionView.dequeueReusableCell(withReuseIdentifier: SummaryCell.swiftIdentifier, for: indexPath) as? SummaryCell else { return UICollectionViewCell() }
        if indexPath.item < detailArray.count {
            let weatherDetail = detailArray[indexPath.item]
            dailyCell.weatherImageView.image = weatherDetail.icon
            dailyCell.dayLabel.text = DateUtil.weekDay(from: weatherDetail.time) ?? ""
            dailyCell.temperatureHighLabel.text = String(format: "%.1f°", weatherDetail.feature.temperatureHigh.fahrenheitToCelsius())
            dailyCell.temperatureLowLabel.text = String(format: "%.1f°", weatherDetail.feature.temperatureLow.fahrenheitToCelsius())
            return dailyCell
        } else if indexPath.item == detailArray.count {
            if let feature = feature {
                summaryCell.summaryTextView.text = feature.summary
            }
            return summaryCell
        }
        return UICollectionViewCell()
    }
}
