//
//  FilteredImage.swift
//  FiltersCoreImage
//
//  Created by Ginger on 04/01/2021.
//

import SwiftUI
import CoreImage

struct FilteredImage: Identifiable {
    var id = UUID().uuidString
    var image: UIImage
    var filter: CIFilter
    var isEditable: Bool
}
