//
//  LoginViewModel.swift
//  SharediOSmacOS (iOS)
//
//  Created by Ginger on 13/02/2021.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    // Register
    @Published var reEnter = ""
    
    // For goto registration Page
    @Published var gotoRegister = false
    
    // macOS data
    var screen: CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        
        return NSScreen.main!.visibleFrame
        #endif
    }
    
    // Detecting for macOS
    @Published var ismacOS = false
    
    init() {
        #if !os(iOS)
        self.ismacOS = true
        #endif
    }
    
    // Clearing data when going to Login / Register Page
    func clearData() {
        email = ""
        password = ""
        reEnter = ""
    }
}
