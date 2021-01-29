//
//  ContentView.swift
//  LottieSplashScreen
//
//  Created by Ginger on 29/01/2021.
//

import SwiftUI
import Lottie

struct ContentView: View {
    var body: some View {
        SplashScreen()
    }
}

struct SplashScreen: View {
    @State var show = false
    
    // Login Details
    @State var phNo = ""
    
    var body: some View {
        VStack {
            ZStack {
                Color("bg")
                    .ignoresSafeArea()
                
                VStack {
                    AnimatedView(show: $show)
                    // default Frame
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .padding(.bottom, -35)
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 10, content: {
                                Text("Login")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                
                                Text("Enter your phone number to continue")
                                    .foregroundColor(.gray)
                            })
                            
                            Spacer(minLength: 15)
                        }
                        
                        VStack {
                            HStack(spacing: 15) {
                                Text("+1")
                                    .foregroundColor(.black)
                                
                                Rectangle()
                                    .fill(Color("bg"))
                                    .frame(width: 1, height: 18)
                                
                                TextField("", text: $phNo)
                            }
                            
                            Divider()
                                .background(Color("bg"))
                        }
                        .padding(.vertical)
                        
                        Button(action: {}, label: {
                            Text("Verify Your Number")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(width: UIScreen.main.bounds.width - 60)
                                .background(Color("bg"))
                                .clipShape(Capsule())
                        })
                        
                        HStack {
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 1)
                            
                            Text("OR")
                                .fontWeight(.bold)
                                .foregroundColor(Color.black.opacity(0.3))
                            
                            Rectangle()
                                .fill(Color.black.opacity(0.3))
                                .frame(height: 1)
                        }
                        .padding(.vertical, 10)
                        
                        HStack(spacing: 20) {
                            Button(action: {}, label: {
                                HStack(spacing: 10) {
                                    Image("fb")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                    
                                    Text("Facebook")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 10)
                                .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                .background(Color("fb"))
                                .clipShape(Capsule())
                            })
                            
                            Button(action: {}, label: {
                                HStack(spacing: 10) {
                                    Image("google")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                    
                                    Text("Google")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                .padding(.vertical, 10)
                                .frame(width: (UIScreen.main.bounds.width - 80) / 2)
                                .background(Color("google"))
                                .clipShape(Capsule())
                            })
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding()
                    
                    // Bottom to up transition
                    
                    // we can acheive this by frame property
                    .frame(height: show ? nil : 0)
                    .opacity(show ? 1 : 0)
                }
            }
        }
    }
}

struct AnimatedView: UIViewRepresentable {
    @Binding var show: Bool
    
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: "splash", bundle: Bundle.main)
        
        // on Complete
        view.play { status in
            if status {
                // toggling View
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                    show.toggle()
                }
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: AnimationView, context: Context) {
        //
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
