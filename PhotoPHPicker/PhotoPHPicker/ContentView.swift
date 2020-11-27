//
//  ContentView.swift
//  PhotoPHPicker
//
//  Created by Ginger on 27/11/2020.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var images: [UIImage] = []
    @State var picker = false
    
    var body: some View {
        VStack {
            if !images.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(images, id: \.self) { img in
                            Image(uiImage: img)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                                .cornerRadius(20)
                        }
                    }
                }
            } else {
                Button(action: {
                    picker.toggle()
                }) {
                    Text("Pick Images")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 35)
                        .background(Color.blue)
                        .clipShape(Capsule())
                }
            }
        }
        .sheet(isPresented: $picker) {
            ImagePicker(images: $images, picker: $picker)
        }
    }
}

// New Image Picker API
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(imagePicker: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        // videos can be used too
        config.filter = .images
        // 0 = multiple selections
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        // assigning delegate
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        init(imagePicker: ImagePicker) {
            parent = imagePicker
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            // closing picker
            parent.picker.toggle()
            
            for img in results {
                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    img.itemProvider.loadObject(ofClass: UIImage.self) { image, err in
                        guard let image1 = image else {
                            print(err!)
                            return
                        }
                        
                        // appending image
                        self.parent.images.append(image1 as! UIImage)
                    }
                } else {
                    // cannot be loaded
                    print("Error: image cannot be loaded")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
