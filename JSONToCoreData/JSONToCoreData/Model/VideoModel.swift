//
//  VideoModel.swift
//  JSONToCoreData
//
//  Created by Ginger on 24/01/2021.
//

import SwiftUI

struct VideoModel: Decodable, Hashable {
    var titleName: String
    var detail: String
    var imageLink: String
    var link: String
}
