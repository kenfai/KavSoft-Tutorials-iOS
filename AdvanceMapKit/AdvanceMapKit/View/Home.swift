//
//  Home.swift
//  AdvanceMapKit
//
//  Created by Ginger on 10/02/2021.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    // Location Manager
    @State var locationMAnager = CLLocationManager()
    
    var body: some View {
        ZStack {
            
            // MapView
            MapView()
                // using it as environment object so that it can be used in subView
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                VStack(spacing: 0) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $mapData.searchTxt)
                            .colorScheme(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    
                    // Displaying Results
                    if !mapData.places.isEmpty && mapData.searchTxt != "" {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(mapData.places) { place in
                                    Text(place.placemark.name ?? "")
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading)
                                        .onTapGesture {
                                            mapData.selectPlace(place: place)
                                        }
                                    
                                    Divider()
                                }
                            }
                            .padding(.top)
                        }
                        .background(Color.white)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button(action: mapData.focusLocation) {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                    
                    Button(action: mapData.updateMapType) {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding(10)
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
            }
        }
        .onAppear {
            // Setting Delegate
            locationMAnager.delegate = mapData
            locationMAnager.requestWhenInUseAuthorization()
        }
        // Permission Denied Alert
        .alert(isPresented: $mapData.permissionDenied) {
            Alert(title: Text("Permission Denied"), message: Text("Please Enable Permission In App Settings"), dismissButton: .default(Text("Go to Settings"), action: {
                // Redirecting User to Settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        }
        .onChange(of: mapData.searchTxt) { (value) in
            // Searching Places
            
            // You can use your own delay time to avoid Continuos Search Request
            let delay = 0.3
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if value == mapData.searchTxt {
                    // Search
                    self.mapData.searchQuery()
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
