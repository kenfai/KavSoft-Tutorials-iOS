//
//  Post.swift
//  FacebookReaction
//
//  Created by Ginger on 09/01/2021.
//

import SwiftUI

struct Post: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var time: String
    var liked: Bool
    var reaction: String
    var show = false
}
