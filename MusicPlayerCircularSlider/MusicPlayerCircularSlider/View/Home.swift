//
//  Home.swift
//  MusicPlayerCircularSlider
//
//  Created by Ginger on 01/01/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    // For smaller size phones
    @State var width: CGFloat = UIScreen.main.bounds.height < 750 ? 130 : 230
    @State var timer = Timer.publish(every: 0.5, on: .current, in: .default).autoconnect()
    var body: some View {
        VStack {
            // TopView
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.black)
                }
            }
            .padding()
            
            VStack {
                Spacer(minLength: 0)
                
                ZStack {
                    // Album Image
                    Image(uiImage: homeData.album.artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: width)
                        .clipShape(Circle())
                    
                    ZStack {
                        Circle()
                            .trim(from: 0, to: 0.8)
                            .stroke(Color.black.opacity(0.06), lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(homeData.angle) / 360)
                            .stroke(Color("orange"), lineWidth: 4)
                            .frame(width: width + 45, height: width + 45)
                        
                        // Slider Circle
                        Circle()
                            .fill(Color("orange"))
                            .frame(width: 25, height: 25)
                            // Moving View
                            .offset(x: (width + 45) / 2)
                            .rotationEffect(Angle(degrees: homeData.angle))
                        // Gesture
                            .gesture(DragGesture().onChanged(homeData.onChanged(value:)))
                    }
                    // Rotating View for Buttom Facing
                    // Mid 90 deg + 0.1*360 = 36
                    // total 126
                    .rotationEffect(Angle(degrees: 126))
                    
                    // Time Texts
                    Text(homeData.getCurrentTime(value: homeData.player.currentTime))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: UIScreen.main.bounds.height < 750 ? -65 : -85, y: (width + 60) / 2)
                    
                    Text(homeData.getCurrentTime(value: homeData.player.duration))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .offset(x: UIScreen.main.bounds.height < 750 ? 65 : 85, y: (width + 60) / 2)
                }
                
                Text(homeData.album.title)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    .padding(.horizontal)
                    .lineLimit(1)
                
                Text(homeData.album.artist)
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                
                Text(homeData.album.type)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(5)
                    .padding(.top)
                
                HStack(spacing: 55) {
                    Button(action: homeData.backward) {
                        Image(systemName: "backward.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    
                    Button(action: homeData.play) {
                        Image(systemName: homeData.isPlaying ? "pause.fill" : "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 80, height: 80)
                            .background(Color("orange"))
                            .clipShape(Circle())
                    }
                
                    Button(action: homeData.forward) {
                        Image(systemName: "forward.fill")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 25)
                
                // Volume Control
                HStack(spacing: 15) {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        Capsule()
                            .fill(Color.black.opacity(0.06))
                            .frame(height: 4)
                        
                        Capsule()
                            .fill(Color("orange"))
                            .frame(width: homeData.volume, height: 4)
                        
                        // Slider
                        Circle()
                            .fill(Color("orange"))
                            .frame(width: 20, height: 20)
                            // gesture
                            .offset(x: homeData.volume)
                            .gesture(DragGesture().onChanged(homeData.updateVolume(value:)))
                    }
                    // default frame
                    .frame(width: UIScreen.main.bounds.width - 160)
                    
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                .padding(.top, 25)
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .background(Color("bg"))
            .cornerRadius(35)
            
            HStack(spacing: 0) {
                ForEach(buttons, id: \.self) { name in
                    Button(action: {}) {
                        Image(systemName: name)
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    if name != buttons.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 35)
            .padding(.top, 25)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom != 0 ? 5 : 15)
        }
        .background(
            VStack {
                Color("Color")
                Color("Color1")
            }
            .ignoresSafeArea(.all, edges: .all)
        )
        // Fetching album data
        .onAppear(perform: homeData.fetchAlbum)
        .onReceive(timer) { (_) in
            homeData.updateTimer()
        }
    }
    
    // Buttons
    var buttons = ["heart.fill", "star.fill", "eye.fill", "square.and.arrow.up.fill"]
}
