//
//  ContentViewModel.swift
//  UserLocationApp
//
//  Created by User on 28.11.25.
//

import Foundation
import MapKit
import _MapKit_SwiftUI

enum MapDetails{
    static let startingLocation = CLLocationCoordinate2DMake(40.4093, 49.8671)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05,
                                            longitudeDelta: 0.05)
    static let defaultBaku = Marker("Bakı", coordinate: CLLocationCoordinate2D(latitude: 40.4093, longitude: 49.8671))
}

final class ContentViewModel :NSObject,ObservableObject , CLLocationManagerDelegate {
    var locationManager:CLLocationManager?
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan
    )
    
    func checkIfLocationServicesInEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
        } else {
            print("Show an alert letting them now this is off and to go turn it on")
        }
    }
    
    private func checkLocationAuthorization(){
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls. ")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways,.authorizedWhenInUse:
            if let location = locationManager.location {
                region = MKCoordinateRegion(center: location.coordinate,
                                            span: MapDetails.defaultSpan)
            }
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
