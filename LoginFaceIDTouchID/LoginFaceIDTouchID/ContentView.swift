//
//  ContentView.swift
//  LoginFaceIDTouchID
//
//  Created by Ginger on 31/12/2020.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @AppStorage("status") var logged = false
    
    var body: some View {
        NavigationView {
            if logged {
                Text("Logged In Successfully!")
                    .navigationTitle("Home")
                    .navigationBarHidden(false)
                    .preferredColorScheme(.light)
            } else {
                Home()
                    .preferredColorScheme(.dark)
                    .navigationBarHidden(true)
            }
        }
    }
}

struct Home: View {
    @State var userName = ""
    @State var password = ""
    // when first time user logged in via email store this for future biometric login
    @AppStorage("stored_User") var user = "john@email.com"
    @AppStorage("status") var logged = false
    
    var body: some View {
        VStack {
            Spacer(minLength: 0)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                // Dynamic Frame
                .padding(.horizontal, 35)
                .padding(.vertical)
            
            HStack {
                VStack(alignment: .leading, spacing: 12, content: {
                    Text("Login")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Please sign in to continue")
                        .foregroundColor(Color.white.opacity(0.5))
                })
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading, 15)
            
            HStack {
                Image(systemName: "envelope")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                TextField("EMAIL", text: $userName)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(userName == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            
            HStack {
                Image(systemName: "lock")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 35)
                
                SecureField("PASSWORD", text: $password)
                    .autocapitalization(.none)
            }
            .padding()
            .background(Color.white.opacity(password == "" ? 0 : 0.12))
            .cornerRadius(15)
            .padding(.horizontal)
            .padding(.top)
            
            HStack(spacing: 15) {
                Button(action: {}) {
                    Text("LOGIN")
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 150)
                        .background(Color("green"))
                        .clipShape(Capsule())
                }
                .opacity(userName != "" && password != "" ? 1 : 0.5)
                .disabled(userName != "" && password != "" ? false : true)
                
                if getBioMetricStatus() {
                    Button(action: authenticateUser) {
                        // getting biometrictype
                        Image(systemName: LAContext().biometryType == .faceID ? "faceid" : "touchid")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color("green"))
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.top)
            
            // Forgot Button
            Button(action: {}) {
                Text("Forgot password?")
                    .foregroundColor(Color("green"))
            }
            .padding(.top, 8)
            
            Spacer(minLength: 0)
            
            // Sign up
            HStack(spacing: 5) {
                Text("Don't have an account? ")
                    .foregroundColor(Color.white.opacity(0.6))
                
                Button(action: {}) {
                    Text("Sign Up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("green"))
                }
            }
            .padding(.vertical)
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .animation(.easeOut)
    }
    
    // Getting BioMetricType
    func getBioMetricStatus() -> Bool {
        let scanner = LAContext()
        
        if userName == user && scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: .none) {
            return true
        }
        
        return false
    }
    
    // authenticate User
    func authenticateUser() {
        let scanner = LAContext()
        scanner.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "To Unlock \(userName)") { (status, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            // setting logged status as true
            withAnimation(.easeOut) {
                logged = true
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
