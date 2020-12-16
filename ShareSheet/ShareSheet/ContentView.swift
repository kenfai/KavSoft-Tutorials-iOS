//
//  ContentView.swift
//  ShareSheet
//
//  Created by Ginger on 16/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var items: [Any] = []
    @State var showingSheet = false
    
    var body: some View {
        VStack {
            Image("pic")
                .resizable()
                .scaledToFit()
            
            Button(action: {
                // adding item to be shared
                items.removeAll()
                items.append(UIImage(named: "pic")!)
                
                showingSheet.toggle()
            }) {
                Text("Share")
                    .fontWeight(.heavy)
            }
        }
        .sheet(isPresented: $showingSheet) {
            ShareSheet(items: items)
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    // the data you need to share
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        //
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
