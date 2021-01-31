//
//  Question.swift
//  QuizFirebaseFirestore
//
//  Created by Ginger on 31/01/2021.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable {
    // it will fetch doc ID
    @DocumentID var id: String?
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var answer: String?
    
    // for checking
    var isSubmitted = false
    var completed = false
    
    // declare the coding keys with respect to Firebase Firestore Key
    enum CodingKeys: String, CodingKey {
        case question
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case answer
    }
}
