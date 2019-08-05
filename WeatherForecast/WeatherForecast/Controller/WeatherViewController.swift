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
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let hourlyCollectionViewDataSource = HourlyCollectionViewDataSource()
    private let detailCollectionViewDataSource = DetailCollectionViewDataSource()
    var coordinates: Coordinates!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        WeatherForecast.fetchWeather(coordinates: coordinates) { (result) in
            switch result {
            case .success(let response):
                self.hourlyCollectionViewDataSource.currentArray = response.weatherHourly.currentArray
                self.hourlyCollectionView.dataSource = self.hourlyCollectionViewDataSource
                self.detailCollectionViewDataSource.detailArray = response.weatherDaily.detailArray
                self.collectionView.dataSource = self.detailCollectionViewDataSource
            case .failure(let error):
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
