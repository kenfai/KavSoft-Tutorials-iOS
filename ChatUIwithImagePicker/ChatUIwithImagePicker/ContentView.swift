//
//  ContentView.swift
//  ChatUIwithImagePicker
//
//  Created by Ginger on 15/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var message = ""
    @State var imagePicker = false
    @State var imgData: Data = Data(count: 0)
    
    @StateObject var allMessages = Messages()
    
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "gear")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                        }
                    }
                    
                    VStack(spacing: 5) {
                        Text("Catherine")
                            .fontWeight(.bold)
                        
                        Text("Active")
                            .font(.caption)
                    }
                    .foregroundColor(.white)
                }
                .padding(.all)
                
                VStack {
                    // Displaying Message
                    ScrollView(.vertical, showsIndicators: true) {
                        ScrollViewReader { reader in
                            VStack(spacing: 20) {
                                ForEach(allMessages.messages) { msg in
                                    // Chat Bubbles
                                    ChatBubble(msg: msg)
                                }
                                // whenver a new data is inserted, scroll to bottom
                                .onChange(of: allMessages.messages) { value in
                                    // scrolling only user message
                                    if value.last!.myMsg {
                                        reader.scrollTo(value.last?.id)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 25)
                        }
                    }
                    
                }
                // since bottom edge is ignored,
                //.padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .padding(.bottom, 80)
                .background(Color.white)
                //.clipShape(RoundedShape())
                .clipShape(RoundedRectangle(cornerRadius: 35))
            }
            //.edgesIgnoringSafeArea(.bottom)
            //.background(Color("Color").edgesIgnoringSafeArea(.top))
            
            VStack {
                Spacer()
                
                HStack(spacing: 15) {
                    HStack(spacing: 15) {
                        TextField("Message", text: $message)
                        
                        Button(action: {
                            // toggling image picker
                            imagePicker.toggle()
                        }) {
                            Image(systemName: "paperclip.circle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.06))
                    .clipShape(Capsule())
                    
                    // Send Button
                    
                    // hiding view
                    if message != "" {
                        Button(action: {
                            // appending message
                            
                            // adding animation
                            
                            withAnimation(.easeIn) {
                                allMessages.messages.append(Message(id: Date(), message: message, myMsg: true, profilePic: "p1", photo: nil))
                            }
                            
                            message = ""
                        }) {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("Color"))
                            // rotating the image
                                .rotationEffect(.init(degrees: 45))
                                .padding(.vertical, 12)
                                .padding(.leading, 12)
                                .padding(.trailing, 17)
                                .background(Color.black.opacity(0.07))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.bottom)
                .padding(.horizontal)
                .background(Color.white)
                .animation(.easeOut)
            }
            
            // Full Screen Image Picker
            .fullScreenCover(isPresented: $imagePicker, onDismiss: {
                // whenever image picker closes, verify if image is selected or cancelled
                if imgData.count != 0 {
                    allMessages.writeMessage(id: Date(), msg: "", photo: imgData, myMsg: true, profilePic: "p1")
                }
            }) {
                ImagePicker(imagePicker: $imagePicker, imgData: $imgData)
            }
        }
        .background(Color("Color").edgesIgnoringSafeArea(.top))
    }
}

// Chat Bubbles
struct ChatBubble: View {
    var msg: Message
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if msg.myMsg {
                // pushing msg to left
                
                // Modying for Image
                
                // minimum space
                Spacer(minLength: 25)
                
                if msg.photo == nil {
                    Text(msg.message)
                    .padding(.all)
                    .background(Color.black.opacity(0.06))
                    .clipShape(BubbleArrow(myMsg: msg.myMsg))
                } else {
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                
                // profile large
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            } else {
                // pushing msg to the right
                
                // profile large
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                if msg.photo == nil {
                    Text(msg.message)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color("Color"))
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                } else {
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                
                // minimum space
                Spacer(minLength: 25)
            }
        }
        // Automatic Scroll To bottom
        // First Assigning Id To Each Row
        .id(msg.id)
    }
}

// Bubble Arrow
struct BubbleArrow: Shape {
    var myMsg: Bool
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: myMsg ? [.topLeft, .bottomLeft, .bottomRight] : [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

// Custom Rounded Shape
struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

// Model Data for Message

struct Message: Identifiable, Equatable {
    var id: Date
    var message: String
    var myMsg: Bool
    var profilePic: String
    var photo: Data?
}

class Messages: ObservableObject {
    @Published var messages: [Message] = []
    
    // sample data
    init() {
        let strings = ["Hii", "Hello!!", "What's up?", "What Are you doing?", "Nothing, just enjoying quarantine holidays.. you??", "Same :))", "Ohhh", "What about your country?", "Very very bad..", "Ok, be safe.", "Ok", "Bye"]
        
        for i in 0..<strings.count {
            // simple logic for two side message View
            messages.append(Message(id: Date(), message: strings[i], myMsg: i % 2 == 0, profilePic: i % 2 == 0 ? "p1" : "p2"))
        }
    }
    
    func writeMessage(id: Date, msg: String, photo: Data?, myMsg: Bool, profilePic: String) {
        messages.append(Message(id: id, message: msg, myMsg: myMsg, profilePic: profilePic, photo: photo))
    }
}

// Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var imagePicker: Bool
    @Binding var imgData: Data
    
    
    func makeUIViewController(context: Context) -> some UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(picker: self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(picker: ImagePicker) {
            parent = picker
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.imagePicker.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            parent.imgData = image.jpegData(compressionQuality: 0.6)!
            parent.imagePicker.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
