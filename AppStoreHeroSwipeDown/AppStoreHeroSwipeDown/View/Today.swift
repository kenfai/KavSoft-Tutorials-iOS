//
//  Today.swift
//  AppStoreHeroSwipeDown
//
//  Created by Ginger on 25/01/2021.
//

import SwiftUI

struct Today: View {
    var animation: Namespace.ID
    @EnvironmentObject var detail: DetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("SATURDAY 14 NOVEMBER")
                            .foregroundColor(.gray)
                        
                        Text("Today")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "person.circle")
                            .font(.largeTitle)
                    }
                }
                .padding()
                
                ForEach(items) { item in
                    // CardView
                    if detail.show {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 320)
                            .padding(.horizontal)
                            .padding(.top)
                    } else {
                        TodayCardView(item: item, animation: animation)
                            .padding(.horizontal)
                            .padding(.top)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    detail.selectedItem = item
                                    detail.show.toggle()
                                }
                            }
                    }
                }
            }
            .padding(.bottom)
        }
        .background(Color.primary.opacity(0.06).ignoresSafeArea())
    }
}
