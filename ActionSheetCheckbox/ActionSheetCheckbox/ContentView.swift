//
//  ContentView.swift
//  ActionSheetCheckbox
//
//  Created by Ginger on 21/01/2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var coordinate = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.335, longitude: -122.0132), latitudinalMeters: 10000, longitudinalMeters: 10000)
    
    @State var filters = [
        FilterItem(title: "Most Relevant", checked: false),
        FilterItem(title: "Top Rated", checked: false),
        FilterItem(title: "Lowest Price", checked: false),
        FilterItem(title: "Highest Price", checked: false),
        FilterItem(title: "Most Favourite", checked: false),
        FilterItem(title: "Available Now", checked: false),
    ]
    
    @State var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var showFilter = false
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            Map(coordinateRegion: $coordinate)
                .ignoresSafeArea()
            
            // Filter Button
            Button(action: {
                withAnimation {
                    showFilter.toggle()
                }
            }, label: {
                Image(systemName: "slider.vertical.3")
                    .font(.title2)
                    .foregroundColor(.black)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
            })
            .padding(.trailing)
            .padding(.top, 10)
            
            // Filter or Radio Button View
            VStack {
                Spacer()
                
                VStack(spacing: 18) {
                    HStack {
                        Text("Search By")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showFilter.toggle()
                            }
                        }, label: {
                            Text("Done")
                                .fontWeight(.heavy)
                                .foregroundColor(Color("green"))
                        })
                    }
                    .padding([.horizontal, .top])
                    .padding(.bottom, 10)
                    
                    ForEach(filters) { filter in
                        CardView(filter: filter)
                    }
                }
                .padding(.bottom, 10)
                .padding(.bottom, edges?.bottom)
                .padding(.top, 10)
                .background(Color.white.clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: showFilter ? 0 : UIScreen.main.bounds.height / 2)
            }
            .ignoresSafeArea()
            .background(
                Color.black.opacity(0.3).ignoresSafeArea()
                    .opacity(showFilter ? 1 : 0)
                // you can also add close here
                    .onTapGesture {
                        withAnimation {
                            showFilter.toggle()
                        }
                    }
            )
        })
    }
}

struct CustomCorner: Shape {
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

// Card View
struct CardView: View {
    @State var filter: FilterItem
    
    var body: some View {
        HStack {
            Text(filter.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(filter.checked ? Color("green") : Color.gray, lineWidth:  1)
                    .frame(width: 26, height: 26)
                
                if filter.checked {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(Color("green"))
                }
            }
            .frame(width: 26, height: 26)
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture {
            filter.checked.toggle()
        }
    }
}

// Sample Filters
struct FilterItem: Identifiable {
    var id = UUID().uuidString
    var title: String
    var checked: Bool
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
