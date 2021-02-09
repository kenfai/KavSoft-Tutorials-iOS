//
//  ContextModifier.swift
//  InstagramExploreLayout
//
//  Created by Ginger on 09/02/2021.
//

import SwiftUI

struct ContextModifier: ViewModifier {
    // ContextMenu Modifier
    var card: Card

    func body(content: Content) -> some View {
        content
            .contextMenu(menuItems: {
                Text("By \(card.author)")
            })
            .contentShape(RoundedRectangle(cornerRadius: 5))
    }
}
