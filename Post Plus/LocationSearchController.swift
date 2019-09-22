//
//  LocationSearchController.swift
//  Post Plus
//
//  Created by Tech World on 6/9/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchController: UIViewController, UISearchBarDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {

    // Search Location Auto Complete Functionality Variables:
    var searchResultContoller : UISearchController = UISearchController()
    var searchBar : UISearchBar = UISearchBar()
    var pickUpLocation: String = String()
    var postingLocation : String = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTableController") as! LocationSearchTableController
        
        searchResultContoller = UISearchController(searchResultsController: locationSearchTable)
        
        searchResultContoller.searchResultsUpdater = locationSearchTable
        
        // Essential To Perform Search Bar Cancel Button Clicked
        searchBar.delegate = self
        searchResultContoller.searchBar.delegate = self
        navigationItem.searchController?.searchBar.delegate = self
        navigationController?.navigationItem.searchController?.searchBar.delegate = self
        
        // Set Up Search Bar
        setUpSearch()

        // To Open Search Bar While Text Editing.
    }
    
    func setUpSearch() {
        
        searchBar = searchResultContoller.searchBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchResultContoller.searchBar
        navigationItem.hidesBackButton = true
        
            if let pickUpLocation = pickUpLocation as String? {
                searchBar.placeholder = pickUpLocation
            }
           if let postingLocation = postingLocation as String? {
            if searchBar.placeholder?.isEmpty == true {
                    searchBar.placeholder = postingLocation
            }
                }
 
        // Configure The UISearchController appearance
        searchResultContoller.hidesNavigationBarDuringPresentation = false
        searchResultContoller.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        searchBar.becomeFirstResponder()
    }
    
    // To Perform Cancel Button To Go Back To Location Details 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
     // Resources:
     
     // 1. Segue Basics : https://blog.apoorvmote.com/segue-when-tapped-on-textfield-pass-data-through-navigation-back-button-ios-swift/
     
     2. Search Bar And Search Location Sugesstion : https://www.thorntech.com/2016/01/how-to-search-for-location-using-apples-mapkit/
     
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
