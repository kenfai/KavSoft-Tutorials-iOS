//
//  HomeViewModel.swift
//  FiltersCoreImage
//
//  Created by Ginger on 04/01/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class HomeViewModel: ObservableObject {
    @Published var imagePicker = false
    @Published var imageData = Data(count: 0)

    @Published var allImages: [FilteredImage] = []
    
    // Main Editing Image
    @Published var mainView: FilteredImage!
    
    // Slider for Intensity and Radius
    // Since we didn't set while reading image
    // so all will be full value
    @Published var value: CGFloat = 1.0
    
    // Loading FilterOption Whenever Image is selected
    
    // Use your own filters
    let filters: [CIFilter] = [
        CIFilter.sepiaTone(),
        CIFilter.comicEffect(),
        CIFilter.colorInvert(),
        CIFilter.photoEffectFade(),
        CIFilter.colorMonochrome(),
        CIFilter.photoEffectChrome(),
        CIFilter.gaussianBlur(),
        CIFilter.bloom()
    ]
    
    func loadFilter() {
        let context = CIContext()
        
        filters.forEach { filter in
            // To Avoid Lag, do it in background
            DispatchQueue.global(qos: .userInteractive).async {
                // loading Image Into filter
                let CiImage = CIImage(data: self.imageData)
                
                filter.setValue(CiImage!, forKey: kCIInputImageKey)
                
                // retrieving Image
                guard let newImage = filter.outputImage else { return }
                
                // creating UIImage
                let cgimage = context.createCGImage(newImage, from: newImage.extent)
                
                let isEditable = filter.inputKeys.count > 1
                
                let filteredData = FilteredImage(image: UIImage(cgImage: cgimage!), filter: filter, isEditable: isEditable)
                
                DispatchQueue.main.async {
                    self.allImages.append(filteredData)
                    
                    // default is First Filter
                    if self.mainView == nil { self.mainView = self.allImages.first }
                }
            }
        }
    }
    
    func updateEffect() {
        let context = CIContext()
        
        DispatchQueue.global(qos: .userInteractive).async {
            // loading Image Into filter
            let CiImage = CIImage(data: self.imageData)
            
            let filter = self.mainView.filter
            
            filter.setValue(CiImage!, forKey: kCIInputImageKey)
            
            // retrieving Image
            // there are a lot of custom options available
            // I'm only using radius and intensity
            // use your own based on your usage
            if filter.inputKeys.contains("inputRadius") {
                // radius you can give up to 180
                // im using only 10
                filter.setValue(self.value * 10, forKey: kCIInputRadiusKey)
            }
            if filter.inputKeys.contains("inputIntensity") {
                filter.setValue(self.value, forKey: kCIInputIntensityKey)
            }
            
            guard let newImage = filter.outputImage else { return }
            
            // creating UIImage
            let cgimage = context.createCGImage(newImage, from: newImage.extent)
            
            DispatchQueue.main.async {
                // updating View
                self.mainView.image = UIImage(cgImage: cgimage!)
            }
        }
    }
}
