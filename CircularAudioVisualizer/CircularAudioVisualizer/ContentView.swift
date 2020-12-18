//
//  ContentView.swift
//  CircularAudioVisualizer
//
//  Created by Ginger on 18/12/2020.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("")
                .navigationBarHidden(true)
                .preferredColorScheme(.dark)
        }
    }
}

struct Home: View {
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
    // Timer to Find current time of audio
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    // Details of song
    @StateObject var album = AlbumData()
    
    @State var animatedValue: CGFloat = 55
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    
    @State var time: Float = 0
    
    @State var ringOpacity = 0.0
    @State var ringSize: CGFloat = 300
    
    @State var numberOfWaves = 0
    @State var timeGraph: [Int] = [0]
    
    @State var yPower = 0
    @State var peaking = true
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text(album.title)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 10) {
                        Text(album.artist)
                            .font(.caption)
                        
                        Text(album.type)
                            .font(.caption)
                    }
                }
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image(systemName: "suit.heart.fill")
                        .foregroundColor(.red)
                        .frame(width: 45, height: 45)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                
                Button(action: {}) {
                    Image(systemName: "bookmark.fill")
                        .foregroundColor(.black)
                        .frame(width: 45, height: 45)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .padding(.leading, 10)
            }
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack {
                if album.artwork.count != 0 {
                    Image(uiImage: UIImage(data: album.artwork)!)
                        .resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(15)
                }
                
//                ForEach(0..<timeGraph.count, id:\.self) { index in
//                    Graph(unitTime: index, y: timeGraph[index])
//                }
//                .offset(x: -CGFloat(timeGraph.count))
//                .offset(x: 300, y: 300)
            }
            
            ZStack {
                
//                ZStack {
//                    Circle()
//                        .fill(Color.white.opacity(Double(animatedValue / 800)))
//
//                    Circle()
//                        .fill(Color.white.opacity(Double(animatedValue / 600)))
//                        .frame(width: animatedValue / 2, height: animatedValue / 2)
//
//                    Circle()
//                        .fill(Color.white.opacity(Double(animatedValue / 250)))
//                        .frame(width: animatedValue / 3, height: animatedValue / 3)
//                }
                //.frame(width: animatedValue, height: animatedValue)
                
                ForEach(0..<numberOfWaves, id:\.self) { _ in
                    Wave()
                }
                
                Button(action: play) {
                    Image(systemName: album.isPlaying ? "pause.fill" : "play.fill")
                        .foregroundColor(.black)
                        .frame(width: 55, height: 55)
                        .background(Color.white)
                        .clipShape(Circle())
                }
            }
            .frame(width: maxWidth, height: maxWidth)
            .padding(.top, 30)
            
            // Audio Tracking
            Slider(value: Binding(get: { time }, set: { (newValue) in
                time = newValue
                
                // Updating player
                audioPlayer.currentTime = Double(time) * audioPlayer.duration
                audioPlayer.play()
            }))
            .padding()
            
            Spacer(minLength: 0)
        }
        .onReceive(timer) { _ in
            if audioPlayer.isPlaying {
                audioPlayer.updateMeters()
                album.isPlaying = true
                //print(audioPlayer.currentTime)
                
                // updating slider
                time = Float(audioPlayer.currentTime / audioPlayer.duration)
                
                // Getting Animation
                startAnimation()
            } else {
                album.isPlaying = false
            }
        }
        .onAppear(perform: getAudioData)
    }
    
    func play() {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    }
    
    func getAudioData() {
        audioPlayer.isMeteringEnabled = true
        
        // Extracting Audio Data
        let asset = AVAsset(url: audioPlayer.url!)
        
        asset.metadata.forEach { meta in
            switch(meta.commonKey?.rawValue) {
            case "artwork": album.artwork = meta.value == nil ? UIImage(named: "album")!.pngData()! : meta.value as! Data
            case "artist": album.artist = meta.value == nil ? "" : meta.value as! String
            case "type": album.type = meta.value == nil ? "" : meta.value as! String
            case "title": album.title = meta.value == nil ? "" : meta.value as! String
            default: ()
            }
            
        }
    }
    
    func startAnimation() {
        // Getting levels
        var power: Float = 0
        
        for i in 0..<audioPlayer.numberOfChannels {
            power += audioPlayer.averagePower(forChannel: i)
        }
        
        // Calculation to get Postive number
        
        let value = max(0, power + 55)
        // you can also use if st to find positive number
        
        let animated = CGFloat(value) * (maxWidth / 55)
        
        withAnimation(Animation.linear(duration: 0.01)) {
            self.animatedValue = animated + 55
        }
        
        timeGraph.append(Int((power) * 5))
        if timeGraph.count > 250 {
            timeGraph.removeFirst()
        }
        
        if Int(value) > yPower {
            peaking = true
        }
        
        if Int(value) < yPower && peaking {
            numberOfWaves += 1
            peaking = false
        }
        
        yPower = Int(value)
        
        print(yPower)
    }
}

struct Graph: View {
    var unitTime: Int
    var y: Int
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: unitTime, y: 0))
            path.addLine(to: CGPoint(x: unitTime, y: y))
        }
        .stroke(Color.white)
    }
}

struct Wave: View {
    @State var ringOpacity = 0.0
    @State var ringSize: CGFloat = 0
    
    var body: some View {
        Circle()
            .fill(Color.white.opacity(ringOpacity))
            .frame(width: ringSize, height: ringSize)
            .onAppear {
                self.ringOpacity = 0.4
                self.ringSize = 250
                
                withAnimation(Animation.easeOut(duration: 1)) {
                    self.ringOpacity = 0.0
                    self.ringSize = 0
                }
            }
    }
}

let url = Bundle.main.path(forResource: "audio", ofType: "mp3")

class AlbumData: ObservableObject {
    @Published var isPlaying: Bool = true
    @Published var title = ""
    @Published var artist = ""
    @Published var artwork = Data(count: 0)
    @Published var type = ""
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
