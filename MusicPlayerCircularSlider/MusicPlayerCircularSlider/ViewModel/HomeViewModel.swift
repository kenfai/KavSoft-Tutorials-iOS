//
//  HomeViewModel.swift
//  MusicPlayerCircularSlider
//
//  Created by Ginger on 01/01/2021.
//

import SwiftUI
import AVKit

let url = URL(fileURLWithPath: Bundle.main.path(forResource: "audio", ofType: "mp3")!)

class HomeViewModel: ObservableObject {
    @Published var player = try! AVAudioPlayer(contentsOf: url)
    @Published var isPlaying = false
    @Published var album = Album()
    @Published var angle: Double = 0
    @Published var volume: CGFloat = 0
    
    func fetchAlbum() {
        let asset = AVAsset(url: player.url!)
        
        asset.metadata.forEach { (meta) in
            switch(meta.commonKey?.rawValue) {
            case "title": album.title = meta.value as? String ?? ""
            case "artist": album.artist = meta.value as? String ?? ""
            case "type": album.type = meta.value as? String ?? ""
            case "artwork": if meta.value != nil { album.artwork = UIImage(data: meta.value as! Data)!}
            default: ()
            }
        }
        
        // fetching audio volume level
        volume = CGFloat(player.volume) * (UIScreen.main.bounds.width - 180)
    }
    
    func updateTimer() {
        let currentTime = player.currentTime
        let total = player.duration
        let progress = currentTime / total
        
        withAnimation(Animation.linear(duration: 0.1)) {
            self.angle = Double(progress) * 288
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // 12.5 = 25 => Circle Radius
        let radians = atan2(vector.dy - 12.5, vector.dx - 12.5)
        let tempAngle = radians * 180 / .pi
        
        let angle = tempAngle < 0 ? 360 + tempAngle : tempAngle
        
        // since maximum slide is 0.8
        // 0.8 * 36 = 288
        if angle <= 288 {
            // getting time
            let progress = angle / 288
            let time = TimeInterval(progress) * player.duration
            player.currentTime = time
            player.play()
            withAnimation(Animation.linear(duration: 0.1)) {
                self.angle = Double(angle)
            }
        }
        isPlaying = player.isPlaying
    }
    
    func play() {
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying = player.isPlaying
    }
    
    func getCurrentTime(value: TimeInterval) -> String {
        return "\(Int(value / 60)): \(Int(value.truncatingRemainder(dividingBy: 60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy: 60)))"
    }
    
    func updateVolume(value: DragGesture.Value) {
        // Update Volume
        
        // 160 width 20 circle size
        // total 180
        if value.location.x >= -5 && value.location.x <= UIScreen.main.bounds.width - 175 {
            let progress = value.location.x / (UIScreen.main.bounds.width - 180)
            
            player.volume = Float(progress)
            
            withAnimation(Animation.linear(duration: 0.1)) {
                volume = value.location.x
            }
        }
    }
    
    func backward() {
        player.currentTime -= 5
    }
    func forward() {
        player.currentTime += 5
    }
}
