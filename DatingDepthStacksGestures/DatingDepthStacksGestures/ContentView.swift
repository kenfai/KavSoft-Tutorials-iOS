//
//  ContentView.swift
//  DatingDepthStacksGestures
//
//  Created by Ginger on 17/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var profiles = [
        Profile(id: 0, name: "Annie Watson", image: "p0", age: "27", offset: 0),
        Profile(id: 1, name: "Clarie", image: "p1", age: "19", offset: 0),
        Profile(id: 2, name: "Catherine", image: "p2", age: "25", offset: 0),
        Profile(id: 3, name: "Emma", image: "p3", age: "26", offset: 0),
        Profile(id: 4, name: "Juliana", image: "p4", age: "20", offset: 0),
        Profile(id: 5, name: "Kaviya", image: "p5", age: "22", offset: 0),
        Profile(id: 6, name: "Jill", image: "p6", age: "18", offset: 0),
        Profile(id: 7, name: "Terasa", image: "p7", age: "29", offset: 0),
    ]

    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button(action: {}) {
                    Image("menu")
                        .renderingMode(.template)
                }
                
                Text("Blind Dating")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image("noti")
                        .renderingMode(.template)
                }
            }
            .foregroundColor(.black)
            .padding()
            
            // For reading height and width
            GeometryReader { g in
                ZStack {
                    // ZStack will overlay one on another so reversing the array to display the first and last correctly
                    ForEach(profiles.reversed()) { profile in
                        // Profile View
                        ProfileView(profile: profile, frame: g.frame(in: .global))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            
            Spacer(minLength: 0)
        }
        .background(Color.black.opacity(0.06).edgesIgnoringSafeArea(.all))
    }
}

struct ProfileView: View {
    @State var profile: Profile
    var frame: CGRect
    
    var body: some View {
        // setting information view to bottom
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Image(profile.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width, height: frame.height)
            
            // adding color when it's accepted or rejected
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                (profile.offset > 0 ? Color.green : Color("Color")).opacity(profile.offset != 0 ? 0.7 : 0)
                
                // Text
                HStack {
                    if profile.offset < 0 {
                        Spacer(minLength: 0)
                    }
                
                    Text(profile.offset == 0 ? "" : (profile.offset > 0 ? "Liked" : "Rejected"))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 25)
                        .padding(.horizontal)
                    
                    if profile.offset > 0 {
                        Spacer(minLength: 0)
                    }
                }
            }
            
            // Slightly Dark shade to bottom
            LinearGradient(gradient: .init(colors: [Color.black.opacity(0), Color.black.opacity(0.4)]), startPoint: .center, endPoint: .bottom)
            
            // Displaying Information
            VStack(spacing: 15) {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(profile.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(profile.age + " +")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                }
                
                // Buttons
                HStack(spacing: 25) {
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            // moving view left
                            profile.offset = -500
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color("Color"))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        withAnimation(Animation.easeIn(duration: 0.8)) {
                            // moving view right
                            profile.offset = 500
                        }
                        
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(20)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                    
                    Spacer(minLength: 0)
                }
            }
            .padding()
        }
        .cornerRadius(20)
        .offset(x: profile.offset)
        // rotating view when its disappearing
        .rotationEffect(.init(degrees: profile.offset == 0 ? 0 : (profile.offset > 0 ? 12 : -12)))
        
        // adding Drag Gesture
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default) {
                        profile.offset = value.translation.width
                    }
                })
                .onEnded({ value in
                    withAnimation(Animation.easeIn) {
                        if profile.offset > 150 {
                            profile.offset = 500
                        } else if profile.offset < -150 {
                            profile.offset = -500
                        } else {
                            profile.offset = 0
                        }
                    }
                })
        )
    }
}

// Sample Data
struct Profile: Identifiable {
    var id: Int
    var name: String
    var image: String
    var age: String
    var offset: CGFloat
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
