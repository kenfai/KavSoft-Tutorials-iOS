//
//  ContentView.swift
//  StylishDashboardUI
//
//  Created by Ginger on 13/12/2020.
//

import SwiftUI

enum Region {
    case usa, global
}

enum Period {
    case today, yesterday, lastWeek
}

extension DateFormatter {
    static let chartDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        
        return formatter
    }()
}

struct ContentView: View {
    @State private var region: Region  = .usa
    @State private var period: Period = .today
    @State private var selected = 0
    
    @Namespace var namespace: Namespace.ID
    
    let calendar = Calendar.current
    let today = Date()
    
    var body: some View {
        VStack(spacing: 35) {
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "bell")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding(.vertical)
                
                HStack {
                    Text("Dashboard")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding(.vertical)
                
                HStack {
                    Button(action: {
                        withAnimation {
                            region = .usa
                        }
                    }) {
                        ZStack {
                            Text("USA")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(region == .usa ? .black : .white)
                                .padding(14)
                                .frame(width: (UIScreen.main.bounds.width - 40) / 2)
                                .zIndex(1.0)
                            
                            if (region == .usa) {
                                Capsule()
                                    .fill(Color.white)
                                    .matchedGeometryEffect(id: "tab", in: namespace)
                            }
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
                            region = .global
                        }
                    }) {
                        ZStack {
                            Text("Global")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(region == .global ? .black : .white)
                                .padding(14)
                                .frame(width: (UIScreen.main.bounds.width - 40) / 2)
                                .zIndex(1.0)
                        
                            if (region == .global) {
                                Capsule()
                                    .fill(Color.white)
                                    .matchedGeometryEffect(id: "tab", in: namespace)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white.opacity(0.15))
                .clipShape(Capsule())
                
                HStack {
                    Button(action: {
                        withAnimation {
                            period = .today
                        }
                    }) {
                        Text("Today")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(period == .today ? 1 : 0.6))
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        withAnimation {
                            period = .yesterday
                        }
                    }) {
                        Text("Yesterday")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(period == .yesterday ? 1 : 0.6))
                            .padding(.horizontal)
                    }
                    
                    Button(action: {
                        withAnimation {
                            period = .lastWeek
                        }
                    }) {
                        Text("Last Week")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white.opacity(period == .lastWeek ? 1 : 0.6))
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Panel(categoryText: "Sold", value: 18789, bgColour: Color.orange)
                        Panel(categoryText: "Returned", value: 1089, bgColour: Color.red)
                    }
                    
                    HStack(spacing: 15) {
                        Panel(categoryText: "Delivered", value: 18789, bgColour: Color.green)
                        Panel(categoryText: "Transit", value: 1089, bgColour: Color.blue)
                        Panel(categoryText: "Cancelled", value: 1089, bgColour: Color.purple)
                    }
                }
            }
            .padding(.horizontal)
            
            ZStack {
                Color.white
                    .clipShape(CustomShape(corners: [.topLeft, .topRight], size: 45))
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Daily Sold Unit")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        ForEach(0..<7) { day in
                            // Last 7 days sale
                            Bar(
                                value: soldUnitData[day],
                                date: DateFormatter.chartDateFormatter.string(from: calendar.date(byAdding: .day, value: day - 7, to: today)!),
                                selected: selected == day)
                                .onTapGesture {
                                    withAnimation {
                                        selected = day
                                    }
                                }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
        .background(Color("bg").edgesIgnoringSafeArea(.all))
    }
}

struct Panel: View {
    var categoryText: String
    var value: Int
    var bgColour: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryText)
                .font(.callout)
                .padding(.bottom)
            
            Text(String(format: "%d", locale: Locale.current, value))
                .font(.title3)
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(bgColour)
        .cornerRadius(10)
    }
}

struct CustomShape: Shape {
    var corners: UIRectCorner
    var size: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}

struct Bar: View {
    var value: CGFloat
    var date: String
    var selected: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            GeometryReader { geo in
                VStack() {
                    Spacer()
                    
                    if (selected) {
                        Text(String(format: "%.0f", locale: Locale.current, value))
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                        
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.red.opacity(selected ? 1.0 : 0.5))
                        .frame(width: geo.frame(in: .local).width / 100 * 70, height: (value / 1000) * geo.frame(in: .local).height)
                        //.frame(width: 10, height: (value / 1000) * 200)
                }
                .padding(.horizontal, geo.frame(in: .local).width / 100 * 15)
                .frame(height: geo.frame(in: .local).height)
                //.frame(height: 200)
            }
            
            Text(date)
                .font(.caption2)
        }
    }
}

var soldUnitData: [CGFloat] = [348, 536, 777, 473, 564, 834, 843]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
