//
//  AlertView.swift
//  PhoneAuthFirebase
//
//  Created by Ginger on 23/01/2021.
//

import SwiftUI

struct AlertView: View {
    var msg: String
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(msg)
                .foregroundColor(.gray)
            
            Button(action: {
                // closing popup
                show.toggle()
            }) {
                Text("Close")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color("yellow"))
                    .cornerRadius(15)
            }
            
            // centering the button
            .frame(alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        
        // background dim
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
    }
}
