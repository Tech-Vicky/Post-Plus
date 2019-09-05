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

class MapViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
/* ---- Map View Functionality Start ---- */
        
        PtoPMap.showsUserLocation = true
        
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||
                CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
        }
        else {
            // Location Is Disable Alert Message
            locationDisableAlert(title: "Location Is Disabled", message: "Please, Turn On Your Location Services")
        }
        
/* ---- Map View Functionality End ---- */
        
    }
    
    
/* ---- Map View Functionality Start ---- */

    // View Declaration Start:
    
    @IBOutlet weak var PtoPMap: MKMapView!
    
    
    // Variable Declaratio Start:
    
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
    
/* ---- Map View Functionality End ---- */
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}
