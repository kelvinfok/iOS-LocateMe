//
//  ViewController.swift
//  Find My Location
//
//  Created by kelvinfok on 15/7/16.
//  Copyright © 2016 kelvinfok. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var addressCounter: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var courseLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var altitudeLabel: UILabel!
    
    var manager: CLLocationManager!
    
    var requestCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print(locations)
        
        let userLocation: CLLocation = locations[0]
        self.latitudeLabel.text = "Latitude: \(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "Altitude: \(userLocation.coordinate.longitude)"
        self.courseLabel.text = "Course: \(userLocation.course)"
        speedLabel.text = "Speed: \(userLocation.speed)"
        altitudeLabel.text = "Altitude: \(userLocation.altitude)"
        requestCounter += 1
        self.addressCounter.text = "Address (\(requestCounter))"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            
            
            if (error != nil) {
                print(error)
            }
            else {
                if let placemark = placemarks?.first {
                    let subThoroughfare = placemark.subThoroughfare ?? ""
                    let thoroughfare    = placemark.thoroughfare    ?? ""
                    
                    self.addressLabel.text = "\(subThoroughfare) \(thoroughfare)"

                    print(placemarks)
                    
                }
            }
        })

    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

