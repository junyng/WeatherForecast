//
//  CitiesViewController.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var coordinatesDataStore: CoordinatesDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        configureFooterView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let navigationController = segue.destination as! UINavigationController
            let searchLocationController = navigationController.viewControllers.first as! SearchLocationTableViewController
            searchLocationController.coordinatesDataStore = coordinatesDataStore
        } else if segue.identifier == "pages" {
            let pageController = segue.destination as! PageViewController
            pageController.coordinatesDataStore = coordinatesDataStore
        }
    }
    
    @objc func searchButtonDidTapped() {
        self.performSegue(withIdentifier: "search", sender: nil)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(_:)), name: .reloadCoordinatesList, object: nil)
    }
    
    @objc func refreshTable(_ notification:Notification) {
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
extension CitiesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinatesDataStore.coordinatesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath) as! LocationCell
        let coordinates = coordinatesDataStore.coordinatesList[indexPath.item]
        Weather.fetch(coordinates: coordinates) { (result) in
            switch result {
            case .success(let weather):
                cell.timeLabel.text = "\(weather.currently.time)"
                cell.temperatureLabel.text = "\(weather.currently.temperature)"
            case .failure(let error):
                print(error)
            }
        }
        return cell
    }
}
