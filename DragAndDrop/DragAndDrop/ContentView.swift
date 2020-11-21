//
//  ContentView.swift
//  DragAndDrop
//
//  Created by Ginger on 21/11/2020.
//

import SwiftUI
import MobileCoreServices

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Drag Images")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Home: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    @ObservedObject var delegate = ImgData()
    
    var body: some View {
        VStack(spacing: 15) {
            // Total Image Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    
                    ForEach(delegate.totalImage) { image in
                        Image(image.image)
                            .resizable()
                            .frame(height: 150)
                            .cornerRadius(15)
                        
                        // Drag Drop
                            .onDrag {
                                // provide data
                                NSItemProvider(item: .some(URL(string: image.image)! as NSSecureCoding), typeIdentifier: String(kUTTypeURL))
                            }
                    }
                }
                .padding(.all)
            }
            // Drop Area
            ZStack {
                if delegate.selectedImages.isEmpty {
                    Text("Drop Images Here")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        // image is unique so assigning it as id
                        ForEach(delegate.selectedImages, id: \.image) { image in
                            if image.image != "" {
                                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                                    Image(image.image)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(15)
                                 
                                    // Remove Button
                                    Button(action: {
                                        // removing image from selected List
                                        withAnimation(.easeOut) {
                                            self.delegate.selectedImages.removeAll { (check) -> Bool in
                                                if check.image == image.image {
                                                    return true
                                                } else {
                                                    return false
                                                }
                                            }
                                        }
                                    }) {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.black)
                                            .clipShape(Circle())
                                    }
                                    .offset(x: 10.0, y: -10.0)
                                }
                                .padding(.top)
                                .padding(.trailing, 10)
                            }
                        }
                        
                        Spacer(minLength: 0)
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top, 10)
            // if no images means default 100 height
            .frame(height: delegate.selectedImages.isEmpty ? 100 : nil)
            // for drop recognization
            .contentShape(Rectangle())
            .background(Color.white)
            // receive provided data
            .onDrop(of: [String(kUTTypeURL)], delegate: delegate)
        }
        .background(Color.black.opacity(0.06))
        .edgesIgnoringSafeArea(.bottom)
    }
}

class ImgData: ObservableObject, DropDelegate {
    @Published var totalImage: [Img] = [
        Img(id: 0, image: "p1"),
        Img(id: 1, image: "p2"),
        Img(id: 2, image: "p3"),
        Img(id: 3, image: "p4"),
        Img(id: 4, image: "p5"),
        Img(id: 5, image: "p6"),
        Img(id: 6, image: "p7"),
        Img(id: 7, image: "p8"),
        Img(id: 8, image: "p9"),
        Img(id: 9, image: "p10"),
        Img(id: 10, image: "p11"),
        Img(id: 11, image: "p12"),
        Img(id: 12, image: "p13"),
        Img(id: 13, image: "p14"),
        Img(id: 14, image: "p15"),
        Img(id: 15, image: "p16"),
        Img(id: 16, image: "p17"),
        Img(id: 17, image: "p18"),
    ]
    
    @Published var selectedImages: [Img] = []
    
    func performDrop(info: DropInfo) -> Bool {
        // adding images to bottom View
        
        for provider in info.itemProviders(for: [String(kUTTypeURL)]) {
            // checking if its available
            if provider.canLoadObject(ofClass: URL.self) {
                print("URL Loaded")
                
                let _ = provider.loadObject(ofClass: URL.self) { (url, err) in
                    print(url!)
                    
                    // adding to selected array
                    // checking the array whether it's already existed
                    let status = self.selectedImages.contains { (check) -> Bool in
                        if check.image == "\(url!)" {
                            return true
                            
                        } else {
                            return false
                        }
                    }
                    
                    // safely append
                    if !status {
                        // adding animation
                        DispatchQueue.main.async {
                            withAnimation(.easeOut) {
                                self.selectedImages.append(Img(id: self.selectedImages.count, image: "\(url!)"))
                            }
                        }
                    }
                }
            } else {
                print("cannot be loaded")
            }
        }
        
        return true
    }
}

struct Img: Identifiable {
    var id: Int
    var image: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
