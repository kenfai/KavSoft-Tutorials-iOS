//
//  User.swift
//  SearchBarPagination
//
//  Created by Ginger on 11/01/2021.
//

import SwiftUI

struct User: Decodable, Hashable {
    var node_id: String
    var login: String
    var avatar_url: String
}

struct Results: Decodable {
    var items: [User]
}
