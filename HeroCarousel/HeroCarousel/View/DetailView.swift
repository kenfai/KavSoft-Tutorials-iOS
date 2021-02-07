//
//  DetailView.swift
//  HeroCarousel
//
//  Created by Ginger on 07/02/2021.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var model: CarouselViewModel
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            VStack {
                Text("Monday 28 December")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "Date-\(model.selectedCard.id)", in: animation)
                
                HStack {
                    Text(model.selectedCard.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 250, alignment: .leading)
                        .padding()
                        .matchedGeometryEffect(id: "Title-\(model.selectedCard.id)", in: animation)
                    
                    Spacer(minLength: 0)
                }
                
                // Detail Text Content
                
                // Showing content some delay for better Animation
                if model.showContent {
                    Text(model.content)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .animation(.easeIn)
                }
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                model.selectedCard.cardColor
                    .cornerRadius(25)
                    .matchedGeometryEffect(id: "bgColor-\(model.selectedCard.id)", in: animation)
                    .ignoresSafeArea(.all, edges: .bottom)
            )
            
            // Close Button
            VStack {
                Spacer()
                
                if model.showContent {
                    Button(action: CloseView) {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white.opacity(0.6))
                            .clipShape(Circle())
                            .padding(5)
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    .padding(.bottom)
                }
            }
        }
    }
    
    func CloseView() {
        withAnimation(.spring()) {
            model.showCard.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeIn) {
                    model.showContent = false
                }
            }
        }
    }
}
