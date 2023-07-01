//
//  ViewController.swift
//  CurrentLocation
//
//  Created by sss on 01.07.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
   
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }

    @IBAction func button(_ sender: Any) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("Location enabled")
            locationManager.startUpdatingLocation()
        } else {
            print("Location not enabled")
        }
    }
    
    @IBAction func stopButton(_ sender: Any) {
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocations = locations[0] as CLLocation
        
        latitudeLabel.text = String(userLocations.coordinate.latitude)
        longitudeLabel.text = String(userLocations.coordinate.longitude)
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocations) { (placemark, error ) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let placemark = placemark, placemark.count > 0 {
                let locality = placemark[0].locality
                let administativeArea = placemark[0].administrativeArea
                let country = placemark[0].country
                self.addressLabel.text = "Address: \(String(describing: locality)), \(String(describing: administativeArea)), \(String(describing: country))"
            }
        }
    }
}

