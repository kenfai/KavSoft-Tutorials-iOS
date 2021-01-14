//
//  Home.swift
//  ViewBuilder
//
//  Created by Ginger on 14/01/2021.
//

import SwiftUI

struct Home: View {
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 1)
    @StateObject var ModelData = HomeViewModel()
    @State var width = (UIScreen.main.bounds.width - 45) / 2
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(ModelData.items, id: \.album_name) { album in
                    // Build Custom View using ViewBuilder
                    
                    // Our Content goes here
                    CustomView(columns: $columns) {
                        Image(album.album_cover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: columns.count == 1 ? 65 : width, height: columns.count == 1 ? 65 : width)
                            .cornerRadius(15)
                    } detail: {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(album.album_name)
                                .fontWeight(.heavy)
                            
                            Text(album.album_author)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .toolbar {
            Button(action: {
                withAnimation {
                    if columns.count == 2 {
                        columns.removeLast()
                    } else {
                        columns.append(GridItem(.flexible(), spacing: 15))
                    }
                }
            }) {
                Image(systemName: columns.count == 1 ? "rectangle.3.offgrid" : "rectangle.grid.1x2")
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
