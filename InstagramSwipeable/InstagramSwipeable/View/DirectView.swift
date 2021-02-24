//
//  DirectView.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

struct DirectView: View {
    @Binding var offset: CGFloat
    @State var search = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button(action: {
                    offset = rect.width
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .bold))
                        
                        Text("Direct")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "video")
                        .font(.title)
                }
                
                Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                }
            }
            .foregroundColor(.primary)
            .padding()
            
            ScrollView {
                
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $search)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(12)
                    
                    ForEach(posts) { post in
                        HStack(spacing: 15) {
                            Image(post.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            
                            Text(post.user)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "camera")
                                    .font(.title)
                            }
                            .foregroundColor(.gray)
                        }
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, edges?.top ?? 15)
        .padding(.bottom, edges?.bottom ?? 15)
    }
}
