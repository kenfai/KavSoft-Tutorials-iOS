//
//  Home.swift
//  PhoneAuthFirebase
//
//  Created by Ginger on 23/01/2021.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        VStack(spacing: 15) {
            // Home View
            Text("Logged in Successfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button(action: {
                // logging out
                try? Auth.auth().signOut()
                withAnimation {
                    status = false
                }
            }, label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
