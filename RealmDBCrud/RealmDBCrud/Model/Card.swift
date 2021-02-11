//
//  Card.swift
//  RealmDBCrud
//
//  Created by Ginger on 11/02/2021.
//

import SwiftUI
import RealmSwift

// Creating Realm Object

class Card: Object, Identifiable {
    @objc dynamic var id: Date = Date()
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
}
