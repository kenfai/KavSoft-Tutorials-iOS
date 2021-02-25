//
//  Asset.swift
//  SignalMessengerImageVideoPicker
//
//  Created by Ginger on 25/02/2021.
//

import SwiftUI
import Photos

struct Asset: Identifiable {
    var id = UUID().uuidString
    var asset: PHAsset
    var image: UIImage
}
