//
//  MapViewModel.swift
//  AdvanceMapKit
//
//  Created by Ginger on 10/02/2021.
//

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    
    // Region
    @Published var region: MKCoordinateRegion!
    // Based on Location it will set up
    
    // Alert
    @Published var permissionDenied = false
    
    // Map Type
    @Published var mapType: MKMapType = .standard
    
    // SearchText
    @Published var searchTxt = ""
    
    // Searched Places
    @Published var places: [Place] = []
    
    // Updating Map Type
    func updateMapType() {
        
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    // Focus Location
    func focusLocation() {
        guard let _ = region else { return }
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    // Search Places
    func searchQuery() {
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTxt
        
        // Fetch
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else { return }
            
            self.places = result.mapItems.compactMap({ (item) -> Place? in
                return Place(placemark: item.placemark)
            })
        }
    }
    
    // Pick Search Result
    func selectPlace(place: Place) {
        // Showing Pin on Map
        searchTxt = ""
        
        guard let coordinate = place.placemark.location?.coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = place.placemark.name ?? "No Name"
        
        // Removing All Old Ones
        mapView.removeAnnotations(mapView.annotations)
        
        mapView.addAnnotation(pointAnnotation)
        
        // Moving Map To That Location
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Checking Permissions
        switch manager.authorizationStatus {
        case .denied:
            // Alert
            permissionDenied.toggle()
        case .notDetermined:
            // Requesting
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            // If Permission Given
            manager.requestLocation()
        default:
            ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Error
        print(error.localizedDescription)
    }
    
    // Getting User Region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        // Updating Map
        self.mapView.setRegion(self.region, animated: true)
        
        // Smooth Animations
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
}
