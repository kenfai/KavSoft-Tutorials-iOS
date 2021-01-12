//
//  Register.swift
//  LoginViewModifier
//
//  Created by Ginger on 12/01/2021.
//

import SwiftUI

struct Register: View {
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var number = ""
    
    @Binding var show: Bool
    
    @Namespace var animation
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button(action: {
                        show.toggle()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
                .padding(.leading)
                
                HStack {
                    Text("Create Account")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.leading)
                
                CustomTextField(image: "person", title: "FULL NAME", value: $name, animation: animation)
                
                CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    .padding(.top, 5)
                
                CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                    .padding(.top, 5)
                
                CustomTextField(image: "phone.fill", title: "PHONE NUMBER", value: $number, animation: animation)
                    .padding(.top, 5)
                
                HStack {
                    Spacer()
                    
                    Button(action: {}) {
                        HStack(spacing: 10) {
                            Text("SIGN UP")
                                .fontWeight(.heavy)
                            
                            Image(systemName: "arrow.right")
                                .font(.title2)
                        }
                        .modifier(CustomButtonModifier())
                    }
                }
                .padding()
                .padding(.top)
                .padding(.trailing)
                
                HStack {
                    Text("Already have an account? ")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        show.toggle()
                    }) {
                        Text("sign in")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("yellow"))
                    }
                }
                .padding()
                .padding(.top, 10)
                
                Spacer(minLength: 0)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}
