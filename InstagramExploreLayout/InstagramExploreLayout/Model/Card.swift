//
//  Card.swift
//  InstagramExploreLayout
//
//  Created by Ginger on 09/02/2021.
//

import SwiftUI

struct Card: Identifiable, Decodable, Hashable {
    
    var id: String
    var download_url: String
    var author: String
}
