//
//  TabBar.swift
//  ScrollableTabBar
//
//  Created by Ginger on 23/02/2021.
//

import SwiftUI

struct TabBar: View {
    @Binding var offset: CGFloat
    @Binding var showCapsule: Bool
    @State var width: CGFloat = 0

    var body: some View {
        GeometryReader { proxy -> AnyView in
            
            // Equal Width
            let equalWidth = proxy.frame(in: .global).width / CGFloat(tabs.count)
            
            DispatchQueue.main.async {
                self.width = equalWidth
            }
            
            return AnyView(
                ZStack(alignment: .bottom, content: {
                    Capsule()
                        .fill(Color("lightblue"))
                        .frame(width: equalWidth - 15, height: showCapsule ? 40 : 4)
                        .offset(x: getOffset() + 7 - 128)
                    
                    HStack(spacing: 0) {
                        
                        ForEach(tabs.indices, id: \.self) { index in
                            //Text("\(index)").foregroundColor(.white)
                            Text(tabs[index])
                                .fontWeight(.bold)
                                .foregroundColor(showCapsule ? (getIndexFromOffset() == CGFloat(index) ? .black : .white) : .white)
                                .frame(width: equalWidth, height: 40)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    // Setting Offset
                                    withAnimation {
                                        offset = UIScreen.main.bounds.width * CGFloat(index)
                                    }
                                }
                        }
                    }
                })
                .frame(maxWidth: .infinity, maxHeight: 40, alignment: .center)
                .clipShape(Capsule())
            )
        }
        .padding()
        .frame(height: 40)
    }
    
    // Calculating Offset
    func getOffset() -> CGFloat {
        
        let progress = offset / UIScreen.main.bounds.width

        return progress * width
    }
    
    func getIndexFromOffset() -> CGFloat {
        let indexFloat = offset / UIScreen.main.bounds.width
        
        return indexFloat.rounded(.toNearestOrAwayFromZero)
    }
}
