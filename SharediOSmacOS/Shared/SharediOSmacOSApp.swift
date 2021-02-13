//
//  SharediOSmacOSApp.swift
//  Shared
//
//  Created by Ginger on 13/02/2021.
//

import SwiftUI

@main
struct SharediOSmacOSApp: App {
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        #else
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}

// Checkong only for macOS and Disabling Focus Ring
#if !os(iOS)

extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}
#endif
