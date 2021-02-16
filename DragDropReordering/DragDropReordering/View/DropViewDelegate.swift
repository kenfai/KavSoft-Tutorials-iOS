//
//  DropViewDelegate.swift
//  DragDropReordering
//
//  Created by Ginger on 16/02/2021.
//

import SwiftUI

struct DropViewDelegate: DropDelegate {
    
    var page: Page
    var pageData: PageViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        // Uncomment this, just try
         pageData.currentPage = nil
        return true
    }
    
    // When User Dragged Into New Page
    func dropEntered(info: DropInfo) {
        // Uncomment this to try
        if pageData.currentPage == nil {
            pageData.currentPage = page
        }
        
        // Getting From and To Index
        
        // From Index
        let fromIndex = pageData.urls.firstIndex { (page) -> Bool in
            return page.id == pageData.currentPage?.id
        } ?? 0
        
        // To Index
        let toIndex = pageData.urls.firstIndex { (page) -> Bool in
            return page.id == self.page.id
        } ?? 0
        
        // Safe check if both are not same
        if fromIndex != toIndex {
            // Animation
            withAnimation(.default) {
                // Swapping Data
                let fromPage = pageData.urls[fromIndex]
                pageData.urls[fromIndex] = pageData.urls[toIndex]
                pageData.urls[toIndex] = fromPage
            }
        }
    }
    
    // Setting Action as Move
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
