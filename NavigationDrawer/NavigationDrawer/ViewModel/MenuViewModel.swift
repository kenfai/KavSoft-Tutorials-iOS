//
//  MenuViewModel.swift
//  NavigationDrawer
//
//  Created by Ginger on 21/02/2021.
//

import SwiftUI

// Menu Data
class MenuViewModel: ObservableObject {
    // Default
    @Published var selectedMenu = "Catalogue"
    
    // Show
    @Published var showDrawer = false
}
