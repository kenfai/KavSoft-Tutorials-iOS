//
//  MsgModel.swift
//  FirebaseGlobalChat
//
//  Created by Ginger on 29/12/2020.
//

import Foundation
import FirebaseFirestoreSwift

// For onChange
struct MsgModel: Codable, Identifiable, Hashable {
    @DocumentID var id: String?
    var msg: String
    var user: String
    var timeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case msg
        case user
        case timeStamp
    }
}
