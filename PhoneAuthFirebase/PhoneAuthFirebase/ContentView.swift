//
//  ContentView.swift
//  PhoneAuthFirebase
//
//  Created by Ginger on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var status = false
    var body: some View {
        ZStack {
            if status {
                Home()
            } else {
                NavigationView {
                    Login()
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
