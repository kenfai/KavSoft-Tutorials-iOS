//
//  HomeViewModel.swift
//  CoreDataCRUD
//
//  Created by Ginger on 05/12/2020.
//

import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    
    // For NewData Sheet
    @Published var isNewData = false
    
    // Storing Update Item
    @Published var updateItem: Task!
    
    // Checking and Updating Date
    let calendar = Calendar.current
    
    func checkDate() -> String {
        if calendar.isDateInToday(date) {
            return "Today"
        } else if calendar.isDateInTomorrow(date) {
            return "Tomorrow"
        } else {
            return "Other day"
        }
    }
    
    func updateDate(value: String) {
        if value == "Today" {
            date = Date()
        } else if value == "Tomorrow" {
            date = calendar.date(byAdding: .day, value: 1, to: Date())!
        } else {
            
        }
    }
    
    func writeData(context: NSManagedObjectContext) {
        // Updating Item
        if updateItem != nil {
            // Means Update old data
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            
            // removing updateItem if successful
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            
            return
        }
        
        let newTask = Task(context: context)
        
        newTask.date = date
        newTask.content = content
        
        // saving data
        do {
            try context.save()
            // success means closing View
            isNewData.toggle()
            content = ""
            date = Date()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func EditItem(item: Task) {
        updateItem = item
        date = item.date!
        content = item.content!
        
        isNewData.toggle()
    }
}
