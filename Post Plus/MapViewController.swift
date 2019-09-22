//
//  MapViewController.swift
//  Post Plus
//
//  Created by Tech World on 15/8/19.
//  Copyright © 2019 Tech World. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, MKLocalSearchCompleterDelegate, UISearchBarDelegate, UINavigationBarDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Press Return Key - Hide Keyboard Functionality
        hideKeyboard()
        
        // To Pass The Data To Location Search Controller
        pickUpLocation.delegate = self
        postingLocation.delegate = self
        
/* ---- Map View Current Location Functionality Start ---- */
        
        PtoPMap.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        }
        else {
            // Location Is Disable Alert Message
            locationDisableAlert(title: "Location Is Disabled", message: "Please, Turn On Your Location Services")
        }
        
/* ---- Map View Current Location Functionality End ---- */
    }
    
/* ---- Map View Current Location Functionality Start ---- */

    // View Declaration Start:
    @IBOutlet weak var PtoPMap: MKMapView!

    // Variable Declaration Start:
    var locationManager = CLLocationManager()
    
    // Functions Implementation Start:
    
    // CLLocationManager Delegate: Method 1
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(locations[0].coordinate.latitude, locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
        
        self.PtoPMap.setRegion(region, animated: true)
    }
    
     // CLLocationManager Delegate: Method 2
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable To Access Your Current Location")
    }
    
    
    /*
     // Resources:
     
     // 1. Map View Basics : https://www.youtube.com/watch?v=sVMbFgUdDg0
     
     */
    
/* ---- Map View Current Location Functionality End ---- */
    
/* ---- Location Is Disable Alert Message Functionality Start ---- */
    
    func locationDisableAlert(title: String, message: String) {
        
         let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    /*
     // Resources:
     
     // 1. Alert Message Basics : https://www.youtube.com/watch?v=4EAGIiu7SFU
     
     */
    
/* ---- Location Is Disable Alert Message Functionality End ---- */
    
    
/* ---- Pick Up Location On Map View Functionality Start ---- */
    
    // Action View Declaration Start:
    @IBAction func pickUpLocation(_ sender: Any) {
        
        // Ignoring User Activity
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Create the Search Request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = pickUpLocation.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            // End Ignoring User Activity
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                
                // To Pop up An Alert Message
                self.locationDisableAlert(title: "Unable To Reach", message: "Please, Try Again")
                
            } else {
                
                // Remove Annotations
                let annotations = self.PtoPMap.annotations
                self.PtoPMap.removeAnnotations(annotations)
                
                if response != nil {
                    
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude
                    
                    // Create Annotation
                    let createAnnotation = MKPointAnnotation()
                    createAnnotation.title = self.pickUpLocation.text
                    createAnnotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                    self.PtoPMap.addAnnotation(createAnnotation)
                    
                    //Zooming In On Annotation
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    self.PtoPMap.setRegion(region, animated: true)
                    
                }
                
            }
        }
        
    }
    

    /*
     // Resources:
     
     // 1. Basics : https://www.youtube.com/watch?v=GYzNsVFyDrU
     
     */
    
/* ---- Pick Up Location On Map View Functionality End  ---- */
    
/* ---- Map View Search Location Functionality Start ---- */
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.placeholder == pickUpLocation.placeholder {
            performSegue(withIdentifier:"searchPickUp", sender: self)
        }
        if textField.placeholder == postingLocation.placeholder {
            performSegue(withIdentifier:"searchPosting", sender: self)
        }
        
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchPickUp" {
            let searchLocation = segue.destination as! LocationSearchController
            searchLocation.pickUpLocation = pickUpLocation.placeholder!
        }
        if segue.identifier == "searchPosting"{
            let searchLocation = segue.destination as! LocationSearchController
            searchLocation.postingLocation = postingLocation.placeholder!
        }
        
    }
    
    /*
     // Resources:
     
     // 1. Segue Basics : https://blog.apoorvmote.com/segue-when-tapped-on-textfield-pass-data-through-navigation-back-button-ios-swift/
     
     */
    
/* ---- Map View Search Location Functionality End ---- */

/* ---- Posting Location On Map View Functionality Start  ---- */

    // Action View Declaration Start:
    @IBAction func postingLocation(_ sender: Any) {
        
        // Ignoring User Activity
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // Create the Search Request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = postingLocation.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            // End Ignoring User Activity
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil {
                
                // To Pop up An Alert Message
                self.locationDisableAlert(title: "Unable To Reach", message: "Please, Try Again")
                
            } else {
                
                // Remove Annotations
                let annotations = self.PtoPMap.annotations
                self.PtoPMap.removeAnnotations(annotations)
                
                if response != nil {
                    
                    let latitude = response?.boundingRegion.center.latitude
                    let longitude = response?.boundingRegion.center.longitude
                    
                    // Create Annotation
                    let createAnnotation = MKPointAnnotation()
                    createAnnotation.title = self.postingLocation.text
                    createAnnotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                    self.PtoPMap.addAnnotation(createAnnotation)
                    
                    //Zooming In On Annotation
                    let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                    let region = MKCoordinateRegion(center: coordinate, span: span)
                    self.PtoPMap.setRegion(region, animated: true)
                    
                }
                
            }
        }
        
    }
    
    /*
     // Resources:
     
     // 1. Basics : https://www.youtube.com/watch?v=GYzNsVFyDrU
     
     */
    
/* ---- Posting Location On Map View Functionality End  ---- */
    
/* ---- Press Return Key - Hide Keyboard Functionality Start ---- */
    
    // UI Variables Start:
   
    @IBOutlet weak var pickUpLocation: UITextField!
    @IBOutlet weak var postingLocation: UITextField!
    
    // Functions Start:
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // To Hide the Keyboard while press on Return Key. Definition:
    func hideKeyboard(){
        pickUpLocation.delegate = self
        postingLocation.delegate = self
    }
    
    // Functions End --
    
    // Override Functions Start:
    
    // When user touches the outside of the TextField, it will Hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Override Functions End --
    
    /*
     // Rescources:
     
     1. Basics: https://www.youtube.com/watch?v=ahzvP8ulebk
     */
    
/* ---- Press Return Key - Hide Keyboard Functionality End ---- */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


