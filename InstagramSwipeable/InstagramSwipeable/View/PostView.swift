//
//  PostView.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

struct PostView: View {
    @Binding var offset: CGFloat
    var body: some View {
        ZStack {
            // CameraView()
            // Will be Implemented
            Color.black
            
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        offset = rect.width
                    }) {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "photo")
                        .font(.title)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding(.top, edges?.top ?? 15)
            .padding(.bottom, edges?.bottom)
        }
    }
}
