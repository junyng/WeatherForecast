//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by BLU on 01/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let hourlyCollectionViewDataSource = HourlyCollectionViewDataSource()
    private let detailCollectionViewDataSource = DetailCollectionViewDataSource()
    var location: Location!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        locationLabel.text = location.addressString() ?? "-"
        WeatherClient.shared.getFeed(from: location.coordinate()) { (result) in
            switch result {
            case .success(let response):
                if let response = response {
                    let hourlyWeather = HourlyWeatherParser.parse(dto: response.weatherHourly)
                    let dailyWeather = DailyWeatherParser.parse(dto: response.weatherDaily)
                    self.hourlyCollectionViewDataSource.currentArray = hourlyWeather.currentArray
                    self.detailCollectionViewDataSource.detailArray = dailyWeather.detailArray
                    self.hourlyCollectionView.dataSource = self.hourlyCollectionViewDataSource
                    self.collectionView.dataSource = self.detailCollectionViewDataSource
                }
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
