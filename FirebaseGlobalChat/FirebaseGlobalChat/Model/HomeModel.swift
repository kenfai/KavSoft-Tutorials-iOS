//
//  HomeModel.swift
//  FirebaseGlobalChat
//
//  Created by Ginger on 29/12/2020.
//

import SwiftUI
import Firebase

class HomeModel: ObservableObject {
    @Published var txt = ""
    @Published var msgs: [MsgModel] = []
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    
    init() {
        readAllMsgs()
    }
    
    func onAppear() {
        // Checking whether user is joined already
        if user == "" {
            // Join Alert
            UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
        }
    }
    
    func alertView() -> UIAlertController {
        let alert = UIAlertController(title: "Join Chat!", message: "Enter Nick Name", preferredStyle: .alert)
        
        alert.addTextField { (txt) in
            txt.placeholder = "e.g. Kavsoft"
        }
        
        let join = UIAlertAction(title: "Join", style: .default) { (_) in
            // checking for empty click
            let user = alert.textFields![0].text ?? ""
            
            if user != "" {
                self.user = user
                return
            }
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
        
        alert.addAction(join)
        
        return alert
    }
    
    func readAllMsgs() {
        ref.collection("Msgs").order(by: "timeStamp", descending: false).addSnapshotListener { snap, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else { return }
            
            data.documentChanges.forEach { doc in
                if doc.type == .added {
                    let msg = try! doc.document.data(as: MsgModel.self)!
                    
                    DispatchQueue.main.async {
                        self.msgs.append(msg)
                    }
                }
            }
        }
    }
    
    func writeMsg() {
        let msg = MsgModel(msg: txt, user: user, timeStamp: Date())
        
        let _ = try! ref.collection("Msgs").addDocument(from: msg) { err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            self.txt = ""
        }
    }
}
