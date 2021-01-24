//
//  JSONViewModel.swift
//  JSONToCoreData
//
//  Created by Ginger on 24/01/2021.
//

import SwiftUI
import CoreData

class JSONViewModel: ObservableObject {
    @Published var videos: [VideoModel] = []
    
    // saving JSON TO Core Data
    func saveData(context: NSManagedObjectContext) {
        videos.forEach { data in
            let entity = Video(context: context)
            entity.titleName = data.titleName
            entity.detail = data.detail
            entity.link = data.link
            entity.imageLink = data.imageLink
        }
        
        // savingall pending data at once
        do {
            try context.save()
            print("success")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData(context: NSManagedObjectContext) {
        let url = "https://kavsoft.dev/api/v1/videos"
        
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("swiftui2.0", forHTTPHeaderField: "field")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, res, _ in
            guard let jsonData = data else { return }
            
            // checking for any internal api error
            let response = res as! HTTPURLResponse
            
            // checking by status code
            if response.statusCode == 404 {
                print("error API Error")
                return
            }
            
            // fetching JSON Data
            do {
                let videos = try JSONDecoder().decode([VideoModel].self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.videos = videos
                    
                    self.saveData(context: context)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}

