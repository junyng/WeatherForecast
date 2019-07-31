//
//  SearchCityViewController.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let cities = ["서울", "부산", "인천", "대구", "광주"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: UITableViewDataSource
extension SearchCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        cell.textLabel?.text = cities[indexPath.item]
        return cell
    }
}
