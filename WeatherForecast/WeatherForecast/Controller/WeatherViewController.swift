//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by BLU on 01/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var coordinates: Coordinates!
    fileprivate let days = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UICollectionViewDataSource
extension WeatherViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daily", for: indexPath) as! DailyCell
        return cell
    }
}
