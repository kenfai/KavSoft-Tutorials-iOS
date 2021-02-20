//
//  TimerBackgroundApp.swift
//  TimerBackground
//
//  Created by Ginger on 20/02/2021.
//

import SwiftUI

@main
struct TimerBackgroundApp: App {
    @StateObject var data = TimerData()
    
    // using ScenePhase for Scene Data
    @Environment(\.scenePhase) var scene
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(data)
        }
        .onChange(of: scene) { newScene in
            
            // Only for Real device
            #if !targetEnvironment(simulator)
            
            if newScene == .background {
                // Storing Time
                data.leftTime = Date()
                print("bg")
            }
            
            if newScene == .active && data.leftTime != nil {
                // when it enter again, checking the difference
                let diff = Date().timeIntervalSince(data.leftTime)
                
                let currentTime = data.selectedTime - Int(diff)
                print(currentTime)
                if currentTime >= 0 {
                    withAnimation(.default) {
                        data.selectedTime = currentTime
                    }
                } else {
                    // resetting View
                    data.resetView()
                }
            }
            
            #endif
        }
    }
}
