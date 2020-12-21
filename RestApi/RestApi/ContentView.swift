//
//  ContentView.swift
//  RestApi
//
//  Created by Ginger on 21/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .navigationTitle("REST API")
        }
    }
}

struct Home: View {
    @StateObject var data = Server()
    
    var body: some View {
        VStack {
            if data.users.isEmpty {
                if data.noData {
                    Text("No Users Found")
                } else {
                    ProgressView()
                }
            } else {
                List {
                    ForEach(data.users, id: \.id) { user in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(user.name)
                                .fontWeight(.bold)
                            
                            Text(user.email)
                                .font(.caption)
                        }
                    }
                    .onDelete { indexset in
                        indexset.forEach { index in
                            data.deleteUser(id: data.users[index].id)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: data.newUser) {
                    Text("Create")
                }
            }
        }
    }
}

class Server: ObservableObject {
    @Published var users: [User] = []
    @Published var noData = false
    
    let url = "http://localhost:8000/api/users"
    
    init() {
        getUsers()
    }
    
    func setUser(name: String, email: String, password: String) {
        let session = URLSession(configuration: .default)
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "name=\(name)&email=\(email)&password=\(password)";
        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        session.dataTask(with: request) { data, _, error in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            guard let response = data else { return }
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "1" {
                self.getUsers()
            } else {
                print("Failed to create user")
            }
        }
        .resume()
    }
    
    func getUsers() {
        guard let validURL = URL(string: url) else { return }
        
        var request = URLRequest(url: validURL)
        
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, _, err in
            if err != nil {
                print(err!.localizedDescription)
                self.noData.toggle()
                return
            }
            
            guard let response = data else { return }
            
            if let users = try? JSONDecoder().decode([User].self, from: response) {
                DispatchQueue.main.async {
                    self.users = users
                    if users.isEmpty {
                        self.noData.toggle()
                        
                    }
                }
            } else {
                print("Error decoding data")
            }
        }
        .resume()
    }
    
    func deleteUser(id: Int) {
        guard let validURL = URL(string: url + "/\(id)") else { return }
        
        var request = URLRequest(url: validURL)
        
        request.httpMethod = "DELETE"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, _, err in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let response = data else { return }
            
            let status = String(data: response, encoding: .utf8) ?? ""
            
            if status == "1" {
                self.getUsers()
            } else {
                print("Failed to delete user")
            }
            
        }
        .resume()
    }
    
    func newUser() {
        // Alert View
        let alert = UIAlertController(title: "New User", message: "Create a new Account", preferredStyle: .alert)
        
        alert.addTextField { user in
            user.placeholder = "Name"
        }
        alert.addTextField { email in
            email.placeholder = "Email"
        }
        alert.addTextField { pass in
            pass.placeholder = "Password"
            pass.isSecureTextEntry = true
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: {_ in
            self.setUser(name: alert.textFields![0].text!, email: alert.textFields![1].text!, password: alert.textFields![2].text!)
        }))
        
        // presenting
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
}

struct User: Decodable {
    var id: Int
    var name: String
    var email: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
