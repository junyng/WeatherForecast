//
//  SearchLocationTableViewController.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit
import MapKit

class SearchLocationTableViewController: UITableViewController {
    
    var locationStore: LocationStore!
    
    private var places: [MKMapItem]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var suggestionController: SuggestionsTableTableViewController!
    private var searchController: UISearchController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSearchController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchController.searchBar.becomeFirstResponder()
        }
    }
    
    // MARK: - Custom Methods
    private func getCoordinate(addressString : String,
                               completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    private func configureSearchController() {
        suggestionController = SuggestionsTableTableViewController()
        suggestionController.tableView.delegate = self
        searchController = UISearchController(searchResultsController: suggestionController)
        searchController.searchResultsUpdater = suggestionController
    }
    
    private func configureSearchBar() {
        navigationItem.titleView = searchController.searchBar
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.delegate = self
        self.definesPresentationContext = true
    }
    
    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let mapItem = places?[indexPath.row] {
            cell.textLabel?.text = mapItem.name
        }
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView == suggestionController.tableView,
            let suggestion = suggestionController.completerResults?[indexPath.row] {
            searchController.isActive = false
            searchController.searchBar.text = suggestion.title
            let dispatchGroup = DispatchGroup()
            DispatchQueue(label: "serial").async(group: dispatchGroup) {
                self.getCoordinate(addressString: suggestion.title) { (coordinate, error) in
                    let location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude, address: suggestion.title)
                    self.locationStore.addLocation(location)
                }
            }
            dispatchGroup.notify(queue: .global()) {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
}

extension SearchLocationTableViewController: UISearchControllerDelegate { }

extension SearchLocationTableViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.isActive = false
        searchBar.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
}
