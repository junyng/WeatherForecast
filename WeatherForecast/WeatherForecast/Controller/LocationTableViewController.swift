//
//  LocationsTableViewController.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class LocationTableViewController: UITableViewController {
    
    private lazy var addLocationButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.addTarget(self, action: #selector(searchButtonDidTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 414, height: 50))
        return view
    }()
    
    var locationStore: LocationStore!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isToolbarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        configureFooterView()
        configureBackgroundView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let navigationController = segue.destination as! UINavigationController
            let searchLocationController = navigationController.viewControllers.first as! SearchLocationTableViewController
            searchLocationController.locationStore = locationStore
        } else if segue.identifier == "pages" {
            let pageController = segue.destination as! PageViewController
            pageController.locations = locationStore.locations
            pageController.currentIndex = tableView.indexPathForSelectedRow?.row ?? 0
        }
    }
    
    @objc
    func searchButtonDidTapped() {
        self.performSegue(withIdentifier: "search", sender: nil)
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable(_:)), name: .locationsAdded, object: nil)
    }
    
    /// Notification 이 발생하면 테이블 뷰를 리로드
    @objc
    func refreshTable(_ notification: Notification) {
        self.tableView.reloadData()
    }
    
    private func configureFooterView() {
        addLocationButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(addLocationButton)
        addLocationButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        addLocationButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20).isActive = true
        tableView.tableFooterView = footerView
    }
    
    private func configureBackgroundView() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        label.numberOfLines = 2
        label.text = "위치 정보가 없습니다. \n추가 버튼을 눌러 위치 정보를 추가하세요."
        label.textAlignment = .center
        self.tableView.backgroundView = label
    }
}

// MARK: UITableViewDataSource
extension LocationTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if locationStore.locations.isEmpty {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        
        return locationStore.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.swiftIdentifier, for: indexPath) as? LocationCell else { return UITableViewCell() }
        let location = locationStore.locations[indexPath.row]
        /// location의 개수 만큼 좌표별 API를 호출한다.
        WeatherClient.shared.getFeed(from: location.coordinate()) { result in
            switch result {
            case .success(let response):
                if let dto = response?.weatherCurrently {
                    /// 모델 파싱 작업
                    let currentWeather = CurrentlyWeatherParser.parse(dto: dto)
                    cell.timeLabel.text = DateUtil.currentTime(from: currentWeather.time)
                    cell.locationLabel.text = location.addressString() ?? "-"
                    cell.temperatureLabel.text = String(format: "%.1f°", currentWeather.temperature.fahrenheitToCelsius())
                }
            case .failure:
                cell.timeLabel.text = "-"
                cell.locationLabel.text = location.addressString() ?? "-"
                cell.temperatureLabel.text = "-"
            }
        }
        return cell
    }
}

// MARK: UITableViewDelegate
extension LocationTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationStore.locations[indexPath.row]
            locationStore.removeLocation(location)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
