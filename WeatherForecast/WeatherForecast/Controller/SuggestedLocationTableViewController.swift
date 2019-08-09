//
//  SuggestedLocationTableViewController.swift
//  WeatherForecast
//
//  Created by BLU on 02/08/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit
import MapKit

class SuggestedLocationTableViewController: UITableViewController {
    
    let searchCompleter = MKLocalSearchCompleter()
    var completerResults: [MKLocalSearchCompletion]?
    
    convenience init() {
        self.init(style: .plain)
        searchCompleter.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Review: 상수 String 제거
        tableView.register(SuggestedCompletionTableViewCell.self, forCellReuseIdentifier: SuggestedCompletionTableViewCell.swiftIdentifier)
    }
}

extension SuggestedLocationTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Review: 상수 String 제거
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCompletionTableViewCell.swiftIdentifier, for: indexPath)
        
        if let suggestion = completerResults?[indexPath.row] {
            cell.textLabel?.text = suggestion.title
            cell.detailTextLabel?.text = suggestion.subtitle
        }
        
        return cell
    }
}

extension SuggestedLocationTableViewController: MKLocalSearchCompleterDelegate {
    
    /// - Tag: QueryResults
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completerResults = completer.results
        tableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        if let error = error as NSError? {
            print("MKLocalSearchCompleter encountered an error: \(error.localizedDescription)")
        }
    }
}

extension SuggestedLocationTableViewController: UISearchResultsUpdating {
    
    /// - Tag: UpdateQuery
    func updateSearchResults(for searchController: UISearchController) {
        // Ask `MKLocalSearchCompleter` for new completion suggestions based on the change in the text entered in `UISearchBar`.
        searchCompleter.queryFragment = searchController.searchBar.text ?? ""
    }
}

private class SuggestedCompletionTableViewCell: UITableViewCell, SwiftNameIdentifier {
    // Review: 상수 String 을 쓰는 건 좋지 않는 것 같아요~
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
