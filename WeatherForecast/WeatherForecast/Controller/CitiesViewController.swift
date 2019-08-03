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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFooterView()
    }
    
    @IBAction func searchButtonDidTapped() {
        self.performSegue(withIdentifier: "search", sender: nil)
    }
    
    private func configureFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 50))
        let temperatureToggle = UISegmentedControl(items: ["°C", "°F"])
        temperatureToggle.translatesAutoresizingMaskIntoConstraints = false
        let addLocationButton = UIButton(type: .contactAdd)
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city", for: indexPath)
        return cell
    }
}
