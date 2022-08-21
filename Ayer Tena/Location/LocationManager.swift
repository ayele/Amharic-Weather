//
//  LocationManager.swift
//  Ayer Tena
//
//  Created by Amanuel Ayele on 8/21/22.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published private(set) var location: CLLocationCoordinate2D?
    @Published private(set) var isLoading = false
    
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestWhenInUseAuthorization()
    }
    
    // MARK:- Location manager delegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("locationManagerDidChangeAuthorization")

        switch manager.authorizationStatus {
          case .restricted, .denied:
            print("Authrization restricted or denied")
             break
          case .authorizedWhenInUse:
            print("Authrized when in use")
            manager.requestLocation()
             break
          case .authorizedAlways:
             break
          case .notDetermined:
             break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
