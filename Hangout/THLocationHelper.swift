//
//  THLocationHelper.swift
//  TheHangouts
//
//  Created by Shravan Keri on 09/02/17.
//  Copyright © 2017 Shravan Keri. All rights reserved.
//

import UIKit
import CoreLocation

class THLocationHelper: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = THLocationHelper()
    var currentLocation: CLLocation?
    var locationManager:CLLocationManager?
    
    override init() {
        super.init()
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager!.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager!.requestAlwaysAuthorization()
            locationManager!.distanceFilter = 50
            locationManager!.startUpdatingLocation()
        }
    }
    
    func getLatLong() -> (lat: Double, long: Double) {
        return ((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
    }
    
    func getDistanceof(lat: Double, long: Double) -> (Double){
        let coordinate = CLLocation(latitude: lat, longitude: long)
        let distanceInMeters = currentLocation?.distance(from: coordinate)
        return distanceInMeters ?? 0
    }
    
    //MARK: CLLocationManagerDelegate
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
        print(locations[0].coordinate.latitude,locations[0].coordinate.longitude);
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "locationdidupdate"), object: nil);        
    }
}
