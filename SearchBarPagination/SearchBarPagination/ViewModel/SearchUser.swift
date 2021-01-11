//
//  SearchUser.swift
//  SearchBarPagination
//
//  Created by Ginger on 11/01/2021.
//

import SwiftUI

class SearchUsers: ObservableObject {
    @Published var searchedUser: [User] = []
    
    // User query
    @Published var query = ""
    
    // Current Result Page
    @Published var page = 1
    
    func find() {
        // removing spaces
        let searchQuery = query.replacingOccurrences(of: " ", with: "%20")
        // you can set your own per_page value
        let url = "https://api.github.com/search/users?q=\(query)&page=\(page)&per_page=10"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            guard let jsonData = data else { return }
            
            do {
                let users = try JSONDecoder().decode(Results.self, from: jsonData)
                
                // appending to searched Users
                DispatchQueue.main.async {
                    // removing data if it is a new request
                    if self.page == 1 {
                        self.searchedUser.removeAll()
                    }
                    
                    // checking if any already loaded is loaded again
                    // ignore already loaded
                    self.searchedUser = Array(Set(self.searchedUser).union(Set(users.items)))
                    //self.searchedUser.append(contentsOf: users.items)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
