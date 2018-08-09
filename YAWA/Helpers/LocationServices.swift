//
//  LocationServices.swift
//  YAWA
//
//  Created by Fu Yuan on 9/08/18.
//  Copyright © 2018 MEA Test. All rights reserved.
//

import Foundation
import CoreLocation

class LocationServices {
    
    static let shared = LocationServices()
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let authStatus = CLLocationManager.authorizationStatus()
    let inUse = CLAuthorizationStatus.authorizedWhenInUse
    
    func getAdress(completion: @escaping (_ region: String) -> ()) {
        self.locManager.requestWhenInUseAuthorization()
        if self.authStatus == inUse {
            self.currentLocation = locManager.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { placemarks, error in
                if let _ = error {
                    completion("Auckland")
                } else {
                    let placemark = placemarks?[0]
//                    let address = "\(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
//                    print(address)
                    let locality = (placemark?.locality != nil ? placemark?.locality : placemark?.administrativeArea) ?? "Auckland"
                    if let regionCode = Locale.current.regionCode {
                        completion(locality + "," + regionCode)
                    } else {
                        completion(locality)
                    }
                }
            }
        } else {
            completion("Auckland")
        }
    }
}
