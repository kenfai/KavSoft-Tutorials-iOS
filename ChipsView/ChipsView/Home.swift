//
//  Home.swift
//  ChipsView
//
//  Created by Ginger on 18/02/2021.
//

import SwiftUI

struct Home: View {
    @State var text = ""
    @State var chips: [[ChipData]] = [
        // Sample Data for testing
    ]
    
    var body: some View {
        VStack(spacing: 35) {
            
            ScrollView {
                // Chips View
                LazyVStack(alignment: .leading, spacing: 10) {
                    
                    // Since we're using Indices so we need to Specify id
                    ForEach(chips.indices, id: \.self) { index in
                        
                        HStack {
                            
                            // sometimes it asks us to specify Hashable in Data Model
                            ForEach(chips[index].indices, id: \.self) { chipIndex in
                                
                                HStack {
                                    Text(chips[index][chipIndex].chipText)
                                        .fontWeight(.semibold)
                                        .padding(.vertical, 10)
                                        .padding(.leading)
                                        .lineLimit(1)
                                    
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.gray)
                                        .frame(width: 20, height: 20)
                                        .contentShape(Circle())
                                        .onTapGesture {
                                            // Removing Data
                                            chips[index].remove(at: chipIndex)
                                            // If the inside Array is empty, remove that also
                                            if chips[index].isEmpty {
                                                chips.remove(at: index)
                                            }
                                        }
                                        .padding(.trailing)
                                }
                                .background(Capsule().stroke(Color.black, lineWidth: 1))
                                // Main Logic
                                    .overlay(
                                        GeometryReader { reader -> Color in
                                            // By using maxX Parameter we ca use Logic and determine if it exceeds or not
                                            let maxX = reader.frame(in: .global).maxX
                                            
                                            // Both Paddings = 30 + 30 = 60
                                            // Plus 10 for Extra
                                            
                                            // Doing Action only if the Item exceeds
                                            
                                            if maxX > UIScreen.main.bounds.width - 70 && !chips[index][chipIndex].isExceeded {
                                                
                                                // It is updating to each user interaction
                                                DispatchQueue.main.async {
                                                    
                                                    // Toggling that
                                                    chips[index][chipIndex].isExceeded = true
                                                    
                                                    // Getting Last Item
                                                    let lastItem = chips[index][chipIndex]
                                                    // removing Item from current Row
                                                    // inserting it as new item
                                                    chips.append([lastItem])
                                                    chips[index].remove(at: chipIndex)
                                                    
                                                }
                                            }
                                            
                                            return Color.clear
                                        }, alignment: .trailing
                                    )
                                .clipShape(Capsule())
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height / 3)
            // Border
            .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4), lineWidth: 1.5))
            
            // TextEditor
            TextEditor(text: $text)
                .padding()
            // Border with Fixed Size
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.4), lineWidth: 1.5))
            
            // Add Button
            Button(action: {
                // Adding Empty Array if there is Nothing
                if chips.isEmpty {
                    chips.append([])
                }
                
                // Adding Chip to Last Array
                chips[chips.count - 1].append(ChipData(chipText: text))
                // Clearing old Text in Editor
                text = ""
            }, label: {
                Text("Add Tag")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(4)
            })
            // Disabling button when Text is Empty
            .disabled(text == "")
            .opacity(text == "" ? 0.45 : 1)
        }
        .padding()
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
