//
//  ContentView.swift
//  ShoeApp
//
//  Created by Ginger on 28/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    var black = Color.black.opacity(0.7)
    var width = UIScreen.main.bounds.width
    @State var more = false
    @State var gender = "Male"
    @State var size = 6
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @State var added = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color("red"))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "suit.heart")
                            .font(.system(size: 22))
                            .foregroundColor(black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                    }
                }
                
                Image("nike")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .padding()
            
            Image("shoe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width - (more ? 200 : 100))
                .padding(.top, 25)
            
            
            ScrollView(UIScreen.main.bounds.width < 750 ? .vertical : .init(), showsIndicators: false) {
                    
                VStack {
                    HStack {
                        Text("Nike Air Hurricane for Women")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(black)
                        
                        Spacer(minLength: 0)
                        
                        Text("$165")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(Color("red"))
                    }
                    .padding(.top, 25)
                    .padding(.trailing)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("The Nike Air Huarache Run DNA Ch. 1 re-imagines not only the original Air Huarache design, but incorporates elements from another legendary icon, the Air Max 1. Featuring a stretchy inner sleeve, responsive cushioning and a structured heel cage, this release pays tribute to the origins of two of Nike's most ambitious designs.")
                            .lineLimit(more ? nil : 3)
                            .foregroundColor(black)
                        
                        Button(action: {
                            withAnimation {
                                more.toggle()
                            }
                        }) {
                            Text("Read More")
                                .fontWeight(.bold)
                                .foregroundColor(Color("red"))
                        }
                    }
                    .padding([.vertical, .trailing])
                    
                    HStack(spacing: 15) {
                        Text("Gender")
                            .fontWeight(.heavy)
                            .foregroundColor(black)
                            .frame(width: 75, alignment: .leading)
                        
                        GenderButton(gender: $gender, title: "Male")
                        
                        GenderButton(gender: $gender, title: "Female")
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.trailing)
                    .padding(.top, 10)
                    
                    HStack(spacing: 15) {
                        Text("Size")
                            .fontWeight(.heavy)
                            .foregroundColor(black)
                            .frame(width: 75, alignment: .leading)
                        
                        ForEach(sizes, id: \.self) { title in
                            SizeButton(size: $size, title: title)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.trailing)
                    .padding(.top, 10)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        added.toggle()
                    }) {
                        Label(title: {
                            Text(added ? "Added" : "Add to Bag")
                                .font(.title2)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                        }) {
                            Image(systemName: added ? "checkmark.circle.fill" : "cart.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            
                        }
                        .padding(.vertical, 12)
                        // padding 30 + 45 = 75
                        .frame(width: width - 75)
                        .background(added ? Color.green : Color("red"))
                        .clipShape(Capsule())
                        .padding(.leading, -45)
                        .padding(.top)
                        .padding(.bottom, edges!.bottom == 0 ? 15 : edges!.bottom)
                    }
                }
                .padding(.leading, 45)
            }
            .background(Color.white)
            .shadow(radius: 0)
            .clipShape(CustomShape())
            .padding(.top, 30)
            .shadow(color: Color.black.opacity(0.12), radius: 5, x: -5, y: -10)
            
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft], cornerRadii: CGSize(width: 85, height: 85))
        
        return Path(path.cgPath)
    }
}

struct GenderButton: View {
    @Binding var gender: String
    var title: String
    var black = Color.black.opacity(0.7)
    
    var body: some View {
        Button(action: {
            gender = title
        }) {
            Text(title)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(gender == title ? .white : black)
                .padding(.vertical, 10)
                .frame(width: 80)
                .background(gender == title ? Color("red") : Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

struct SizeButton: View {
    @Binding var size: Int
    var title: Int
    var black = Color.black.opacity(0.7)
    
    var body: some View {
        Button(action: {
            size = title
        }) {
            Text("\(title)")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(size == title ? .white : black)
                .frame(width: 35, height: 35)
                .background(size == title ? Color("red") : Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
        }
    }
}

var sizes = [6,7,8,9,10]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
