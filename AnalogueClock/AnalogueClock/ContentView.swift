//
//  ContentView.swift
//  AnalogueClock
//
//  Created by Ginger on 27/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = false
    
    var body: some View {
        NavigationView {
            Home(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct Home: View {
    @Binding var isDark: Bool
    var width = UIScreen.main.bounds.width
    @State var currentTime = Time(min: 0, sec: 0, hour: 0)
    @State var receiver = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("Analogue Clock")
                    .font(.title)
                    .fontWeight(.heavy)
                
                Spacer(minLength: 0)
                
                Button(action: {
                    isDark.toggle()
                }) {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())
                }
            }
            .padding()
            
            Spacer(minLength: 0)
            
            ZStack{
                Circle()
                    .fill(Color("Color").opacity(0.1))
                
                // Seconds and Min dots
                ForEach(0..<60, id: \.self) { i in
                    Rectangle()
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (width - 110) / 2)
                        .rotationEffect(Angle(degrees: Double(i) * 6))
                }
                
                // Sec
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (width - 180) / 2)
                    .offset(y: -(width - 180) / 4)
                    .rotationEffect(Angle(degrees: Double(currentTime.sec) * 6))
                
                // Min
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4, height: (width - 200) / 2)
                    .offset(y: -(width - 200) / 4)
                    .rotationEffect(Angle(degrees: Double(currentTime.min) * 6))
                
                // Hour
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 4.5, height: (width - 240) / 2)
                    .offset(y: -(width - 240) / 4)
                    .rotationEffect(Angle(degrees: Double(currentTime.hour) * 30 + Double(currentTime.min / 2)))
                
                // Center Circle
                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
            }
            .frame(width: width - 80, height: width - 80)
            
            Spacer(minLength: 0)
            
            // Getting Locale Region Name
            Text(Locale.current.localizedString(forRegionCode: Locale.current.regionCode!) ?? "")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 35)
            
            Text(getTime())
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .padding(.top, 10)
            
            Spacer(minLength: 0)
        }
        .onAppear(perform: {
            let calendar = Calendar.current
            
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            //withAnimation(Animation.linear(duration: 0.01)) {
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            //}
        })
        .onReceive(receiver) { _ in
            let calendar = Calendar.current
            
            let min = calendar.component(.minute, from: Date())
            let sec = calendar.component(.second, from: Date())
            let hour = calendar.component(.hour, from: Date())
            
            withAnimation(Animation.linear(duration: 0.01)) {
                self.currentTime = Time(min: min, sec: sec, hour: hour)
            }
        }
    }
    
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        
        return format.string(from: Date())
    }
}

// Calculating Time
struct Time {
    var min: Int
    var sec: Int
    var hour: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
