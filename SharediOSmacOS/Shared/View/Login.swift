//
//  Login.swift
//  SharediOSmacOS (iOS)
//
//  Created by Ginger on 13/02/2021.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject var homeData: LoginViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18, content: {
            Text("Please Login")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
            
            Label(
                title: {
                    TextField("Enter Email", text: $homeData.email)
                        .textFieldStyle(PlainTextFieldStyle())
                },
                icon: { Image(systemName: "envelope")
                    .frame(width: 30)
                    .foregroundColor(.gray)
                })
            
            Divider()
            
            Label(
                title: {
                    SecureField("Password", text: $homeData.password)
                        .textFieldStyle(PlainTextFieldStyle())
                },
                icon: { Image(systemName: "lock")
                    .frame(width: 30)
                    .foregroundColor(.gray)
                })
                .overlay(
                    Button(action: {}, label: {
                        Image(systemName: "eye")
                            .foregroundColor(.gray)
                    })
                    .buttonStyle(PlainButtonStyle())
                    , alignment: .trailing
                )
            
            Divider()
            
            HStack {
                Button(action: {}, label: {
                    Text("Forgot details?")
                        .font(.caption)
                        .fontWeight(.bold)
                })
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button(action: {
                    // Going to register Page
                    withAnimation {
                        homeData.clearData()
                        homeData.gotoRegister.toggle()
                    }
                }, label: {
                    Text("Create account")
                        .font(.caption)
                        .fontWeight(.bold)
                })
                .buttonStyle(PlainButtonStyle())
            }
            .foregroundColor(.gray)
        })
        .modifier(LoginViewModifier())
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
