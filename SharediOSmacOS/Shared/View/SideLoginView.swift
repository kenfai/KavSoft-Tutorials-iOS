//
//  SideLoginView.swift
//  SharediOSmacOS (iOS)
//
//  Created by Ginger on 13/02/2021.
//

import SwiftUI

struct SideLoginView: View {
    @EnvironmentObject var homeData: LoginViewModel

    var body: some View {
        ZStack {
            if homeData.gotoRegister {
                Register()
                // smooth macOS Animation
                    .transition(homeData.ismacOS ? .move(edge: .trailing) : .scale)
            } else {
                Login()
                    // Scaling Effect having problems in macOS
                    .transition(homeData.ismacOS ? .move(edge: .trailing) : .scale)
            }
        }
        .overlay(
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.white)
                    //.renderingMode(.template)
                    //.resizable()
                    .modifier(LoginButtonModifier())
            })
            .buttonStyle(PlainButtonStyle())
            .offset(x: -65, y: -10)
            , alignment: .bottomTrailing
        )
    }
}

struct SideLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SideLoginView()
    }
}
