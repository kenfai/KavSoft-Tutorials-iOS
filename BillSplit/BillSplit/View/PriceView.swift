//
//  PriceView.swift
//  BillSplit
//
//  Created by Ginger on 06/02/2021.
//

import SwiftUI

struct PriceView: View {
    @Binding var payer: Payer
    var totalAmount: CGFloat
    
    @Binding var payers: [Payer]
    
    @Binding var sharedAmount: CGFloat
    
    var body: some View {
        VStack(spacing: 15) {
            // Custom Slider
            HStack {
                Image(payer.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .padding(5)
                    .background(payer.bgColor)
                    .clipShape(Circle())
                
                Text(payer.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(getPrice())
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
            }
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(Color.black.opacity(0.25))
                    .frame(height: 30)
                
                Capsule()
                    .fill(payer.bgColor)
                    .frame(width: payer.offset + 20, height: 30)
                
                // Dots
                HStack(spacing: (UIScreen.main.bounds.width - 100) / 12) {
                    
                    ForEach(0..<12, id: \.self) { index in
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: index % 4 == 0 ? 7 : 4, height: index % 4 == 0 ? 7 : 4)
                    }
                }
                .padding(.leading)
                
                Circle()
                    .fill(Color("card"))
                    .frame(width: 35, height: 35)
                    .background(Circle().stroke(Color.white, lineWidth: 5))
                    .offset(x: payer.offset)
                    .gesture(DragGesture().onChanged({ (value) in
                        // Padding Horizontal
                        
                        // Padding Horizontal = 30
                        // Circle radius = 20
                        // Total 50
                        if value.location.x >= 20 && value.location.x <= UIScreen.main.bounds.width - 50 {
                            
                            // Circle Radius = 20
                            let inc = (UIScreen.main.bounds.width - 70) / (totalAmount / 0.05)
                            
                            let x = floor((value.location.x - 20) / inc) * inc
                            payer.offset = x
                            
                            let percent = payer.offset / (UIScreen.main.bounds.width - 70)
                            
                            payer.payAmount = percent * (totalAmount)
                            
                            
                        }
                    }).onEnded({ (value) in
                        
                        
                        sharedAmount = payers.reduce(0) { $0 + $1.payAmount }
                    }))
            }
        }
        .padding()
    }
    
    func getPrice() -> String {
        let percent = payer.offset / (UIScreen.main.bounds.width - 70)
        
        let amount = percent * (totalAmount)
        
        return String(format: "%.2f", amount)
    }
}
