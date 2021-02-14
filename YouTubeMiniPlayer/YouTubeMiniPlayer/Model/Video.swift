//
//  Video.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct Video: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
}

var videos = [
    Video(image: "thumb1", title: "Advanced Map Kit Tutorials"),
    Video(image: "thumb2", title: "Realm DB CRUD Operations"),
    Video(image: "thumb3", title: "SwiftUI Complex Chat App UI"),
    Video(image: "thumb4", title: "Animated Sticky Header"),
    Video(image: "thumb5", title: "Shared App for Both macOS and iOS"),
]
