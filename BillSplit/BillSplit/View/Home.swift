//
//  Home.swift
//  BillSplit
//
//  Created by Ginger on 06/02/2021.
//

import SwiftUI

struct Home: View {
    // Total amount
    @State var bill: CGFloat = 75
    
    @State var payers = [
        
        Payer(image: "animoji2", name: "Andy", bgColor: Color("animojiColor2")),
        Payer(image: "animoji1", name: "Cody", bgColor: Color("animojiColor1")),
        Payer(image: "animoji3", name: "Steve", bgColor: Color("animojiColor3")),
    ]
    
    // Temp Offset
    @State var pay = false
    
    @State var sharedAmount: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button(action: {}, label: {
                        
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(Color("card"))
                            .padding()
                            .background(Color.black.opacity(0.25))
                            .cornerRadius(15)
                    })
                    
                    Spacer()
                }
                .padding()
                
                // Bill Card View
                VStack(spacing: 15) {
                    Button(action: {}, label: {
                        Text("Receipt")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color("bg"))
                            .cornerRadius(12)
                    })
                    
                    // Dotted Lines
                    Line()
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 1, lineCap: .butt, lineJoin: .miter, dash: [10]))
                        .frame(height: 1)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Title")
                                .font(.caption)
                            
                            Text("Team Dinner")
                                .font(.title2)
                                .fontWeight(.heavy)
                        }
                        .foregroundColor(Color("bg"))
                        .frame(maxWidth: .infinity)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Total Bill")
                                .font(.caption)
                            
                            Text("$\(Int(bill))")
                                .font(.title2)
                                .fontWeight(.heavy)
                        }
                        .foregroundColor(Color("bg"))
                        .frame(maxWidth: .infinity)
                        .padding(.top, 10)
                    }
                    
                    // Animoji Viwes
                    VStack {
                        HStack(spacing: -20) {
                            
                            ForEach(payers) { payer in
                                
                                Image(payer.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45, height: 45)
                                    .padding(8)
                                    .background(payer.bgColor)
                                    .clipShape(Circle())
                            }
                        }
                        
                        Text("Splitting With")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("bg"))
                    .cornerRadius(25)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("card").clipShape(BillShape()).cornerRadius(25))
                .padding(.horizontal)
                
                ForEach(payers.indices) { index in
                    PriceView(payer: $payers[index], totalAmount: bill, payers: $payers, sharedAmount: $sharedAmount)
                }
                
                Spacer(minLength: 25)
                
                // Pay Button
                HStack {
                    
                    HStack(spacing: 0) {
                        ForEach(1...6, id: \.self) { index in
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20, weight: .heavy))
                                .foregroundColor(Color.white.opacity(Double(index) * 0.06))
                        }
                    }
                    .padding(.leading, 45)
                    
                    Spacer()
                    
                    Button(action: {
                        pay.toggle()
                    }, label: {
                        Text("Confirm Split")
                            .fontWeight(.bold)
                            .foregroundColor(Color("card"))
                            .padding(.horizontal, 25)
                            .padding(.vertical)
                            .background(Color("bg"))
                            .clipShape(Capsule())
                    })
                }
                .padding()
                .background(Color.black.opacity(0.25))
                .clipShape(Capsule())
                .padding(.horizontal)
            }
        }
        .background(Color("bg").ignoresSafeArea(.all, edges: .all))
        // Alert View
        .alert(isPresented: $pay) {
            Alert(title: Text("Alert"), message: Text("Confirm to split pay?"), primaryButton: .default(Text("Pay")) {
                // Do some code here
            }, secondaryButton: .destructive(Text("Cancel")) {
                // do some code here
            })
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
