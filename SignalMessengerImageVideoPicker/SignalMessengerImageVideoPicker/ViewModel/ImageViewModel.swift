//
//  ImageViewModel.swift
//  SignalMessengerImageVideoPicker
//
//  Created by Ginger on 25/02/2021.
//

import SwiftUI
import Photos
import AVKit

class ImagePickerViewModel: NSObject, ObservableObject, PHPhotoLibraryChangeObserver {
    
    @Published var showImagePicker = false
    @Published var libraryStatus = LibraryStatus.denied
    
    // List of Fetched Photos
    @Published var fetchedPhotos : [Asset] = []
    
    // To get Updates
    @Published var allPhotos: PHFetchResult<PHAsset>!
    
    // Preview
    @Published var showPreview = false
    @Published var selectedImagePreview: UIImage!
    @Published var selectedVideoPreview: AVAsset!
    
    func openImagePicker() {
        
        // Closing Keyboard if opened
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        // Fetching Image when it needed
        if fetchedPhotos.isEmpty {
            fetchPhotos()
        }
        
        withAnimation {
            showImagePicker.toggle()
        }
        
    }
    
    func setUp() {
        // requesting Permission
        PHPhotoLibrary.requestAuthorization(for: .readWrite) {[self] (status) in
            DispatchQueue.main.async {
                switch status {
                case .denied: libraryStatus = .denied
                case .authorized: libraryStatus = .approved
                case .limited: libraryStatus = .limited
                default: libraryStatus = .denied
                }
            }
        }
        
        // Registering Observer
        PHPhotoLibrary.shared().register(self)
    }
    
    // Listening To Changes
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let _ = allPhotos else { return }
        
        if let updates = changeInstance.changeDetails(for: allPhotos) {
            
            // Getting Updated List
            let updatedPhotos = updates.fetchResultAfterChanges
            
            // There is bug, it's not updating the inserted or removed items
            //print(updates.insertedObjects.count)
            //print(updates.removedObjects.count)
            
            // So we are going to verify All and append only No in the list
            // To avoid of reloading all and RAM usage
            updatedPhotos.enumerateObjects {[self] (asset, index, _) in
                if !allPhotos.contains(asset) {
                    // Getting Image and Appending it to Array
                    
                    getImageFromAsset(asset: asset, size: CGSize(width: 150, height: 150)) { (image) in
                        DispatchQueue.main.async {
                            fetchedPhotos.append(Asset(asset: asset, image: image))
                        }
                    }
                }
            }
            
            // To Remove if Image is removed
            allPhotos.enumerateObjects { (asset, index, _) in
                if !updatedPhotos.contains(asset) {
                    // removing it
                    DispatchQueue.main.async {
                        self.fetchedPhotos.removeAll { (result) -> Bool in
                            return result.asset == asset
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.allPhotos = updatedPhotos
            }
        }
    }
    
    func fetchPhotos() {
        // Featching All Photos
        let options = PHFetchOptions()
        options.sortDescriptors = [
            // Latest to Old
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        options.includeHiddenAssets = false
        
        let fetchResults = PHAsset.fetchAssets(with: options)
        
        allPhotos = fetchResults
        
        fetchResults.enumerateObjects {[self] (asset, index, _) in
            // Getting Image From Asset
            getImageFromAsset(asset: asset, size: CGSize(width: 150, height: 150)) { (image) in
                // Appending it to Array
                
                // Why we storing asset, to get full image for sending
                fetchedPhotos.append(Asset(asset: asset, image: image))
            }
        }
    }
    
    // Using Completion Handlers
    // To receive Objects
    func getImageFromAsset(asset: PHAsset, size: CGSize, completion: @escaping (UIImage) -> ()) {
        
        // To cache  image in memory
        let imageManager = PHCachingImageManager()
        imageManager.allowsCachingHighQualityImages = true
        
        // Your own Properties for Images
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.isSynchronous = false
        
        // To reduce Ram Usage just getting Thumbnail Size of Image
        let size = CGSize(width: 150, height: 150)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: imageOptions) { (image, _) in
            guard let resizedImage = image else { return }
            
            completion(resizedImage)
        }
    }
    
    // Opening Image of Video
    func extractPreviewData(asset: PHAsset) {
        
        let manager = PHCachingImageManager()
        
        if asset.mediaType == .image {
            // Extract Image
            getImageFromAsset(asset: asset, size: PHImageManagerMaximumSize) { (image) in
                DispatchQueue.main.async {
                    self.selectedImagePreview = image
                }
            }
        }
        
        if asset.mediaType == .video {
            // Extract Video
            let videoManager = PHVideoRequestOptions()
            videoManager.deliveryMode = .highQualityFormat
            
            manager.requestAVAsset(forVideo: asset, options: videoManager) { (videoAsset, _, _) in
                guard let videoUrl = videoAsset else { return }
                
                DispatchQueue.main.async {
                    self.selectedVideoPreview = videoUrl
                }
            }
        }
    }
}
