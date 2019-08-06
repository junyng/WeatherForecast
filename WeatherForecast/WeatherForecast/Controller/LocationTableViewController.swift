//
//  LocationsTableViewController.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    var locationStore: LocationStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        configureFooterView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let navigationController = segue.destination as! UINavigationController
            let searchLocationController = navigationController.viewControllers.first as! SearchLocationTableViewController
            searchLocationController.locationStore = locationStore
        } else if segue.identifier == "pages" {
            let pageController = segue.destination as! PageViewController
            pageController.locationStore = locationStore
            pageController.currentPageIndex = tableView.indexPathForSelectedRow?.item ?? 0
        }
    }
    
    @objc func searchButtonDidTapped() {
        self.performSegue(withIdentifier: "search", sender: nil)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(_:)), name: .reloadLocations, object: nil)
    }
    
    @objc func refreshTable(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    private func configureFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 50))
        let temperatureToggle = UISegmentedControl(items: ["°C", "°F"])
        temperatureToggle.translatesAutoresizingMaskIntoConstraints = false
        let addLocationButton = UIButton(type: .contactAdd)
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        addLocationButton.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        footerView.addSubview(temperatureToggle)
        footerView.addSubview(addLocationButton)
        temperatureToggle.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        temperatureToggle.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        addLocationButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        addLocationButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20).isActive = true
        tableView.tableFooterView = footerView
    }
}

// MARK: UITableViewDataSource
extension LocationTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationStore.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationCell
        let location = locationStore.locations[indexPath.item]
        WeatherForecast.fetchWeather(coordinate: location.coordinate()) { (result) in
            switch result {
            case .success(let response):
                cell.timeLabel.text = "\(response.weatherCurrently.time)"
                cell.temperatureLabel.text = "\(response.weatherCurrently.temperature)"
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}

// MARK: UITableViewDelegate
extension LocationTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationStore.locations[indexPath.item]
            locationStore.removeLocation(location)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
