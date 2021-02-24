//
//  ScrollableTabBar.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    
    // To store our SwiftUI View
    var content: Content
    
    // Getting Rect to calculate Width and Height of ScrollView
    var rect: CGRect
    
    // ContentOffset
    @Binding var offset: CGFloat
    
    // Tabs
    var tabs: [Any]
    
    // ScrollView
    // For paging AKA Scrollable Tabs
    let scrollView = UIScrollView()
    
    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        
        setUpScrollView()
        // Setting Content Size
        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        scrollView.contentOffset.x = offset
        
        scrollView.addSubview(extractView())
        
        scrollView.delegate = context.coordinator
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Updating View
        if uiView.contentOffset.x != offset {
            //uiView.contentOffset.x = offset
            // Animating
            // The Animation Glitch is because it's updating on Two times
            // Solution is to Remove Delegate while Animating
            
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
            } completion: { (status) in
                if status {
                    uiView.delegate = context.coordinator
                }
            }
        }
    }
    
    // setting up ScrollView
    func setUpScrollView() {
        
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    // Extracting SwiftUI View
    func extractView() -> UIView {
        
        // since it depends upon tab size
        // so we getting tabs also
        
        // For ease of use
        let controller = UIHostingController(rootView: HStack(spacing: 0) { content }.ignoresSafeArea())
        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width * CGFloat(tabs.count), height: rect.height)
        
        return controller.view!
    }
    
    // Delegate Function to get Offset
    class Coordinator: NSObject, UIScrollViewDelegate {
        
        var parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
