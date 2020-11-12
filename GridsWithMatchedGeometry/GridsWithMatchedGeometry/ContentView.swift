//
//  ContentView.swift
//  GridsWithMatchedGeometry
//
//  Created by Ginger on 12/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

// Model Data
struct Home: View {
    @State var languages: [Language] = [
        Language(id: 0, lang: "English"),
        Language(id: 1, lang: "Spanish"),
        Language(id: 2, lang: "German"),
        Language(id: 3, lang: "Japanese"),
        Language(id: 4, lang: "Chinese"),
        Language(id: 5, lang: "Korean"),
        Language(id: 6, lang: "Others"),
    ]
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    // creating Namespace
    @Namespace var namespace
    
    @State var selected: [Language] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                if !languages.isEmpty {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(languages) { language in
                            Text(language.lang)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 100, height: 100)
                                .background(Color.blue)
                                .cornerRadius(15)
                                // for titling effect we need match geometry effect modifier
                                .matchedGeometryEffect(id: language.id, in: namespace)
                                .onTapGesture {
                                    // moving
                                    selected.append(language)
                                    
                                    // removing
                                    languages.removeAll { (lang: Language) -> Bool in
                                        
                                        if lang.id == language.id {
                                            return true
                                        } else {
                                            return false
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.all)
                }
                
                HStack {
                    Text("Selected Language")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(selected) { language in
                        Text(language.lang)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .frame(width: 100, height: 100)
                            .background(Color.green)
                            .cornerRadius(15)
                            // for titling effect we need match geometry effect modifier
                            .matchedGeometryEffect(id: language.id, in: namespace)
                            .onTapGesture {
                                // resending views back
                                languages.append(language)
                                
                                selected.removeAll { lang -> Bool in
                                    
                                    lang.id == language.id
                                }
                            }
                    }
                }
                .padding(.all)
            }
            .navigationTitle("Choose Language")
            .navigationBarTitleDisplayMode(.inline)
        }
        .animation(.easeOut)
    }
}

struct Language: Identifiable {
    var id: Int
    var lang: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
