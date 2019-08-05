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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDailyCell", for: indexPath) as! DailyCell
        let item = detailArray[indexPath.item]
        cell.dayLabel.text = "월요일"
        cell.weatherImageView.image = UIImage(named: item.icon.rawValue)
        cell.temperatureHighLabel.text = "\(item.temperatureHigh)"
        cell.temperatureLowLabel.text = "\(item.temperatureLow)"
        return cell
    }
}

