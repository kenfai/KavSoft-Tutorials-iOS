//
//  ContentView.swift
//  LottieAnimation
//
//  Created by Ginger on 19/01/2021.
//

import SwiftUI
import Lottie

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    var body: some View {
        NavigationView {
            NavigationLink(
                destination: CartPage(),
                label: {
                    Label(
                        title: { Text("Goto Cart Page")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        },
                        icon: { Image(systemName: "cart")
                            .font(.system(size: 26, weight: .bold))
                            .foregroundColor(Color("orange"))
                        })
                })
                .navigationTitle("Home")
        }
    }
}

struct CartPage: View {
    @State var black = Color.primary.opacity(0.7)
    @Environment(\.presentationMode) var present
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    present.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(black)
                })
                
                Spacer()
            }
            .padding()
            
            LottieView(animationName: "emptycart")
                .frame(height: UIScreen.main.bounds.height / 2)
            
            Text("Your Cart is Empty")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(black)
            
            Text("Load up that basket with some yummy fruits")
                .fontWeight(.bold)
                .foregroundColor(black)
                .padding(.top, 5)
            
            Spacer(minLength: 0)
            
            Button(action: {}, label: {
                Text("Start Shopping")
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(Color("orange"))
                    .cornerRadius(4)
            })
            .padding(.bottom, 10)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// Lottie Animation View
struct LottieView: UIViewRepresentable {
    var animationName: String
    
    func makeUIView(context: Context) -> AnimationView {
        let view = AnimationView(name: animationName, bundle: Bundle.main)
        
        // there are lots of other options available for customization
        // Play and Loop option:
        view.loopMode = .loop
        
        view.play()
        
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
