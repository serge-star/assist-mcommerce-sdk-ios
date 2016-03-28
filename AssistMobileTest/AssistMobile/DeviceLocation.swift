//
//  DeviceLocation.swift
//  AssistPayTest
//
//  Created by Sergey Kulikov on 08.07.15.
//  Copyright (c) 2015 Assist. All rights reserved.
//

import Foundation
import CoreLocation

protocol DeviceLocationDelegate: class {
    func locationError(text: String)
    func location(latitude: String, longitude: String)
}

class DeviceLocation : NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    private weak var delegate: DeviceLocationDelegate!
    
    init(delegate: DeviceLocationDelegate) {
        self.delegate = delegate
    }
    
    func requestLocation() {
        print("request location")
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            print("start updating location")
            locationManager.startUpdatingLocation()
        } else {
            delegate.locationError("Location service disabled")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location error")
        delegate.locationError(error.localizedDescription)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        print("location updateToLocation")
        locationManager.stopUpdatingLocation()
        let coord = newLocation.coordinate
        delegate.location("\(coord.latitude)", longitude: "\(coord.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        print("location uodateLocations")
        locationManager.stopUpdatingLocation()
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        delegate.location("\(coord.latitude)", longitude: "\(coord.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("location status")
        if status == .NotDetermined || status == .Restricted || status == .Denied {
            delegate.locationError("location denied")
        }
    }
    
}