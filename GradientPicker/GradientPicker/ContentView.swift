//
//  ContentView.swift
//  GradientPicker
//
//  Created by Ginger on 03/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark )
    }
}

struct Home: View {
    @State var show = false
    @State var search = ""
    @State var gradients: [Gradient] = []
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @State var filtered: [Gradient] = []
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                if show {
                    // Search Bar
                    TextField("Search Gradient", text: $search)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    // search functionality
                        .onChange(of: search) { value in
                            if search != "" {
                                searchColor()
                            } else {
                                // clearing all search results
                                search = ""
                                filtered = gradients
                            }
                        }
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            // clearing search
                            search = ""
                            // safe side
                            filtered = gradients
                            show.toggle()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                } else {
                    Text("Gradients")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            show.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            if columns.count == 1 {
                                columns.append(GridItem(.flexible(), spacing: 20))
                            } else {
                                columns.removeLast()
                            }
                        }
                    }) {
                        Image(systemName: columns.count == 1 ? "square.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            .padding(.horizontal)
            // VStack Bug
            .zIndex(1)
            
            
            if gradients.isEmpty {
                // loading View
                ProgressView()
                    .padding(.top, 55)
                
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        // assigning name as ID
                        ForEach(filtered, id: \.name) { gradient in
                            VStack(spacing: 15) {
                                ZStack {
                                    LinearGradient(gradient: .init(colors: HEXtoRGB(colors: gradient.colors)), startPoint: .top, endPoint: .bottom)
                                        .frame(height: 180)
                                        .clipShape(CShape())
                                        .cornerRadius(15)
                                    // conext Menu
                                        .contentShape(CShape())
                                        .contextMenu {
                                            Button(action: {
                                                // copying to copy Board
                                                var colorCode = ""
                                                
                                                for color in gradient.colors {
                                                    colorCode += color + "\n"
                                                }
                                                
                                                UIPasteboard.general.string = colorCode
                                            }) {
                                                Text("Copy")
                                            }
                                        }
                                    
                                    Text(gradient.name)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                }
                                
                                if columns.count == 1 {
                                    HStack(spacing: 15) {
                                        ForEach(gradient.colors, id: \.self) { color in
                                            Text(color)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .zIndex(0)
            }
        }
        .onAppear {
            getColors()
        }
    }
    
    func getColors() {
        // Loading JSON Data
        let url = "https://raw.githubusercontent.com/ghosh/uiGradients/master/gradients.json"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, _) in
            guard let jsonData = data else { return }
            
            do {
                // decoding JSON
                let colors = try JSONDecoder().decode([Gradient].self, from: jsonData)
                
                self.gradients = colors
                self.filtered = colors
            } catch {
                print(error)
            }
        }
        .resume()
    }
    
    // Converting HEX number to UIColor
    func HEXtoRGB(colors: [String]) -> [Color] {
        var colors1: [Color] = []
        
        for color in colors {
            // removing hash #
            var trimmed = color.trimmingCharacters(in: .whitespaces).uppercased()
            
            trimmed.remove(at: trimmed.startIndex)
            
            var hexValue: UInt64 = 0
            Scanner(string: trimmed).scanHexInt64(&hexValue)
            
            let r = CGFloat((hexValue & 0x00FF0000) >> 16) / 255
            let g = CGFloat((hexValue & 0x0000FF00) >> 8) / 255
            let b = CGFloat(hexValue & 0x000000FF) / 255
            
            colors1.append(Color(UIColor(red: r, green: g, blue: b, alpha: 1.0)))
        }
        
        return colors1
    }
    
    func searchColor() {
        // filtering
        let query = search.lowercased()
        
        // using bg thread to reduce Main UI usage
        DispatchQueue.global(qos: .background).async {
            let filter = gradients.filter { gradient -> Bool in
                if gradient.name.lowercased().contains(query) {
                    return true
                } else {
                    return false
                }
            }
            
            // Refreshing View
            DispatchQueue.main.async {
                withAnimation(.spring()) {
                    self.filtered = filter
                }
            }
        }
    }
}

struct Gradient: Decodable {
    var name: String
    var colors: [String]
}

struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .bottomLeft], cornerRadii: CGSize(width: 55, height: 55))
        
        return Path(path.cgPath)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
