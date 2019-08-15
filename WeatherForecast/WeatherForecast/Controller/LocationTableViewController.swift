//
//  LocationsTableViewController.swift
//  WeatherForecast
//
//  Created by BLU on 31/07/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

typealias LocationInfo = (location: Location, weather: WeatherCurrently?)

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
    var weatherList: [WeatherCurrently?] = [WeatherCurrently?](repeating: nil, count: 20)
    lazy var locationInfoList: [LocationInfo] = Array(zip(locationStore.locations, weatherList))
    private var timer: Timer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isToolbarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotification()
        configureFooterView()
        configureBackgroundView()
        fetchWeatherList()
        createTimer()
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
        if let addedLocation = locationStore.locations.last {
            let locationInfo: LocationInfo = (location: addedLocation, weather: nil)
            locationInfoList.append(locationInfo)
        }
        self.tableView.reloadData()
    }
    
    private func fetchWeatherList() {
        for index in 0..<locationInfoList.count {
            WeatherClient.shared.getFeed(from: locationInfoList[index].location.coordinate()) { result in
                switch result {
                case .success(let response):
                    if let dto = response?.weatherCurrently {
                        let currentWeather = CurrentlyWeatherParser.parse(dto: dto)
                        self.locationInfoList[index].weather = currentWeather
                        let indexPath = IndexPath(item: index, section: 0)
                        self.tableView.reloadRows(at: [indexPath], with: .fade)
                    }
                case .failure:
                    break
                }
            }
        }
    }
    
    private func createTimer() {
        let timer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(updateTimer),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.timer = timer
    }
    
    @objc
    private func updateTimer() {
        guard let visibleRowsIndexPaths = tableView.indexPathsForVisibleRows else {
            return
        }
        
        for indexPath in visibleRowsIndexPaths {
            if let cell = tableView.cellForRow(at: indexPath) as? LocationCell {
                cell.updateTime()
            }
        }
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
        
        return locationInfoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseIdentifier, for: indexPath) as? LocationCell else { return UITableViewCell() }
        let locationInfo = locationInfoList[indexPath.row]
        cell.configure(locationInfo)
        return cell
    }
}

// MARK: UITableViewDelegate
extension LocationTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = locationStore.locations[indexPath.row]
            locationStore.removeLocation(location)
            locationInfoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
