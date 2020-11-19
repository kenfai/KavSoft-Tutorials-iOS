//
//  ContentView.swift
//  LoginCustomCurvesShape
//
//  Created by Ginger on 19/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
    }
}

struct Home: View {
    @State var signUp = false
    @State var user = ""
    @State var pass = ""
    @State var rePass = ""
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            ZStack {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom)) {
                    Color("Color")
                        .clipShape(CShape())
                    
                    // adding another Curve
                    
                    Path { path in
                        // 120 = 80(total radius of curve) + 40(for center)
                        path.addArc(center: CGPoint(x: UIScreen.main.bounds.width - 120, y: UIScreen.main.bounds.height - 50), radius: 40, startAngle: .zero, endAngle: Angle(degrees: 180), clockwise: true)
                        
                    }
                    .fill(Color.white)
                    
                    // adding Buttons
                    Button(action: {
                        withAnimation(.easeIn) {
                            signUp = false
                        }
                    }) {
                        Image(systemName: signUp ? "xmark" : "person.fill")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color("Color"))
                    }
                    .offset(x: -110, y: -50)
                    // disabling Button When it's not in used
                    .disabled(!signUp)
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            signUp = true
                        }
                    }) {
                        Image(systemName: signUp ? "person.badge.plus.fill" : "xmark")
                            .font(.system(size: signUp ? 26 : 25, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: -30, y: -40)
                    .disabled(signUp)
                }
                
                // Login View
                VStack(alignment: .leading, spacing: 25) {
                    Text("Login")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text("Username")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    VStack {
                        TextField("Username", text: $user)
                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    VStack {
                        SecureField("Password", text: $pass)
                            .textContentType(.newPassword)

                        
                        Divider()
                            .background(Color.white.opacity(0.5))
                    }
                    
                    HStack {
                        Spacer()
                        
                        // Login Button
                        Button(action: {}) {
                            Text("Login")
                                .fontWeight(.bold)
                                .foregroundColor(Color("Color"))
                                .padding(.vertical)
                                .padding(.horizontal, 45)
                                .background(Color.white)
                                .clipShape(Capsule())
                        }
                        
                        Spacer()
                    }
                    .padding(.top)
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 25)
                .padding()
            }
            // Moving View Up
            // Adjusting View For iPhone 8-like model
            .offset(y: signUp ? -UIScreen.main.bounds.height + (UIScreen.main.bounds.height < 750 ? 100 : 130) : 0)
            .zIndex(1)
            // Moving View to the Front in Stack
            
            // Signup View
            VStack(alignment: .leading, spacing: 25) {
                Text("Sign Up")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(Color("Color"))
                
                Text("Username")
                    .foregroundColor(Color("Color"))
                    .padding(.top, 10)
                
                VStack {
                    TextField("Username", text: $user)
                    
                    Divider()
                        .background(Color("Color").opacity(0.5))
                }
                
                Text("Password")
                    .foregroundColor(Color("Color"))
                    .padding(.top, 10)
                
                VStack {
                    SecureField("Password", text: $pass)
                        .textContentType(.newPassword)
                    
                    Divider()
                        .background(Color("Color").opacity(0.5))
                }
                
                Text("Re-Enter")
                    .foregroundColor(Color("Color"))
                    .padding(.top, 10)
                
                // use separate TextField Bindings here
                VStack {
                    SecureField("Re-Enter", text: $rePass)
                        .textContentType(.newPassword)
                    
                    Divider()
                        .background(Color("Color").opacity(0.5))
                }
                
                HStack {
                    Spacer()
                    
                    // Login Button
                    Button(action: {}) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal, 45)
                            .background(Color("Color"))
                            .clipShape(Capsule())
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                Spacer(minLength: 0)
            }
            .padding(.top, (UIApplication.shared.windows.first?.safeAreaInsets.top)! + 50)
            .padding()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        // changing user Interface Style
        .preferredColorScheme(signUp ? .light : .dark)
    }
}

// custom Shape
struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            // starting from bottom
            path.move(to: CGPoint(x: rect.width, y: rect.height - 50))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height - 50))
            
            // adding curve
            
            // total radius of curve = 80
            path.addArc(center: CGPoint(x: rect.width - 40, y: rect.height - 50), radius: 40, startAngle: .zero, endAngle: Angle(degrees: 180), clockwise: false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
