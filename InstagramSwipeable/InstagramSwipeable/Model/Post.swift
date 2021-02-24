//
//  Post.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

// Post Model and Data

struct Post: Identifiable {
    
    var id = UUID().uuidString
    var user: String
    var profile: String
    var postImage: String
    var postTitle: String
    var time: String
}

var posts = [
    Post(user: "iJustine", profile: "p1", postImage: "post2", postTitle: "iPhone 11......", time: "58 min ago"),
    Post(user: "Capcom", profile: "p2", postImage: "post1", postTitle: "New Resident Evil Village...", time: "24 min ago"),
    Post(user: "Apple", profile: "p3", postImage: "post3", postTitle: "WWDC 2020 @ June 22", time: "1 hr ago"),
    Post(user: "Catherine", profile: "p4", postImage: "post4", postTitle: "Nice Day :)", time: "28 min ago"),
    Post(user: "UnBoxing", profile: "p5", postImage: "post5", postTitle: "New MacBook Pro Unboxing", time: "2 min ago"),
]
