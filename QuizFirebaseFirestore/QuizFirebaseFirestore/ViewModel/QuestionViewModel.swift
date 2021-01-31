//
//  QuestionViewModel.swift
//  QuizFirebaseFirestore
//
//  Created by Ginger on 31/01/2021.
//

import SwiftUI
import Firebase

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    func getQuestions(set: String) {
        // since we are having only one set in Firestore, so we are going to fetch that one only
        // you can add round 2, 3, etc.. into Firestore and can be fetched
        let db = Firestore.firestore()
        
        // change this to set
        db.collection("Round_1").getDocuments { (snapshot, err) in
            
            guard let data = snapshot else { return }
            
            DispatchQueue.main.async {
                self.questions = data.documents.compactMap({ (doc) -> Question? in
                    return try? doc.data(as: Question.self)
                })
                print(self.questions)
            }
            
        }
    }
}
