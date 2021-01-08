//
//  Home.swift
//  FaceIDFirebaseAuth
//
//  Created by Ginger on 08/01/2021.
//

import SwiftUI
import Firebase

struct Home: View {
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text("User Logged In As \(Auth.auth().currentUser?.email ?? "")")
            
            Text("User UID \(Auth.auth().currentUser?.uid ?? "")")
            
            Button(action: {
                try! Auth.auth().signOut()
                withAnimation {
                    logged = false
                }
            }) {
                Text("LogOut")
                    .fontWeight(.heavy)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
