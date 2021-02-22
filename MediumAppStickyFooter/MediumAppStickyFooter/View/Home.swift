//
//  Home.swift
//  MediumAppStickyFooter
//
//  Created by Ginger on 22/02/2021.
//

import SwiftUI

struct Home: View {
    // Splits Array of Article into Two
    var split_Article: [[String]] {
        
        let Mid = articleParagraphs.count / 2
        
        var splitArray1: [String] = []
        var splitArray2: [String] = []
        
        for index in 0..<Mid - 1 {
            splitArray1.append(articleParagraphs[index])
        }
        
        for index in Mid..<articleParagraphs.count {
            splitArray2.append(articleParagraphs[index])
        }
        
        return [splitArray1, splitArray2]
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 15, pinnedViews: [.sectionFooters]) {
                
                Section(footer: FooterView()) {
                    Text("Recently, as I was clearing the dinner table..")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Profile View
                    HStack(spacing: 15) {
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 55, height: 55)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("iJustine")
                                .foregroundColor(.green)
                            
                            Text("21 Mar 2020 . 4 Min Read")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Article Paragraphs
                    
                    // Splitting Article to Insert Image in mid-of Article
                    ForEach(split_Article[0], id: \.self) { article in
                        
                        Text(article)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                    
                    // Article Image
                    Image("article_img1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    // Remaining Article
                    ForEach(split_Article[1], id: \.self) { article in
                        
                        Text(article)
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                            .padding(.top, 10)
                    }
                    
                    // Article End Image
                    Image("article_img2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                
                // Featured Content
                Text("Featured")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Feature Rows
                FeatureContent()
                    .padding(.bottom)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
