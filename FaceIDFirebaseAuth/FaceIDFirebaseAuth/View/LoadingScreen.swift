//
//  LoadingScreen.swift
//  FaceIDFirebaseAuth
//
//  Created by Ginger on 08/01/2021.
//

import SwiftUI

struct LoadingScreen: View {
    @State var animate = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all, edges: .all)
            
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color("green"), lineWidth: 10)
                .frame(width: 60, height: 60)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .padding(40)
                .background(Color.white)
                .cornerRadius(15)
        }
        .onAppear(perform: {
            withAnimation(Animation.linear.speed(0.6).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        })
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
