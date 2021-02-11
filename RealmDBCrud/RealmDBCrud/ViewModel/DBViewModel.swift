//
//  DBViewModel.swift
//  RealmDBCrud
//
//  Created by Ginger on 11/02/2021.
//

import SwiftUI
import RealmSwift

class DBViewModel: ObservableObject {
    // Data
    @Published var title = ""
    @Published var detail = ""
    
    @Published var openNewPage = false
    
    // Fetched Data
    @Published var cards: [Card] = []
    
    // Data Updating
    @Published var updateObject: Card?
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        guard let dbRef = try? Realm() else { return }
        
        let results = dbRef.objects(Card.self)
        
        // Displaying results
        self.cards = results.compactMap({ (card) -> Card? in
            return card
        })
    }
    
    // Adding New Data
    func addData(presentation: Binding<PresentationMode>) {
        
        if title == "" || detail == "" { return }
        
        let card = Card()
        card.title = title
        card.detail = detail
        
        // Getting Reference
        guard let dbRef = try? Realm() else { return }
        
        // Writing Data
        try? dbRef.write {
            
            // Checking and Writing Data
            guard let availableObject = updateObject else {
                dbRef.add(card)
                return
            }
            
            availableObject.title = title
            availableObject.detail = detail
        }
        
        // Updating UI
        fetchData()
        
        // Closing View
        presentation.wrappedValue.dismiss()
    }
    
    // Deleting Data
    func deleteData(object: Card) {
        
        guard let dbRef = try? Realm() else { return }
        
        try? dbRef.write {
            dbRef.delete(object)
            
            fetchData()
        }
    }
    
    // Setting and Clearing Data
    func setUpInitialData() {
        // Updating
        guard let updateData = updateObject else { return }
        
        // Checking if it's update object and assigning values
        title = updateData.title
        detail = updateData.detail
    }
    
    func deInitData() {
        updateObject = nil
        title = ""
        detail = ""
    }
}
