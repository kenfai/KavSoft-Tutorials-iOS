//
//  Login.swift
//  LoginViewModifier
//
//  Created by Ginger on 12/01/2021.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var password = ""
    @Namespace var animation
    
    @State var show = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Login")
                        .font(.system(size: 40, weight: .heavy))
                        // For Dark Mode Adoption
                        .foregroundColor(.primary)
                    
                    Text("Please sign in to continue")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.leading)
            
            CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
            
            CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                .padding(.top, 5)
            
            HStack {
                Spacer(minLength: 0)
            
                VStack(alignment: .trailing, spacing: 20) {
                    Button(action: {}) {
                        Text("FORGOT")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("yellow"))
                    }
                    
                    Button(action: {}) {
                        HStack(spacing: 10) {
                            Text("LOGIN")
                                .fontWeight(.heavy)
                            
                            Image(systemName: "arrow.right")
                                .font(.title2)
                        }
                        .modifier(CustomButtonModifier())
                    }
                }
            }
            .padding()
            .padding(.top, 10)
            .padding(.leading)
            
            HStack(spacing: 0) {
                Text("Don't have an account? ")
                    .fontWeight(.heavy)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: Register(show: $show), isActive: $show) {
                    Text("sign up")
                        .fontWeight(.heavy)
                        .foregroundColor(Color("yellow"))
                }
            }
            .padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
