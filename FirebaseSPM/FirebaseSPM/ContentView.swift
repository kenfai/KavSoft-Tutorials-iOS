//
//  ContentView.swift
//  FirebaseSPM
//
//  Created by Ginger on 25/12/2020.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("Firestore SPM")
        }
    }
}

struct Home: View {
    @StateObject var data = ModelData()
    
    var body: some View {
        VStack {
            List(data.allMsgs, id: \.id) { message in
                VStack(alignment: .leading, spacing: 10) {
                    Text(message.msg)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    // Date amd Time
                    HStack(spacing: 10) {
                        Text(message.time?.dateValue() ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text(message.time?.dateValue() ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
            }
            .padding(.top)
            
            HStack(spacing: 15) {
                TextField("Message", text: $data.message)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: data.writeMsg) {
                    Text("Send")
                        .fontWeight(.heavy)
                }
            }
            .padding()
        }
    }
}

class ModelData: ObservableObject {
    @Published var allMsgs: [Model] = []
    let dbRef = Firestore.firestore()
    @Published var message = ""
    
    init() {
        readAllMsgs()
    }
    
    func readAllMsgs() {
        dbRef.collection("Users").order(by: "time", descending: false).addSnapshotListener { snap, err in
            guard let msgData = snap else { return }
            
            self.allMsgs = msgData.documents.compactMap({ (doc) -> Model? in
                return try! doc.data(as: Model.self)
            })
        }
    }
    
    func writeMsg() {
        let doc = Model(msg: message)
        
        let _ = try! dbRef.collection("Users").addDocument(from: doc) { err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.message = ""
        }
    }
}

// Model
struct Model: Codable {
    // it will fetch doc id while reading
    // and writing it use the given id as doc id
    @DocumentID var id: String?
    // For fetching date and time
    @ServerTimestamp var time: Timestamp?
    
    var msg: String
    
    enum CodingKeys: String, CodingKey {
        // if you have a different key in firestore can provide it here
        case id
        case time
        case msg = "message"
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
