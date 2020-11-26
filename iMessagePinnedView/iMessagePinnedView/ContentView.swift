//
//  ContentView.swift
//  iMessagePinnedView
//
//  Created by Ginger on 26/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("Message")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button(action: {}) {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                })
        }
    }
}

struct Home: View {
    @State var messages: [Message] = [
        Message(id: 0, name: "Catherine", message: "Hi Kavsoft", profile: "p1", offset: 0),
        Message(id: 1, name: "Emma", message: "New Video!", profile: "p2", offset: 0),
        Message(id: 2, name: "Julie", message: "How arey ou?", profile: "p3", offset: 0),
        Message(id: 3, name: "Emily", message: "Hey Justine", profile: "p4", offset: 0),
        Message(id: 4, name: "Kaviya", message: "hello?", profile: "p5", offset: 0),
        Message(id: 5, name: "Jenna", message: "Bye :)", profile: "p6", offset: 0),
        Message(id: 6, name: "Juliana", message: "Nothing much..", profile: "p7", offset: 0),
    ]
    
    @State var pinnedViews: [Message] = []
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    @Namespace var namespace
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // Pinned View
            if !pinnedViews.isEmpty {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(pinnedViews) { pinned in
                        Image(pinned.profile)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            // padding 30 + spacing 20 x2 = 70
                            .frame(width: (UIScreen.main.bounds.width - 70) / 3, height: (UIScreen.main.bounds.width - 70) / 3)
                            .clipShape(Circle())
                            // adding animation
                            .matchedGeometryEffect(id: pinned.profile, in: namespace)
                        // context menu for restoring
                            .contentShape(Circle())
                            .contextMenu {
                                Button(action: {
                                    // remove from Pinned
                                    withAnimation(.default) {
                                        var index = 0
                                        
                                        for i in 0..<pinnedViews.count {
                                            if pinned.profile == pinnedViews[i].profile {
                                                index = i
                                            }
                                        }
                                        
                                        // removing pinned View
                                        pinnedViews.remove(at: index)
                                        
                                        // adding back to main ScrollView
                                        messages.append(pinned)
                                    }
                                }) {
                                    Text("Remove")
                                }
                            }
                    }
                }
                .padding()
            }
            
            LazyVStack(alignment: .leading, spacing: 5) {
                ForEach(messages) { msg in
                    ZStack {
                        // adding Buttons
                        HStack {
                            Color.yellow
                                .frame(width: 90)
                            // hiding when left swipe
                                .opacity(msg.offset > 0 ? 1 : 0)
                            
                            Spacer()
                            
                            Color.red
                                .frame(width: 90)
                                .opacity(msg.offset < 0 ? 1 : 0)
                        }
                        
                        HStack {
                            Button(action: {
                                // appending View
                                withAnimation(.default) {
                                    let index = getIndex(profile: msg.profile)
                                    var pinnedView = messages[index]
                                    pinnedView.offset = 0
                                    pinnedViews.append(pinnedView)
                                    // removing from main View
                                    messages.removeAll { msg1 -> Bool in
                                        msg.profile == msg1.profile
                                    }
                                }
                            }) {
                                Image(systemName: "pin.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 90)
                            
                            Spacer()
                            
                            Button(action: {
                                    // removing from main View
                                withAnimation(.default) {
                                    messages.removeAll { msg1 -> Bool in
                                        msg.profile == msg1.profile
                                    }
                                }
                            }) {
                                Image(systemName: "trash.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 90)
                        }
                        
                        HStack(spacing: 15) {
                            Image(msg.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .matchedGeometryEffect(id: msg.profile, in: namespace)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text(msg.name)
                                
                                Text(msg.message)
                                    .foregroundColor(.gray)
                                    .lineLimit(1)
                                
                                Divider()
                            }
                        }
                        .padding(.all)
                        .background(Color.white)
                        .contentShape(Rectangle())
                        // adding gesture
                        .offset(x: msg.offset)
                        .gesture(DragGesture().onChanged({ value in
                            withAnimation(.default) {
                                messages[getIndex(profile: msg.profile)].offset = value.translation.width
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.default) {
                                if value.translation.width > 80 {
                                    messages[getIndex(profile: msg.profile)].offset = 90
                                } else if value.translation.width < -80 {
                                    messages[getIndex(profile: msg.profile)].offset = -90
                                } else {
                                    messages[getIndex(profile: msg.profile)].offset = 0
                                }
                            }
                        }))
                    }
                }
            }
        }
    }
    
    func getIndex(profile: String) -> Int {
        var index = 0
        
        for i in 0 ..< messages.count {
            if profile == messages[i].profile {
                index = i
            }
        }
        
        return index
    }
}

// Sample Data
struct Message: Identifiable {
    var id: Int
    var name: String
    var message: String
    var profile: String
    var offset: CGFloat
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
