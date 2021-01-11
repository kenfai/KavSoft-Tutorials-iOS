//
//  CustomSearchBar.swift
//  SearchBarPagination
//
//  Created by Ginger on 11/01/2021.
//

import SwiftUI

struct CustomSearchBar: View {
    @ObservedObject var searchData: SearchUsers
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                TextField("Search", text: $searchData.query)
                    .autocapitalization(.none)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            
            if !searchData.searchedUser.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        // Safe wrap
                        ForEach(searchData.searchedUser, id: \.self) { user in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(user.login)
                                
                                Divider()
                            }
                            .padding(.horizontal)
                            .onAppear {
                                // stopping search until 3rd page
                                // you can change for your own
                                if user.node_id == searchData.searchedUser.last?.node_id && searchData.page <= 3 {
                                    searchData.page += 1
                                    searchData.find()
                                }
                            }
                        }
                    }
                    .padding(.top)
                }
                .frame(height: 240)
            }
        }
        .background(Color("Color"))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}
