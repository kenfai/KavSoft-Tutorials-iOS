//
//  JSONViewModel.swift
//  InstagramExploreLayout
//
//  Created by Ginger on 09/02/2021.
//

import SwiftUI

class JSONViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    
    // Search
    @Published var search = ""
    
    // Compositional Layout Array
    @Published var compositionalArray: [[Card]] = []
    
    init() {
        fetchJSON()
    }
    
    func fetchJSON() {
        
        let url = "https://picsum.photos/v2/list?page=2&limit=100"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let json = data else { return }
            
            let jsonValues = try? JSONDecoder().decode([Card].self, from: json)
            
            guard let cards = jsonValues else { return }
            
            DispatchQueue.main.async {
                self.cards = cards
                if !self.cards.isEmpty {
                    self.setCompositionalLayout()
                }
            }
        }
        .resume()
    }
    
    func setCompositionalLayout() {
        var currentArrayCards: [Card] = []
        
        cards.forEach { card in
            
            currentArrayCards.append(card)
            
            if currentArrayCards.count == 3 {
                
                // appending to Main Array
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
            
            // if not 3 or Even no. of Cards
            if currentArrayCards.count != 3 && card.id == cards.last!.id {
                
                // appending to Main Array
                compositionalArray.append(currentArrayCards)
                currentArrayCards.removeAll()
            }
        }
    }
}
