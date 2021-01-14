//
//  CustomView.swift
//  ViewBuilder
//
//  Created by Ginger on 14/01/2021.
//

import SwiftUI

struct CustomView<Content: View, Detail: View>: View {
    
    var content: Content
    var detail: Detail
    @Binding var columns: [GridItem]
    
    init(columns: Binding<[GridItem]>, @ViewBuilder content: () -> Content, @ViewBuilder detail: () -> Detail) {
        self.content = content()
        self.detail = detail()
        self._columns = columns
    }
    
    var body: some View {
        if columns.count == 1 {
            HStack(spacing: 15) {
                content
                
                detail
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
        } else {
            VStack {
                content
                
                detail
            }
            .padding(.horizontal)
        }
    }
}
