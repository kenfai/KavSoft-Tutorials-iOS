//
//  Home.swift
//  JSONToCoreData
//
//  Created by Ginger on 24/01/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var jsonModel = JSONViewModel()
    @Environment(\.managedObjectContext) var context
    
    // Fetching Data from CoreData
    @FetchRequest(entity: Video.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Video.titleName, ascending: true)]) var results: FetchedResults<Video>
    
    var body: some View {
        VStack {
            // Checking if CoreData exists
            if results.isEmpty {
                if jsonModel.videos.isEmpty {
                    ProgressView()
                        // fetching data
                        .onAppear(perform: {
                            jsonModel.fetchData(context: context)
                        })
                    // when array is clear indicator appearas
                    // as a result data is fetched again
                } else {
                    List(jsonModel.videos, id: \.self) { video in
                        // Display fetched JSON Data
                        CardView(video: video)
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            } else {
                List(results, id: \.self) { video in
                    // Display fetched JSON Data
                    CardView(fetchedData: video)
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
        .navigationTitle(!results.isEmpty ? "Fetched CoreData" : "Fetched JSON")
        .navigationBarTitleDisplayMode(.inline)
        // refresh Button
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // by clearing array data
                    // it will auto fetch all data again
                    
                    // Clearing Data in CoreData
                    do {
                        results.forEach { video in
                            context.delete(video)
                        }
                        
                        try context.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    jsonModel.videos.removeAll()
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                        .font(.title)
                })
            }
        }
    }
}
