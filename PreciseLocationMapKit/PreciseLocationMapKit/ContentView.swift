//
//  ContentView.swift
//  PreciseLocationMapKit
//
//  Created by Ginger on 12/12/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 3.1412, longitude: 101.68653), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @State var tracking: MapUserTrackingMode = .follow
    @State var manager = CLLocationManager()
    @StateObject var managerDelegate = locationDelegate()
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $tracking, annotationItems: managerDelegate.pins) { pin in
                MapPin(coordinate: pin.location.coordinate, tint: .red)
            }
        }
        .onAppear {
            manager.delegate = managerDelegate
        }
    }
}

// First with Full Accuracy

// Now when Precise Location is not turned on
// Location Manager Delegate

class locationDelegate: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var pins: [Pin] = []
    
    // checking authorization status
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            print("authorized")
            
            // checking whether Precise Locations is turned on
            if manager.accuracyAuthorization != .fullAccuracy {
                print("reduced accuracy")
                
                // requesting temporary accuracy
                manager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: "Location") { err in
                    if err != nil {
                        print(err!)
                        return
                    }
                }
            }
            
            // setting reduced accuracy to false
            // and updating locations
            manager.startUpdatingLocation()
        } else {
            print("not authorized")
            
            // requesting access
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("new Location")
        
        pins.append(Pin(location: locations.last!))
    }
}

// Map Pins for updates
struct Pin: Identifiable {
    var id = UUID().uuidString
    var location: CLLocation
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
