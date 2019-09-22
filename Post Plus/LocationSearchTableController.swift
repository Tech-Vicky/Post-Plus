//
//  LocationSearchTableController.swift
//  Post Plus
//
//  Created by Tech World on 6/9/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTableController: UITableViewController, UISearchResultsUpdating {
   
        var matchingItems : [MKMapItem] = []
        var mapView : MKMapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSearchCell")
        let selectedItem = matchingItems[indexPath.row].placemark
        cell?.textLabel?.text = selectedItem.name
        cell?.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        return cell!
        
    }

    func updateSearchResults(for searchController: UISearchController) {
    
         guard let mapView = mapView as MKMapView? else { return }
         guard let searchBarText = searchController.searchBar.text else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
        
    }
    
    // Method Converts The Placemark To A Custom Address Format Like: “4 Melrose Place, Washington DC”.
    func parseAddress(selectedItem: MKPlacemark) -> String {
        
        // Put a Space Between Block Number and Street Name
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.subThoroughfare != nil) ?  " " : ""
        
        // Put a Comma Between Street and City/State
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.subThoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? " " : ""
        
        // Put a Space Between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        
        return addressLine
        
    }

    /*
     // Resources:
     
     // 1. Search Bar And Search Location Sugesstion : https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/
     
     */
    

}
