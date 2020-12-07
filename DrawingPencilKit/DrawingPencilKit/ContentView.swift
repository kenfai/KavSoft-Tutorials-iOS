//
//  ContentView.swift
//  DrawingPencilKit
//
//  Created by Ginger on 07/12/2020.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    // default is pen
    
    var body: some View {
        NavigationView {
            // Drawing View
            DrawingView(canvas: $canvas, isDraw: $isDraw, type: $type, color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    // saving Image
                    SaveImage()
                }) {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }, trailing: HStack(spacing: 15) {
                    Button(action: {
                        // Erase tool
                        isDraw = false
                    }) {
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    
                    // Menu for InkType and Color
                    Menu {
                        // Color Picker
                        Button(action: {
                            colorPicker.toggle()
                        }) {
                            Label {
                                Text("Color")
                            } icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        
                        Button(action: {
                            // Changing tool
                            isDraw = true
                            type = .pencil
                        }) {
                            Label {
                                Text("Pencil")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pen
                        }) {
                            Label {
                                Text("Pen")
                            } icon: {
                                Image(systemName: "pencil.tip")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .marker
                        }) {
                            Label {
                                Text("Marker")
                            } icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }

                })
                .sheet(isPresented: $colorPicker) {
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
        }
    }
    
    func SaveImage() {
        // Getting image from canvas
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        // saving to albums
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct DrawingView: UIViewRepresentable {
    // to capture drawing for saving into album
    @Binding var canvas: PKCanvasView
    @Binding var isDraw: Bool
    @Binding var type: PKInkingTool.InkType
    @Binding var color: Color
    
    // updating inkType
    var ink: PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        // updating tool whenever main View updates
        uiView.tool = isDraw ? ink : eraser
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
